// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collaborative_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CollaborativeListImpl _$$CollaborativeListImplFromJson(
        Map<String, dynamic> json) =>
    _$CollaborativeListImpl(
      id: json['id'] as String,
      pairId: json['pair_id'] as String,
      title: json['title'] as String,
      listType: $enumDecodeNullable(_$ListTypeEnumMap, json['list_type']) ??
          ListType.standard,
      description: json['description'] as String?,
      currentTurnUserId: json['current_turn_user_id'] as String?,
      lastPickAt: json['last_pick_at'] == null
          ? null
          : DateTime.parse(json['last_pick_at'] as String),
      createdBy: json['created_by'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      isDeleted: json['is_deleted'] as bool? ?? false,
      deletedAt: json['deleted_at'] == null
          ? null
          : DateTime.parse(json['deleted_at'] as String),
      deletedBy: json['deleted_by'] as String?,
    );

Map<String, dynamic> _$$CollaborativeListImplToJson(
        _$CollaborativeListImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pair_id': instance.pairId,
      'title': instance.title,
      'list_type': _$ListTypeEnumMap[instance.listType]!,
      'description': instance.description,
      'current_turn_user_id': instance.currentTurnUserId,
      'last_pick_at': instance.lastPickAt?.toIso8601String(),
      'created_by': instance.createdBy,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'is_deleted': instance.isDeleted,
      'deleted_at': instance.deletedAt?.toIso8601String(),
      'deleted_by': instance.deletedBy,
    };

const _$ListTypeEnumMap = {
  ListType.standard: 'standard',
  ListType.chitJar: 'chit_jar',
  ListType.shopping: 'shopping',
};
