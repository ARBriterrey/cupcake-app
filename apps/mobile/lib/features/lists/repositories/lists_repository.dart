import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/collaborative_list.dart';
import '../models/list_item.dart';

class ListsRepository {
  final SupabaseClient _supabase;

  ListsRepository(this._supabase);

  // ============================================================================
  // LISTS OPERATIONS
  // ============================================================================

  /// Create a new list
  Future<CollaborativeList> createList({
    required String pairId,
    required String title,
    required String createdBy,
    ListType listType = ListType.standard,
    String? description,
    String? currentTurnUserId,
  }) async {
    final response = await _supabase.from('lists').insert({
      'pair_id': pairId,
      'title': title,
      'list_type': listType.name,
      'description': description,
      'created_by': createdBy,
      'current_turn_user_id': currentTurnUserId,
    }).select().single();

    return CollaborativeList.fromJson(response);
  }

  /// Get all active lists for a pair
  Future<List<CollaborativeList>> getListsForPair(String pairId) async {
    final response = await _supabase
        .from('lists')
        .select()
        .eq('pair_id', pairId)
        .eq('is_deleted', false)
        .order('created_at', ascending: false);

    return (response as List)
        .map((json) => CollaborativeList.fromJson(json))
        .toList();
  }

  /// Watch lists for a pair (real-time)
  Stream<List<CollaborativeList>> watchListsForPair(String pairId) {
    return _supabase
        .from('lists')
        .stream(primaryKey: ['id'])
        .eq('pair_id', pairId)
        .order('created_at', ascending: false)
        .map((data) {
          return data
              .where((json) => json['is_deleted'] == false)
              .map((json) => CollaborativeList.fromJson(json))
              .toList();
        });
  }

  /// Get a single list by ID
  Future<CollaborativeList?> getList(String listId) async {
    final response = await _supabase
        .from('lists')
        .select()
        .eq('id', listId)
        .eq('is_deleted', false)
        .maybeSingle();

    if (response == null) return null;
    return CollaborativeList.fromJson(response);
  }

  /// Update list
  Future<CollaborativeList> updateList({
    required String listId,
    String? title,
    String? description,
    String? currentTurnUserId,
    DateTime? lastPickAt,
  }) async {
    final updates = <String, dynamic>{};
    if (title != null) updates['title'] = title;
    if (description != null) updates['description'] = description;
    if (currentTurnUserId != null) {
      updates['current_turn_user_id'] = currentTurnUserId;
    }
    if (lastPickAt != null) updates['last_pick_at'] = lastPickAt.toIso8601String();

    final response = await _supabase
        .from('lists')
        .update(updates)
        .eq('id', listId)
        .select()
        .single();

    return CollaborativeList.fromJson(response);
  }

  /// Soft delete a list
  Future<void> softDeleteList(String listId, String userId) async {
    await _supabase.rpc('soft_delete_list', params: {
      'list_id_param': listId,
      'user_id_param': userId,
    });
  }

  // ============================================================================
  // LIST ITEMS OPERATIONS
  // ============================================================================

  /// Create a new list item
  Future<ListItem> createListItem({
    required String listId,
    required String title,
    required String createdBy,
    String? description,
    String? assignedTo,
    int sortOrder = 0,
  }) async {
    final response = await _supabase.from('list_items').insert({
      'list_id': listId,
      'title': title,
      'description': description,
      'created_by': createdBy,
      'assigned_to': assignedTo,
      'sort_order': sortOrder,
      if (assignedTo != null) 'assigned_at': DateTime.now().toIso8601String(),
    }).select().single();

    return ListItem.fromJson(response);
  }

  /// Get all active items for a list
  Future<List<ListItem>> getItemsForList(String listId) async {
    final response = await _supabase
        .from('list_items')
        .select()
        .eq('list_id', listId)
        .eq('is_deleted', false)
        .order('sort_order', ascending: true)
        .order('created_at', ascending: true);

    return (response as List)
        .map((json) => ListItem.fromJson(json))
        .toList();
  }

  /// Watch items for a list (real-time)
  Stream<List<ListItem>> watchItemsForList(String listId) {
    return _supabase
        .from('list_items')
        .stream(primaryKey: ['id'])
        .eq('list_id', listId)
        .order('sort_order', ascending: true)
        .map((data) {
          return data
              .where((json) => json['is_deleted'] == false)
              .map((json) => ListItem.fromJson(json))
              .toList();
        });
  }

  /// Update list item
  Future<ListItem> updateListItem({
    required String itemId,
    String? title,
    String? description,
    String? assignedTo,
    bool? isCompleted,
    String? completedBy,
    int? sortOrder,
  }) async {
    final updates = <String, dynamic>{};
    if (title != null) updates['title'] = title;
    if (description != null) updates['description'] = description;
    if (assignedTo != null) {
      updates['assigned_to'] = assignedTo;
      updates['assigned_at'] = DateTime.now().toIso8601String();
    }
    if (isCompleted != null) {
      updates['is_completed'] = isCompleted;
      if (isCompleted && completedBy != null) {
        updates['completed_by'] = completedBy;
        updates['completed_at'] = DateTime.now().toIso8601String();
      } else if (!isCompleted) {
        updates['completed_by'] = null;
        updates['completed_at'] = null;
      }
    }
    if (sortOrder != null) updates['sort_order'] = sortOrder;

    final response = await _supabase
        .from('list_items')
        .update(updates)
        .eq('id', itemId)
        .select()
        .single();

    return ListItem.fromJson(response);
  }

  /// Toggle item completion
  Future<ListItem> toggleItemCompletion(String itemId, String userId) async {
    // First get current state
    final current = await _supabase
        .from('list_items')
        .select()
        .eq('id', itemId)
        .single();

    final isCurrentlyCompleted = current['is_completed'] as bool;

    return updateListItem(
      itemId: itemId,
      isCompleted: !isCurrentlyCompleted,
      completedBy: !isCurrentlyCompleted ? userId : null,
    );
  }

  /// Soft delete a list item
  Future<void> softDeleteListItem(String itemId, String userId) async {
    await _supabase.rpc('soft_delete_list_item', params: {
      'item_id_param': itemId,
      'user_id_param': userId,
    });
  }

  // ============================================================================
  // CHIT JAR OPERATIONS
  // ============================================================================

  /// Pick a random item for Chit Jar mode
  Future<String?> pickChitJarItem(String listId, String userId) async {
    final result = await _supabase.rpc('pick_chit_jar_item', params: {
      'list_id_param': listId,
      'user_id_param': userId,
    });

    return result as String?;
  }

  /// Get unassigned items count for Chit Jar
  Future<int> getUnassignedItemsCount(String listId) async {
    final response = await _supabase
        .from('list_items')
        .select('id')
        .eq('list_id', listId)
        .eq('is_deleted', false)
        .eq('is_completed', false)
        .isFilter('assigned_to', null);

    return (response as List).length;
  }
}
