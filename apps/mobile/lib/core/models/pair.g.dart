// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pair.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PairImpl _$$PairImplFromJson(Map<String, dynamic> json) => _$PairImpl(
  id: json['id'] as String,
  user1Id: json['user1Id'] as String,
  user2Id: json['user2Id'] as String,
  coupleName: json['coupleName'] as String?,
  anniversaryDate: json['anniversaryDate'] == null
      ? null
      : DateTime.parse(json['anniversaryDate'] as String),
  sharedPreferences:
      json['sharedPreferences'] as Map<String, dynamic>? ?? const {},
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$$PairImplToJson(_$PairImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user1Id': instance.user1Id,
      'user2Id': instance.user2Id,
      'coupleName': instance.coupleName,
      'anniversaryDate': instance.anniversaryDate?.toIso8601String(),
      'sharedPreferences': instance.sharedPreferences,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
