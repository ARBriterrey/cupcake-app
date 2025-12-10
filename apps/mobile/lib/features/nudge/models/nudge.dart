import 'package:freezed_annotation/freezed_annotation.dart';

part 'nudge.freezed.dart';
part 'nudge.g.dart';

@freezed
class Nudge with _$Nudge {
  const factory Nudge({
    required String id,
    @JsonKey(name: 'pair_id') required String pairId,
    @JsonKey(name: 'sender_id') required String senderId,
    @JsonKey(name: 'receiver_id') required String receiverId,
    @Default('thinking_of_you') String nudgeType,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'viewed_at') DateTime? viewedAt,
    @JsonKey(name: 'expires_at') required DateTime expiresAt,
  }) = _Nudge;

  factory Nudge.fromJson(Map<String, dynamic> json) => _$NudgeFromJson(json);
}
