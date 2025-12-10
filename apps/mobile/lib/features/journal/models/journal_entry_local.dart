import 'package:hive/hive.dart';
import 'package:cupcake_core/core.dart';
import 'journal_entry.dart';

part 'journal_entry_local.g.dart';

@HiveType(typeId: 1) // typeId 0 is CalendarEventLocal
class JournalEntryLocal extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String pairId;

  @HiveField(2)
  String? createdBy;

  @HiveField(3)
  late String title;

  @HiveField(4)
  late String body;

  @HiveField(5)
  late String visibility; // Stored as string 'private' or 'shared'

  @HiveField(6)
  String? visibleToUserId;

  @HiveField(7)
  List<String>? tags;

  @HiveField(8)
  String? mood;

  @HiveField(9)
  String? calendarEventId;

  @HiveField(10)
  late DateTime createdAt;

  @HiveField(11)
  late DateTime updatedAt;

  @HiveField(12)
  bool isDeleted;
  
  @HiveField(13)
  DateTime? deletedAt;

  // Sync metadata
  @HiveField(14)
  bool isSynced;
  
  @HiveField(15)
  DateTime? lastSyncAttempt;
  
  @HiveField(16)
  bool isPendingDelete;

  JournalEntryLocal({
    required this.id,
    required this.pairId,
    this.createdBy,
    required this.title,
    required this.body,
    required this.visibility,
    this.visibleToUserId,
    this.tags,
    this.mood,
    this.calendarEventId,
    required this.createdAt,
    required this.updatedAt,
    this.isDeleted = false,
    this.deletedAt,
    this.isSynced = false,
    this.lastSyncAttempt,
    this.isPendingDelete = false,
  });

  EventVisibility get visibilityEnum => visibility == 'shared' 
      ? EventVisibility.shared 
      : EventVisibility.private;

  /// Convert to Cloud Model
  JournalEntry toJournalEntry() {
    return JournalEntry(
      id: id,
      pairId: pairId,
      createdBy: createdBy,
      title: title,
      body: body,
      visibility: visibilityEnum,
      visibleToUserId: visibleToUserId,
      tags: tags ?? [],
      mood: mood,
      calendarEventId: calendarEventId,
      createdAt: createdAt,
      updatedAt: updatedAt,
      isDeleted: isDeleted,
      deletedAt: deletedAt,
    );
  }

  /// Create from Cloud Model
  static JournalEntryLocal fromJournalEntry(JournalEntry entry) {
    return JournalEntryLocal(
      id: entry.id,
      pairId: entry.pairId,
      createdBy: entry.createdBy,
      title: entry.title,
      body: entry.body,
      visibility: entry.visibility.name,
      visibleToUserId: entry.visibleToUserId,
      tags: entry.tags,
      mood: entry.mood,
      calendarEventId: entry.calendarEventId,
      createdAt: entry.createdAt,
      updatedAt: entry.updatedAt,
      isDeleted: entry.isDeleted,
      deletedAt: entry.deletedAt,
      isSynced: true, // Assumed synced if coming from cloud
    );
  }

  /// Create a new local entry (unsynced)
  static JournalEntryLocal createNew({
    required String id,
    required String pairId,
    required String userId,
    required String title,
    required String body,
    EventVisibility visibility = EventVisibility.private,
  }) {
    final now = DateTime.now();
    return JournalEntryLocal(
      id: id,
      pairId: pairId,
      createdBy: userId,
      title: title,
      body: body,
      visibility: visibility.name,
      createdAt: now,
      updatedAt: now,
      isSynced: false,
    );
  }

  /// Update from Cloud Model
  void updateFrom(JournalEntry entry) {
    title = entry.title;
    body = entry.body;
    visibility = entry.visibility.name;
    visibleToUserId = entry.visibleToUserId;
    tags = entry.tags;
    mood = entry.mood;
    calendarEventId = entry.calendarEventId;
    updatedAt = entry.updatedAt;
    isDeleted = entry.isDeleted;
    deletedAt = entry.deletedAt;
    
    // Reset sync status since it matches cloud now
    isSynced = true;
    isPendingDelete = false;
  }
  
  /// Mark for soft deletion
  void markForDeletion() {
    isDeleted = true;
    deletedAt = DateTime.now();
    isPendingDelete = true;
    isSynced = false;
  }
}
