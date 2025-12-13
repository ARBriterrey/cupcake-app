import 'package:hive/hive.dart';
import '../models/list_local.dart';
import '../models/list_item_local.dart';

class ListsLocalRepository {
  final Box<ListLocal> _listsBox;
  final Box<ListItemLocal> _itemsBox;

  ListsLocalRepository(this._listsBox, this._itemsBox);

  // ============================================================================
  // LISTS OPERATIONS
  // ============================================================================

  /// Save a list to local storage
  Future<void> saveList(ListLocal list) async {
    await _listsBox.put(list.id, list);
  }

  /// Get a list by ID
  ListLocal? getList(String id) {
    return _listsBox.get(id);
  }

  /// Get all active lists for a pair
  List<ListLocal> getListsForPair(String pairId) {
    return _listsBox.values
        .where((list) => list.pairId == pairId && !list.isDeleted)
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  /// Get all unsynced lists
  List<ListLocal> getUnsyncedLists() {
    return _listsBox.values.where((list) => !list.isSynced).toList();
  }

  /// Update a list
  Future<void> updateList(ListLocal list) async {
    list.updatedAt = DateTime.now();
    list.isSynced = false;
    await list.save();
  }

  /// Soft delete a list
  Future<void> softDeleteList(String id, String userId) async {
    final list = _listsBox.get(id);
    if (list != null) {
      list.softDelete(userId);
      await list.save();

      // Also soft delete all items in the list
      final items = getItemsForList(id);
      for (final item in items) {
        item.softDelete(userId);
        await item.save();
      }
    }
  }

  /// Delete a list permanently
  Future<void> deleteList(String id) async {
    await _listsBox.delete(id);
  }

  /// Get all lists
  List<ListLocal> getAllLists() {
    return _listsBox.values.toList();
  }

  // ============================================================================
  // LIST ITEMS OPERATIONS
  // ============================================================================

  /// Save a list item to local storage
  Future<void> saveItem(ListItemLocal item) async {
    await _itemsBox.put(item.id, item);
  }

  /// Get an item by ID
  ListItemLocal? getItem(String id) {
    return _itemsBox.get(id);
  }

  /// Get all active items for a list
  List<ListItemLocal> getItemsForList(String listId) {
    final items = _itemsBox.values
        .where((item) => item.listId == listId && !item.isDeleted)
        .toList()
      ..sort((a, b) {
        // Sort by sort_order first, then by created_at
        if (a.sortOrder != b.sortOrder) {
          return a.sortOrder.compareTo(b.sortOrder);
        }
        return a.createdAt.compareTo(b.createdAt);
      });
    return items;
  }

  /// Get incomplete items for a list
  List<ListItemLocal> getIncompleteItemsForList(String listId) {
    return getItemsForList(listId)
        .where((item) => !item.isCompleted)
        .toList();
  }

  /// Get unassigned items for a list (for Chit Jar)
  List<ListItemLocal> getUnassignedItemsForList(String listId) {
    return getItemsForList(listId)
        .where((item) => !item.isCompleted && item.assignedTo == null)
        .toList();
  }

  /// Get all unsynced items
  List<ListItemLocal> getUnsyncedItems() {
    return _itemsBox.values.where((item) => !item.isSynced).toList();
  }

  /// Update an item
  Future<void> updateItem(ListItemLocal item) async {
    item.updatedAt = DateTime.now();
    item.isSynced = false;
    await item.save();
  }

  /// Toggle item completion
  Future<void> toggleItemCompletion(String itemId, String userId) async {
    final item = _itemsBox.get(itemId);
    if (item != null) {
      item.toggleComplete(userId);
      await item.save();
    }
  }

  /// Assign item to user
  Future<void> assignItemToUser(String itemId, String userId) async {
    final item = _itemsBox.get(itemId);
    if (item != null) {
      item.assignTo(userId);
      await item.save();
    }
  }

  /// Soft delete an item
  Future<void> softDeleteItem(String id, String userId) async {
    final item = _itemsBox.get(id);
    if (item != null) {
      item.softDelete(userId);
      await item.save();
    }
  }

  /// Delete an item permanently
  Future<void> deleteItem(String id) async {
    await _itemsBox.delete(id);
  }

  /// Get all items
  List<ListItemLocal> getAllItems() {
    return _itemsBox.values.toList();
  }

  // ============================================================================
  // CLEANUP OPERATIONS
  // ============================================================================

  /// Clean up old deleted lists and items (30+ days)
  Future<void> cleanupOldDeleted() async {
    final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));

    // Clean up lists
    final oldDeletedLists = _listsBox.values
        .where((list) =>
            list.isDeleted &&
            list.deletedAt != null &&
            list.deletedAt!.isBefore(thirtyDaysAgo))
        .toList();

    for (final list in oldDeletedLists) {
      await _listsBox.delete(list.id);
    }

    // Clean up items
    final oldDeletedItems = _itemsBox.values
        .where((item) =>
            item.isDeleted &&
            item.deletedAt != null &&
            item.deletedAt!.isBefore(thirtyDaysAgo))
        .toList();

    for (final item in oldDeletedItems) {
      await _itemsBox.delete(item.id);
    }
  }
}
