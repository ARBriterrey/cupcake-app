import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_item.freezed.dart';
part 'list_item.g.dart';

@freezed
class ListItem with _$ListItem {
  const factory ListItem({
    required String id,
    @JsonKey(name: 'list_id') required String listId,
    required String title,
    String? description,

    // Assignment
    @JsonKey(name: 'assigned_to') String? assignedTo,
    @JsonKey(name: 'assigned_at') DateTime? assignedAt,

    // Completion
    @JsonKey(name: 'is_completed') @Default(false) bool isCompleted,
    @JsonKey(name: 'completed_by') String? completedBy,
    @JsonKey(name: 'completed_at') DateTime? completedAt,

    // Ordering
    @JsonKey(name: 'sort_order') @Default(0) int sortOrder,

    // Metadata
    @JsonKey(name: 'created_by') required String createdBy,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,

    // Soft delete
    @JsonKey(name: 'is_deleted') @Default(false) bool isDeleted,
    @JsonKey(name: 'deleted_at') DateTime? deletedAt,
    @JsonKey(name: 'deleted_by') String? deletedBy,
  }) = _ListItem;

  factory ListItem.fromJson(Map<String, dynamic> json) =>
      _$ListItemFromJson(json);
}
