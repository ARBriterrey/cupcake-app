import 'package:hive/hive.dart';
import 'nudge.dart';

part 'nudge_local.g.dart';

@HiveType(typeId: 2) // 0=Calendar, 1=Journal, 2=Nudge
class NudgeLocal extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String pairId;

  @HiveField(2)
  late String senderId;

  @HiveField(3)
  late String receiverId;

  @HiveField(4)
  late String nudgeType;

  @HiveField(5)
  late DateTime createdAt;

  @HiveField(6)
  DateTime? viewedAt;

  @HiveField(7)
  late DateTime expiresAt;

  NudgeLocal({
    required this.id,
    required this.pairId,
    required this.senderId,
    required this.receiverId,
    required this.nudgeType,
    required this.createdAt,
    this.viewedAt,
    required this.expiresAt,
  });

  /// Convert to cloud model
  Nudge toNudge() {
    return Nudge(
      id: id,
      pairId: pairId,
      senderId: senderId,
      receiverId: receiverId,
      nudgeType: nudgeType,
      createdAt: createdAt,
      viewedAt: viewedAt,
      expiresAt: expiresAt,
    );
  }

  /// Create from cloud model
  static NudgeLocal fromNudge(Nudge nudge) {
    return NudgeLocal(
      id: nudge.id,
      pairId: nudge.pairId,
      senderId: nudge.senderId,
      receiverId: nudge.receiverId,
      nudgeType: nudge.nudgeType,
      createdAt: nudge.createdAt,
      viewedAt: nudge.viewedAt,
      expiresAt: nudge.expiresAt,
    );
  }

  /// Check if nudge has expired
  bool get isExpired => DateTime.now().isAfter(expiresAt);

  /// Check if nudge has been viewed
  bool get isViewed => viewedAt != null;

  /// Mark as viewed
  void markAsViewed() {
    viewedAt = DateTime.now();
  }
}
