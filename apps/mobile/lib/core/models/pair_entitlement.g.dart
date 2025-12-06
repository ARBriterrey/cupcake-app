// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pair_entitlement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PairEntitlementImpl _$$PairEntitlementImplFromJson(
        Map<String, dynamic> json) =>
    _$PairEntitlementImpl(
      id: json['id'] as String,
      pairId: json['pairId'] as String,
      sprinkleId: json['sprinkleId'] as String,
      isActive: json['isActive'] as bool,
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$PairEntitlementImplToJson(
        _$PairEntitlementImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pairId': instance.pairId,
      'sprinkleId': instance.sprinkleId,
      'isActive': instance.isActive,
      'expiresAt': instance.expiresAt?.toIso8601String(),
      'metadata': instance.metadata,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
