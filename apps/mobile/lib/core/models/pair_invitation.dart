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
    @JsonKey(name: 'from_user_id') required String fromUserId,
    @JsonKey(name: 'to_user_email') required String toUserEmail,
    @JsonKey(name: 'to_user_id') String? toUserId,
    required InvitationStatus status,
    String? message,
    @JsonKey(name: 'expires_at') DateTime? expiresAt,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
    // Sender profile info (populated via join)
    @JsonKey(name: 'from_user_name') String? fromUserName,
  }) = _PairInvitation;

  factory PairInvitation.fromJson(Map<String, dynamic> json) =>
      _$PairInvitationFromJson(json);
}
