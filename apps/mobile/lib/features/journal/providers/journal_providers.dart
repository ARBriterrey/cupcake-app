import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'package:cupcake_core/core.dart';
import '../models/journal_entry_local.dart';
import '../repositories/journal_local_repository.dart';
import '../repositories/journal_repository.dart';
import 'journal_sync_provider.dart';

part 'journal_providers.g.dart';

// --- Repositories ---

@riverpod
JournalLocalRepository journalLocalRepository(JournalLocalRepositoryRef ref) {
  if (!Hive.isBoxOpen('journal_entries')) {
    throw Exception('Hive box "journal_entries" is not open. Ensure JournalSprinkle.initialize() is called.');
  }
  final box = Hive.box<JournalEntryLocal>('journal_entries');
  return JournalLocalRepository(box);
}

@riverpod
JournalRepository journalRepository(JournalRepositoryRef ref) {
  return JournalRepository(Supabase.instance.client);
}

// --- Queries ---

@riverpod
List<JournalEntryLocal> journalEntries(JournalEntriesRef ref, String pairId) {
  // Listen to the box to trigger rebuilds
  // We can't listen to the box directly in a simple way with riverpod without a stream, 
  // but we can use a StreamProvider or invalidate this provider manually when changes happen.
  // For simplicity starting with standard provider and relying on sync/actions to invalidate.
  // Ideally: ref.watch(journalSyncProvider) could trigger updates if that provider emits state.
  
  // Actually, let's make this auto-dispose and rely on the UI calling invalidate or 
  // using a stream from the repository if we add one.
  // For now, simpler:
  
  final repo = ref.watch(journalLocalRepositoryProvider);
  return repo.getEntriesForPair(pairId);
}

@riverpod
List<JournalEntryLocal> sharedJournalEntries(SharedJournalEntriesRef ref, String pairId) {
  final repo = ref.watch(journalLocalRepositoryProvider);
  return repo.getSharedEntries(pairId);
}

@riverpod
List<JournalEntryLocal> privateJournalEntries(PrivateJournalEntriesRef ref, String pairId, String userId) {
  final repo = ref.watch(journalLocalRepositoryProvider);
  return repo.getPrivateEntries(pairId, userId);
}


// --- Controllers ---

@riverpod
class JournalEntryCreator extends _$JournalEntryCreator {
  @override
  FutureOr<void> build() {}

  Future<JournalEntryLocal> createEntry({
    required String pairId,
    required String userId, // Auth user
    required String title,
    required String body,
    EventVisibility visibility = EventVisibility.private,
    List<String> tags = const [],
    String? mood,
  }) async {
    state = const AsyncValue.loading();
    
    try {
      if (!Hive.isBoxOpen('journal_entries')) {
        await Hive.openBox<JournalEntryLocal>('journal_entries');
      }
      final localRepo = ref.read(journalLocalRepositoryProvider);
      final entryId = const Uuid().v4();
      
      // 1. Create local entry
      final entry = JournalEntryLocal.createNew(
        id: entryId,
        pairId: pairId,
        userId: userId,
        title: title,
        body: body,
        visibility: visibility,
      );
      entry.tags = tags;
      entry.mood = mood;
      
      await localRepo.saveEntry(entry);

      // TODO: 2. Emit domain event for Calendar integration (EventBus not implemented yet)
      // EventBus().emit(JournalEntryCreatedEvent(
      //   entryId: entry.id,
      //   pairId: entry.pairId,
      //   createdBy: entry.createdBy!,
      //   title: entry.title,
      //   createdAt: entry.createdAt,
      //   visibility: entry.visibilityEnum,
      //   visibleToUserId: entry.visibleToUserId,
      // ));

      // 3. Trigger sync
      ref.read(journalSyncProvider.notifier).syncEntry(entryId);
      
      // 4. Invalidate queries
      ref.invalidate(journalEntriesProvider(pairId));
      ref.invalidate(sharedJournalEntriesProvider(pairId));
      if (visibility == EventVisibility.private) {
        ref.invalidate(privateJournalEntriesProvider(pairId, userId));
      }
      
      state = const AsyncValue.data(null);
      return entry;
    } catch (e, st) {
      print('Error creating journal entry: $e');
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }
}

@riverpod
class JournalEntryUpdater extends _$JournalEntryUpdater {
  @override
  FutureOr<void> build() {}
  
  Future<void> updateEntry(JournalEntryLocal entry) async {
    state = const AsyncValue.loading();
    
    try {
      if (!Hive.isBoxOpen('journal_entries')) {
        await Hive.openBox<JournalEntryLocal>('journal_entries');
      }
      final localRepo = ref.read(journalLocalRepositoryProvider);
      await localRepo.updateEntry(entry);

      // TODO: Emit update event (EventBus not implemented yet)
      // EventBus().emit(JournalEntryUpdatedEvent(
      //   entryId: entry.id,
      //   title: entry.title,
      //   visibility: entry.visibilityEnum,
      //   visibleToUserId: entry.visibleToUserId,
      //   updatedAt: entry.updatedAt,
      // ));

      // Trigger sync
      ref.read(journalSyncProvider.notifier).syncEntry(entry.id);
      
      // Invalidate queries
      ref.invalidate(journalEntriesProvider(entry.pairId));
      ref.invalidate(sharedJournalEntriesProvider(entry.pairId));
      // Invalidate private just in case
      if (entry.createdBy != null) {
        ref.invalidate(privateJournalEntriesProvider(entry.pairId, entry.createdBy!));
      }
      
      state = const AsyncValue.data(null);
    } catch (e, st) {
      print('Error updating journal entry: $e');
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }
  
  Future<void> shareEntry(JournalEntryLocal entry, String shareWithUserId) async {
    entry.visibility = 'shared';
    entry.visibleToUserId = shareWithUserId;
    
    await updateEntry(entry);

    // TODO: Emit share event (EventBus not implemented yet)
    // EventBus().emit(JournalEntrySharedEvent(
    //   entryId: entry.id,
    //   pairId: entry.pairId,
    //   sharedWithUserId: shareWithUserId,
    // ));
  }
}

@riverpod
class JournalEntryDeleter extends _$JournalEntryDeleter {
  @override
  FutureOr<void> build() {}
  
  Future<void> deleteEntry(String entryId, String pairId, [String? calendarEventId]) async {
    state = const AsyncValue.loading();
    try {
      if (!Hive.isBoxOpen('journal_entries')) {
        await Hive.openBox<JournalEntryLocal>('journal_entries');
      }
      final localRepo = ref.read(journalLocalRepositoryProvider);
      await localRepo.softDeleteEntry(entryId);

      // TODO: Emit delete event (EventBus not implemented yet)
      // EventBus().emit(JournalEntryDeletedEvent(
      //   entryId: entryId,
      //   pairId: pairId,
      //   calendarEventId: calendarEventId,
      // ));

      // Trigger sync (to propagate delete to cloud)
      ref.read(journalSyncProvider.notifier).syncEntry(entryId);
      
      // Invalidate
      ref.invalidate(journalEntriesProvider(pairId));
      ref.invalidate(sharedJournalEntriesProvider(pairId));
      // Can't easily invalidate private without userId, but that's okay, main list usually reloads
      
      state = const AsyncValue.data(null);
    } catch (e, st) {
      print('Error deleting journal entry: $e');
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }
}
