import 'package:hive/hive.dart';
import 'package:cupcake_core/core.dart';
import '../models/journal_entry_local.dart';

class JournalLocalRepository {
  final Box<JournalEntryLocal> _box;

  JournalLocalRepository(this._box);

  Future<void> saveEntry(JournalEntryLocal entry) async {
    await _box.put(entry.id, entry);
  }

  JournalEntryLocal? getEntryById(String id) {
    return _box.get(id);
  }

  List<JournalEntryLocal> getEntriesForPair(String pairId) {
    return _box.values
        .where((e) => e.pairId == pairId && !e.isDeleted)
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  List<JournalEntryLocal> getSharedEntries(String pairId) {
    return _box.values
        .where((e) => e.pairId == pairId && 
                      e.visibility == 'shared' && 
                      !e.isDeleted)
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }
  
  List<JournalEntryLocal> getPrivateEntries(String pairId, String userId) {
    return _box.values
        .where((e) => e.pairId == pairId && 
                      e.visibility == 'private' && 
                      (e.createdBy == userId || e.visibleToUserId == userId) &&
                      !e.isDeleted)
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  Future<void> updateEntry(JournalEntryLocal entry) async {
    entry.updatedAt = DateTime.now();
    entry.isSynced = false;
    await entry.save();
  }

  Future<void> softDeleteEntry(String id) async {
    final entry = _box.get(id);
    if (entry != null) {
      entry.markForDeletion();
      await entry.save();
    }
  }

  /// Get entries that need to be synced to the cloud
  List<JournalEntryLocal> getUnsyncedEntries() {
    return _box.values.where((e) => !e.isSynced).toList();
  }

  Future<void> markAsSynced(String id) async {
    final entry = _box.get(id);
    if (entry != null) {
      entry.isSynced = true;
      entry.isPendingDelete = false; // If it was a delete that synced, it's done
      entry.lastSyncAttempt = DateTime.now();
      await entry.save();
    }
  }
  
  /// Permenantly remove entries deleted more than 30 days ago
  Future<void> cleanupDeletedEntries() async {
    final threshold = DateTime.now().subtract(const Duration(days: 30));
    final idsToDelete = _box.values
        .where((e) => e.isDeleted && e.deletedAt != null && e.deletedAt!.isBefore(threshold))
        .map((e) => e.id)
        .toList();
        
    await _box.deleteAll(idsToDelete);
  }
}
