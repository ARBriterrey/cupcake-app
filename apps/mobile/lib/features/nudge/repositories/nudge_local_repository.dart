import 'package:hive/hive.dart';
import '../models/nudge_local.dart';

class NudgeLocalRepository {
  final Box<NudgeLocal> _box;

  NudgeLocalRepository(this._box);

  /// Save nudge to local storage
  Future<void> saveNudge(NudgeLocal nudge) async {
    await _box.put(nudge.id, nudge);
  }

  /// Get nudge by ID
  NudgeLocal? getNudge(String id) {
    return _box.get(id);
  }

  /// Get unviewed nudges for a user
  List<NudgeLocal> getUnviewedNudges(String userId) {
    return _box.values
        .where((nudge) =>
            nudge.receiverId == userId &&
            !nudge.isViewed &&
            !nudge.isExpired)
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  /// Get recent nudges for a pair
  List<NudgeLocal> getRecentNudges(String pairId, {int limit = 10}) {
    final nudges = _box.values
        .where((nudge) => nudge.pairId == pairId)
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return nudges.take(limit).toList();
  }

  /// Mark nudge as viewed
  Future<void> markAsViewed(String id) async {
    final nudge = _box.get(id);
    if (nudge != null) {
      nudge.markAsViewed();
      await nudge.save();
    }
  }

  /// Delete nudge
  Future<void> deleteNudge(String id) async {
    await _box.delete(id);
  }

  /// Clean up expired nudges
  Future<void> cleanupExpiredNudges() async {
    final expiredKeys = _box.values
        .where((nudge) => nudge.isExpired)
        .map((nudge) => nudge.id)
        .toList();

    for (final key in expiredKeys) {
      await _box.delete(key);
    }
  }

  /// Get all nudges
  List<NudgeLocal> getAllNudges() {
    return _box.values.toList();
  }
}
