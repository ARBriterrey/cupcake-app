// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pair_invitation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PairInvitationImpl _$$PairInvitationImplFromJson(Map<String, dynamic> json) =>
    _$PairInvitationImpl(
      id: json['id'] as String,
      fromUserId: json['from_user_id'] as String,
      toUserEmail: json['to_user_email'] as String,
      toUserId: json['to_user_id'] as String?,
      status: $enumDecode(_$InvitationStatusEnumMap, json['status']),
      message: json['message'] as String?,
      expiresAt: json['expires_at'] == null
          ? null
          : DateTime.parse(json['expires_at'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      fromUserName: json['from_user_name'] as String?,
    );

Map<String, dynamic> _$$PairInvitationImplToJson(
  _$PairInvitationImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'from_user_id': instance.fromUserId,
  'to_user_email': instance.toUserEmail,
  'to_user_id': instance.toUserId,
  'status': _$InvitationStatusEnumMap[instance.status]!,
  'message': instance.message,
  'expires_at': instance.expiresAt?.toIso8601String(),
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
  'from_user_name': instance.fromUserName,
};

const _$InvitationStatusEnumMap = {
  InvitationStatus.pending: 'pending',
  InvitationStatus.accepted: 'accepted',
  InvitationStatus.rejected: 'rejected',
  InvitationStatus.expired: 'expired',
};
