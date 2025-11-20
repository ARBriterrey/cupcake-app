// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pair_invitation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PairInvitationImpl _$$PairInvitationImplFromJson(Map<String, dynamic> json) =>
    _$PairInvitationImpl(
      id: json['id'] as String,
      fromUserId: json['fromUserId'] as String,
      toUserEmail: json['toUserEmail'] as String,
      toUserId: json['toUserId'] as String?,
      status: $enumDecode(_$InvitationStatusEnumMap, json['status']),
      message: json['message'] as String?,
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$PairInvitationImplToJson(
  _$PairInvitationImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'fromUserId': instance.fromUserId,
  'toUserEmail': instance.toUserEmail,
  'toUserId': instance.toUserId,
  'status': _$InvitationStatusEnumMap[instance.status]!,
  'message': instance.message,
  'expiresAt': instance.expiresAt?.toIso8601String(),
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};

const _$InvitationStatusEnumMap = {
  InvitationStatus.pending: 'pending',
  InvitationStatus.accepted: 'accepted',
  InvitationStatus.rejected: 'rejected',
  InvitationStatus.expired: 'expired',
};
