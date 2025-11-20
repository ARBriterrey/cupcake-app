import 'package:freezed_annotation/freezed_annotation.dart';

part 'pair.freezed.dart';
part 'pair.g.dart';

@freezed
class Pair with _$Pair {
  const factory Pair({
    required String id,
    required String user1Id,
    required String user2Id,
    String? coupleName,
    DateTime? anniversaryDate,
    @Default({}) Map<String, dynamic> sharedPreferences,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Pair;

  factory Pair.fromJson(Map<String, dynamic> json) => _$PairFromJson(json);
}
