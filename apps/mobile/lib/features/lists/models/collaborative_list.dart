import 'package:freezed_annotation/freezed_annotation.dart';

part 'collaborative_list.freezed.dart';
part 'collaborative_list.g.dart';

enum ListType {
  standard,
  @JsonValue('chit_jar')
  chitJar,
  shopping,
}

@freezed
class CollaborativeList with _$CollaborativeList {
  const factory CollaborativeList({
    required String id,
    @JsonKey(name: 'pair_id') required String pairId,
    required String title,
    @JsonKey(name: 'list_type') @Default(ListType.standard) ListType listType,
    String? description,

    // Chit Jar specific
    @JsonKey(name: 'current_turn_user_id') String? currentTurnUserId,
    @JsonKey(name: 'last_pick_at') DateTime? lastPickAt,

    // Metadata
    @JsonKey(name: 'created_by') required String createdBy,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,

    // Soft delete
    @JsonKey(name: 'is_deleted') @Default(false) bool isDeleted,
    @JsonKey(name: 'deleted_at') DateTime? deletedAt,
    @JsonKey(name: 'deleted_by') String? deletedBy,
  }) = _CollaborativeList;

  factory CollaborativeList.fromJson(Map<String, dynamic> json) =>
      _$CollaborativeListFromJson(json);
}
