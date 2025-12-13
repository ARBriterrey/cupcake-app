import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hive/hive.dart';
import '../models/collaborative_list.dart';
import '../models/list_local.dart';
import '../models/list_item.dart';
import '../models/list_item_local.dart';
import '../repositories/lists_repository.dart';
import '../repositories/lists_local_repository.dart';

part 'lists_providers.g.dart';

// ============================================================================
// REPOSITORIES
// ============================================================================

@riverpod
ListsRepository listsRepository(ListsRepositoryRef ref) {
  return ListsRepository(Supabase.instance.client);
}

@riverpod
ListsLocalRepository listsLocalRepository(ListsLocalRepositoryRef ref) {
  if (!Hive.isBoxOpen('lists')) {
    throw Exception('Hive box "lists" is not open');
  }
  if (!Hive.isBoxOpen('list_items')) {
    throw Exception('Hive box "list_items" is not open');
  }
  final listsBox = Hive.box<ListLocal>('lists');
  final itemsBox = Hive.box<ListItemLocal>('list_items');
  return ListsLocalRepository(listsBox, itemsBox);
}

// ============================================================================
// QUERIES - LISTS
// ============================================================================

/// Stream of lists for a pair (real-time)
@riverpod
Stream<List<CollaborativeList>> listsForPair(ListsForPairRef ref, String pairId) {
  final repo = ref.watch(listsRepositoryProvider);
  return repo.watchListsForPair(pairId);
}

/// Get lists from local storage
@riverpod
List<ListLocal> listsLocal(ListsLocalRef ref, String pairId) {
  final repo = ref.watch(listsLocalRepositoryProvider);
  return repo.getListsForPair(pairId);
}

/// Get a single list
@riverpod
Future<CollaborativeList?> listById(ListByIdRef ref, String listId) async {
  final repo = ref.watch(listsRepositoryProvider);
  return repo.getList(listId);
}

// ============================================================================
// QUERIES - LIST ITEMS
// ============================================================================

/// Stream of items for a list (real-time)
@riverpod
Stream<List<ListItem>> itemsForList(ItemsForListRef ref, String listId) {
  final repo = ref.watch(listsRepositoryProvider);
  return repo.watchItemsForList(listId);
}

/// Get items from local storage
@riverpod
List<ListItemLocal> itemsLocal(ItemsLocalRef ref, String listId) {
  final repo = ref.watch(listsLocalRepositoryProvider);
  return repo.getItemsForList(listId);
}

/// Get incomplete items count for a list
@riverpod
int incompleteItemsCount(IncompleteItemsCountRef ref, String listId) {
  final itemsAsync = ref.watch(itemsForListProvider(listId));
  return itemsAsync.when(
    data: (items) => items.where((item) => !item.isCompleted).length,
    loading: () => 0,
    error: (_, __) => 0,
  );
}

/// Get unassigned items count for Chit Jar mode
@riverpod
Future<int> unassignedItemsCount(UnassignedItemsCountRef ref, String listId) async {
  final repo = ref.watch(listsRepositoryProvider);
  return repo.getUnassignedItemsCount(listId);
}

// ============================================================================
// ACTIONS - LISTS
// ============================================================================

@riverpod
class ListCreator extends _$ListCreator {
  @override
  FutureOr<void> build() {}

  Future<CollaborativeList> createList({
    required String pairId,
    required String title,
    required String userId,
    ListType listType = ListType.standard,
    String? description,
    String? currentTurnUserId,
  }) async {
    state = const AsyncValue.loading();

    try {
      final cloudRepo = ref.read(listsRepositoryProvider);
      final localRepo = ref.read(listsLocalRepositoryProvider);

      // 1. Create in cloud
      final list = await cloudRepo.createList(
        pairId: pairId,
        title: title,
        createdBy: userId,
        listType: listType,
        description: description,
        currentTurnUserId: currentTurnUserId,
      );

      // 2. Save to local
      final localList = ListLocal.fromCollaborativeList(list);
      await localRepo.saveList(localList);

      // 3. Invalidate queries
      ref.invalidate(listsForPairProvider(pairId));
      ref.invalidate(listsLocalProvider(pairId));

      state = const AsyncValue.data(null);
      return list;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }
}

@riverpod
class ListUpdater extends _$ListUpdater {
  @override
  FutureOr<void> build() {}

  Future<void> updateList({
    required String listId,
    required String pairId,
    String? title,
    String? description,
  }) async {
    state = const AsyncValue.loading();

    try {
      final cloudRepo = ref.read(listsRepositoryProvider);
      final localRepo = ref.read(listsLocalRepositoryProvider);

      // 1. Update in cloud
      final updatedList = await cloudRepo.updateList(
        listId: listId,
        title: title,
        description: description,
      );

      // 2. Update local
      final localList = ListLocal.fromCollaborativeList(updatedList);
      await localRepo.saveList(localList);

      // 3. Invalidate queries
      ref.invalidate(listsForPairProvider(pairId));
      ref.invalidate(listByIdProvider(listId));

      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }
}

@riverpod
class ListDeleter extends _$ListDeleter {
  @override
  FutureOr<void> build() {}

