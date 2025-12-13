import 'package:hive/hive.dart';
import 'list_item.dart';

part 'list_item_local.g.dart';

@HiveType(typeId: 4) // 0=Calendar, 1=Journal, 2=Nudge, 3=List, 4=ListItem
class ListItemLocal extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String listId;

  @HiveField(2)
  late String title;

  @HiveField(3)
  String? description;

  // Assignment
  @HiveField(4)
  String? assignedTo;

  @HiveField(5)
  DateTime? assignedAt;

  // Completion
  @HiveField(6)
  bool isCompleted = false;

  @HiveField(7)
  String? completedBy;

  @HiveField(8)
  DateTime? completedAt;

  // Ordering
  @HiveField(9)
  int sortOrder = 0;

  // Metadata
  @HiveField(10)
  late String createdBy;

  @HiveField(11)
  late DateTime createdAt;

  @HiveField(12)
  late DateTime updatedAt;

  // Soft delete
  @HiveField(13)
  bool isDeleted = false;

  @HiveField(14)
  DateTime? deletedAt;

  @HiveField(15)
  String? deletedBy;

  // Sync tracking
  @HiveField(16)
  bool isSynced = false;

  @HiveField(17)
  DateTime? lastSyncedAt;

  ListItemLocal({
    required this.id,
    required this.listId,
    required this.title,
    this.description,
    this.assignedTo,
    this.assignedAt,
    this.isCompleted = false,
    this.completedBy,
    this.completedAt,
    this.sortOrder = 0,
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
  factory ListItemLocal.fromListItem(ListItem item) {
    return ListItemLocal(
      id: item.id,
      listId: item.listId,
      title: item.title,
      description: item.description,
      assignedTo: item.assignedTo,
      assignedAt: item.assignedAt,
      isCompleted: item.isCompleted,
      completedBy: item.completedBy,
      completedAt: item.completedAt,
      sortOrder: item.sortOrder,
      createdBy: item.createdBy,
      createdAt: item.createdAt,
      updatedAt: item.updatedAt,
      isDeleted: item.isDeleted,
      deletedAt: item.deletedAt,
      deletedBy: item.deletedBy,
      isSynced: true,
      lastSyncedAt: DateTime.now(),
    );
  }

  // Convert to cloud model
  ListItem toListItem() {
    return ListItem(
      id: id,
      listId: listId,
      title: title,
      description: description,
      assignedTo: assignedTo,
      assignedAt: assignedAt,
      isCompleted: isCompleted,
      completedBy: completedBy,
      completedAt: completedAt,
      sortOrder: sortOrder,
      createdBy: createdBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
      isDeleted: isDeleted,
      deletedAt: deletedAt,
      deletedBy: deletedBy,
    );
  }

  // Toggle completion
  void toggleComplete(String userId) {
    if (isCompleted) {
      isCompleted = false;
      completedBy = null;
      completedAt = null;
    } else {
      isCompleted = true;
      completedBy = userId;
      completedAt = DateTime.now();
    }
    updatedAt = DateTime.now();
    isSynced = false;
  }

  // Assign to user
  void assignTo(String userId) {
    assignedTo = userId;
    assignedAt = DateTime.now();
    updatedAt = DateTime.now();
    isSynced = false;
  }

  // Soft delete
  void softDelete(String userId) {
    isDeleted = true;
    deletedAt = DateTime.now();
    deletedBy = userId;
    isSynced = false;
  }
}
