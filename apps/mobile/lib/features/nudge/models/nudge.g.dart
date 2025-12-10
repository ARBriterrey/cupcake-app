// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nudge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NudgeImpl _$$NudgeImplFromJson(Map<String, dynamic> json) => _$NudgeImpl(
      id: json['id'] as String,
      pairId: json['pair_id'] as String,
      senderId: json['sender_id'] as String,
      receiverId: json['receiver_id'] as String,
      nudgeType: json['nudgeType'] as String? ?? 'thinking_of_you',
      createdAt: DateTime.parse(json['created_at'] as String),
      viewedAt: json['viewed_at'] == null
          ? null
          : DateTime.parse(json['viewed_at'] as String),
      expiresAt: DateTime.parse(json['expires_at'] as String),
    );

Map<String, dynamic> _$$NudgeImplToJson(_$NudgeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pair_id': instance.pairId,
      'sender_id': instance.senderId,
      'receiver_id': instance.receiverId,
      'nudgeType': instance.nudgeType,
      'created_at': instance.createdAt.toIso8601String(),
      'viewed_at': instance.viewedAt?.toIso8601String(),
      'expires_at': instance.expiresAt.toIso8601String(),
    };