  Future<void> deleteList(String listId, String pairId, String userId) async {
    state = const AsyncValue.loading();

    try {
      final cloudRepo = ref.read(listsRepositoryProvider);
      final localRepo = ref.read(listsLocalRepositoryProvider);

      // 1. Soft delete in cloud
      await cloudRepo.softDeleteList(listId, userId);

      // 2. Soft delete locally
      await localRepo.softDeleteList(listId, userId);

      // 3. Invalidate queries
      ref.invalidate(listsForPairProvider(pairId));
      ref.invalidate(listsLocalProvider(pairId));

      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }
}

// ============================================================================
// ACTIONS - LIST ITEMS
// ============================================================================

@riverpod
class ListItemCreator extends _$ListItemCreator {
  @override
  FutureOr<void> build() {}

  Future<ListItem> createItem({
    required String listId,
    required String title,
    required String userId,
    String? description,
    String? assignedTo,
    int sortOrder = 0,
  }) async {
    state = const AsyncValue.loading();

    try {
      final cloudRepo = ref.read(listsRepositoryProvider);
      final localRepo = ref.read(listsLocalRepositoryProvider);

      // 1. Create in cloud
      final item = await cloudRepo.createListItem(
        listId: listId,
        title: title,
        createdBy: userId,
        description: description,
        assignedTo: assignedTo,
        sortOrder: sortOrder,
      );

      // 2. Save to local
      final localItem = ListItemLocal.fromListItem(item);
      await localRepo.saveItem(localItem);

      // 3. Invalidate queries
      ref.invalidate(itemsForListProvider(listId));
      ref.invalidate(itemsLocalProvider(listId));
      ref.invalidate(incompleteItemsCountProvider(listId));

      state = const AsyncValue.data(null);
      return item;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }
}

@riverpod
class ListItemUpdater extends _$ListItemUpdater {
  @override
  FutureOr<void> build() {}

  Future<void> toggleItemCompletion(
    String itemId,
    String listId,
    String userId,
  ) async {
    state = const AsyncValue.loading();

    try {
      final cloudRepo = ref.read(listsRepositoryProvider);
      final localRepo = ref.read(listsLocalRepositoryProvider);

      // 1. Toggle in cloud
      final updatedItem = await cloudRepo.toggleItemCompletion(itemId, userId);

      // 2. Update local
      final localItem = ListItemLocal.fromListItem(updatedItem);
      await localRepo.saveItem(localItem);

      // 3. Invalidate queries
      ref.invalidate(itemsForListProvider(listId));
      ref.invalidate(incompleteItemsCountProvider(listId));

      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> updateItem({
    required String itemId,
    required String listId,
    String? title,
    String? description,
  }) async {
    state = const AsyncValue.loading();

    try {
      final cloudRepo = ref.read(listsRepositoryProvider);
      final localRepo = ref.read(listsLocalRepositoryProvider);

      // 1. Update in cloud
      final updatedItem = await cloudRepo.updateListItem(
        itemId: itemId,
        title: title,
        description: description,
      );

      // 2. Update local
      final localItem = ListItemLocal.fromListItem(updatedItem);
      await localRepo.saveItem(localItem);

      // 3. Invalidate queries
      ref.invalidate(itemsForListProvider(listId));

      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }
}

@riverpod
class ListItemDeleter extends _$ListItemDeleter {
  @override
  FutureOr<void> build() {}

  Future<void> deleteItem(String itemId, String listId, String userId) async {
    state = const AsyncValue.loading();

    try {
      final cloudRepo = ref.read(listsRepositoryProvider);
      final localRepo = ref.read(listsLocalRepositoryProvider);

      // 1. Soft delete in cloud
      await cloudRepo.softDeleteListItem(itemId, userId);

      // 2. Soft delete locally
      await localRepo.softDeleteItem(itemId, userId);

      // 3. Invalidate queries
      ref.invalidate(itemsForListProvider(listId));
      ref.invalidate(incompleteItemsCountProvider(listId));

      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }
}

// ============================================================================
// ACTIONS - CHIT JAR
// ============================================================================

@riverpod
class ChitJarPicker extends _$ChitJarPicker {
  @override
  FutureOr<void> build() {}

  Future<String?> pickRandomItem(String listId, String pairId, String userId) async {
    state = const AsyncValue.loading();

    try {
      final cloudRepo = ref.read(listsRepositoryProvider);

      // Pick random item (this also updates assignment and turn)
      final pickedItemId = await cloudRepo.pickChitJarItem(listId, userId);

      // Invalidate queries to refresh UI
      ref.invalidate(itemsForListProvider(listId));
      ref.invalidate(listByIdProvider(listId));
      ref.invalidate(listsForPairProvider(pairId));
      ref.invalidate(unassignedItemsCountProvider(listId));

      state = const AsyncValue.data(null);
      return pickedItemId;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }
}
