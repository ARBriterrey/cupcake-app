import 'package:freezed_annotation/freezed_annotation.dart';

part 'pair_invitation.freezed.dart';
part 'pair_invitation.g.dart';

enum InvitationStatus {
  pending,
  accepted,
  rejected,
  expired,
}

@freezed
class PairInvitation with _$PairInvitation {
  const factory PairInvitation({
    required String id,
    required String fromUserId,
    required String toUserEmail,
    String? toUserId,
    required InvitationStatus status,
    String? message,
    DateTime? expiresAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _PairInvitation;

  factory PairInvitation.fromJson(Map<String, dynamic> json) =>
      _$PairInvitationFromJson(json);
}
