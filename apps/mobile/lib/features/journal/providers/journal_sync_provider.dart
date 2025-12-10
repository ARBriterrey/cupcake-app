import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:logger/logger.dart';
import 'package:cupcake_core/core.dart';
import '../models/journal_entry.dart';
import '../models/journal_entry_local.dart';
import 'journal_providers.dart';

part 'journal_sync_provider.g.dart';

@riverpod
class JournalSync extends _$JournalSync {
  final _logger = Logger();

  @override
  void build() {
    // Start listening to realtime changes
    _initializeRealtimeSubscription();
    
    // Start background sync for pending local changes
    _syncPendingChanges();
    
    return;
  }

  void _initializeRealtimeSubscription() {
    final client = Supabase.instance.client;
    
    // Listen to all changes on journal_entries
    client
        .channel('public:journal_entries')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'journal_entries',
          callback: (payload) {
            _handleRealtimeEvent(payload);
          },
        )
        .subscribe();
  }

  Future<void> _handleRealtimeEvent(PostgresChangePayload payload) async {
    final localRepo = ref.read(journalLocalRepositoryProvider);
    
    try {
      if (payload.eventType == PostgresChangeEvent.insert || 
          payload.eventType == PostgresChangeEvent.update) {
            
        final newRecord = payload.newRecord;
        if (newRecord.isEmpty) return;
        
        final remoteEntry = JournalEntry.fromJson(newRecord);
        final localEntry = localRepo.getEntryById(remoteEntry.id);
        
        if (localEntry == null) {
          // New entry from cloud
          final newLocal = JournalEntryLocal.fromJournalEntry(remoteEntry);
          await localRepo.saveEntry(newLocal);
          
          // Emit created event if it's new to us (optional, careful of loops)
          // Usually we don't emit 'Created' for incoming sync to avoid duplicate calendar events
          // unless we check if calendar event exists in metadata.
        } else {
          // Update existing
          // Conflict resolution: Cloud wins for now (simpler), or check timestamps
          if (remoteEntry.updatedAt.isAfter(localEntry.updatedAt)) {
             localEntry.updateFrom(remoteEntry);
             await localRepo.saveEntry(localEntry);
          }
        }
        
      } else if (payload.eventType == PostgresChangeEvent.delete) {
        final oldRecord = payload.oldRecord;
        // Postgres delete payload might only have ID if configured REPLICA IDENTITY
        // But we use soft deletes mostly. Real deletes are just cleanup.
        final id = oldRecord['id'] as String?;
        if (id != null) {
          // Hard delete local if cloud hard deleted? Or soft delete?
          // If cloud hard deleted, we should probably hard delete.
          // But our system uses soft deletes.
          // Let's assume hard delete from cloud means "purge".
          final box = localRepo.getEntryById(id);
          if (box != null) {
             box.delete(); // Delete from hive
          }
        }
      }
      
      // Invalidate providers to refresh UI
      // We can't easily know which pairId to invalidate without looking up the entry
      // Ideally we'd broadcast a general "journal updated" signal.
      
    } catch (e) {
      _logger.e('Error handling journal realtime event', error: e);
    }
  }

  /// Trigger a sync for a specific entry (push local to cloud)
  Future<void> syncEntry(String entryId) async {
    final localRepo = ref.read(journalLocalRepositoryProvider);
    final cloudRepo = ref.read(journalRepositoryProvider);
    
    final entry = localRepo.getEntryById(entryId);
    if (entry == null || entry.isSynced) return;
    
    try {
      if (entry.isPendingDelete) {
        await cloudRepo.deleteEntry(entry.id);
        await localRepo.markAsSynced(entry.id);
      } else {
        // Upsert (Create or Update)
        final cloudModel = entry.toJournalEntry();
        
        // Try creating first (simplistic approach), or check if exists.
        // Supabase `upsert` is best if we can. 
        // Our repo defines create/update separately.
        // Let's try update, if fails then create, or useupsert if repo supported it.
        // Since we have UUID, we can check existance or just upsert.
        // Let's assume we use upsert logic in repo or just standard "id exists?"
        
        // Better: Check can be skipped if we know it's new vs modified.
        // But JournalEntryLocal doesn't strictly track "isNew".
        // Let's try upsert pattern manually:
        
        final existing = await cloudRepo.getEntryById(entry.id);
        if (existing == null) {
          await cloudRepo.createEntry(cloudModel);
        } else {
          await cloudRepo.updateEntry(cloudModel);
        }
        
        await localRepo.markAsSynced(entry.id);
      }
    } catch (e) {
      _logger.e('Failed to sync entry $entryId', error: e);
      // Leave isSynced = false, will retry later
    }
  }

  /// Sync all pending changes (startup/background)
  Future<void> _syncPendingChanges() async {
    final localRepo = ref.read(journalLocalRepositoryProvider);
    final unsynced = localRepo.getUnsyncedEntries();
    
    for (final entry in unsynced) {
      await syncEntry(entry.id);
    }
    
    // Also perform cleanup
    await localRepo.cleanupDeletedEntries();
  }
}
