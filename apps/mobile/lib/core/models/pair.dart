import 'package:freezed_annotation/freezed_annotation.dart';

part 'pair.freezed.dart';
part 'pair.g.dart';

enum PairStatus {
  pending,
  active,
  inactive,
}

@freezed
class Pair with _$Pair {
  const factory Pair({
    required String id,
    @JsonKey(name: 'user1_id') required String user1Id,
    @JsonKey(name: 'user2_id') required String user2Id,
    required PairStatus status,
    @JsonKey(name: 'couple_name') String? coupleName,
    @JsonKey(name: 'anniversary_date') DateTime? anniversaryDate,
    @JsonKey(name: 'shared_preferences') @Default({}) Map<String, dynamic> sharedPreferences,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _Pair;

  factory Pair.fromJson(Map<String, dynamic> json) => _$PairFromJson(json);
}
