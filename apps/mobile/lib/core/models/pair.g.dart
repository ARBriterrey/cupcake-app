// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pair.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PairImpl _$$PairImplFromJson(Map<String, dynamic> json) => _$PairImpl(
  id: json['id'] as String,
  user1Id: json['user1_id'] as String,
  user2Id: json['user2_id'] as String,
  status: $enumDecode(_$PairStatusEnumMap, json['status']),
  coupleName: json['couple_name'] as String?,
  anniversaryDate: json['anniversary_date'] == null
      ? null
      : DateTime.parse(json['anniversary_date'] as String),
  sharedPreferences:
      json['shared_preferences'] as Map<String, dynamic>? ?? const {},
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$$PairImplToJson(_$PairImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user1_id': instance.user1Id,
      'user2_id': instance.user2Id,
      'status': _$PairStatusEnumMap[instance.status]!,
      'couple_name': instance.coupleName,
      'anniversary_date': instance.anniversaryDate?.toIso8601String(),
      'shared_preferences': instance.sharedPreferences,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

const _$PairStatusEnumMap = {
  PairStatus.pending: 'pending',
  PairStatus.active: 'active',
  PairStatus.inactive: 'inactive',
};
