import 'package:freezed_annotation/freezed_annotation.dart';

part 'pair_entitlement.freezed.dart';
part 'pair_entitlement.g.dart';

@freezed
class PairEntitlement with _$PairEntitlement {
  const factory PairEntitlement({
    required String id,
    required String pairId,
    required String sprinkleId,
    required bool isActive,
    DateTime? expiresAt,
    @Default({}) Map<String, dynamic> metadata,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _PairEntitlement;

  factory PairEntitlement.fromJson(Map<String, dynamic> json) =>
      _$PairEntitlementFromJson(json);
}
