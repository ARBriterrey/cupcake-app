import 'package:hive/hive.dart';
import 'collaborative_list.dart';

part 'list_local.g.dart';

@HiveType(typeId: 3) // 0=Calendar, 1=Journal, 2=Nudge, 3=List, 4=ListItem
class ListLocal extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String pairId;

  @HiveField(2)
  late String title;

  @HiveField(3)
  late String listType; // 'standard', 'chit_jar', 'shopping'

  @HiveField(4)
  String? description;

  // Chit Jar specific
  @HiveField(5)
  String? currentTurnUserId;

  @HiveField(6)
  DateTime? lastPickAt;

  // Metadata
  @HiveField(7)
  late String createdBy;

  @HiveField(8)
  late DateTime createdAt;

  @HiveField(9)
  late DateTime updatedAt;

  // Soft delete
  @HiveField(10)
  bool isDeleted = false;

  @HiveField(11)
  DateTime? deletedAt;

  @HiveField(12)
  String? deletedBy;

  // Sync tracking
  @HiveField(13)
  bool isSynced = false;

  @HiveField(14)
  DateTime? lastSyncedAt;

  ListLocal({
    required this.id,
    required this.pairId,
    required this.title,
    required this.listType,
    this.description,
    this.currentTurnUserId,
    this.lastPickAt,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.isDeleted = false,
    this.deletedAt,
    this.deletedBy,
    this.isSynced = false,
    this.lastSyncedAt,
  });

  // Convert from cloud model
  factory ListLocal.fromCollaborativeList(CollaborativeList list) {
    return ListLocal(
      id: list.id,
      pairId: list.pairId,
      title: list.title,
      listType: list.listType.name,
      description: list.description,
      currentTurnUserId: list.currentTurnUserId,
      lastPickAt: list.lastPickAt,
      createdBy: list.createdBy,
      createdAt: list.createdAt,
      updatedAt: list.updatedAt,
      isDeleted: list.isDeleted,
      deletedAt: list.deletedAt,
      deletedBy: list.deletedBy,
      isSynced: true,
      lastSyncedAt: DateTime.now(),
    );
  }

  // Convert to cloud model
  CollaborativeList toCollaborativeList() {
    return CollaborativeList(
      id: id,
      pairId: pairId,
      title: title,
      listType: _parseListType(listType),
      description: description,
      currentTurnUserId: currentTurnUserId,
      lastPickAt: lastPickAt,
      createdBy: createdBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
      isDeleted: isDeleted,
      deletedAt: deletedAt,
      deletedBy: deletedBy,
    );
  }

  ListType _parseListType(String type) {
    switch (type) {
      case 'chit_jar':
        return ListType.chitJar;
      case 'shopping':
        return ListType.shopping;
      default:
        return ListType.standard;
    }
  }

  // Soft delete
  void softDelete(String userId) {
    isDeleted = true;
    deletedAt = DateTime.now();
    deletedBy = userId;
    isSynced = false;
  }
}
