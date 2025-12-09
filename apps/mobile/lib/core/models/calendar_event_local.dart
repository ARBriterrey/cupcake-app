import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'calendar_event.dart';

part 'calendar_event_local.g.dart';

/// Local Hive-persisted calendar event model
/// This is the source of truth for the offline-first architecture
@HiveType(typeId: 0)
class CalendarEventLocal extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String pairId;

  @HiveField(2)
  String? createdBy;

  @HiveField(3)
  String title;

  @HiveField(4)
  String? description;

  @HiveField(5)
  String eventType; // Stored as string for Hive

  @HiveField(6)
  DateTime startTime;

  @HiveField(7)
  DateTime? endTime;

  @HiveField(8)
  bool isAllDay;

  @HiveField(9)
  String? location;

  @HiveField(10)
  String? locationCoordinates;

  @HiveField(11)
  String visibility; // Stored as string for Hive

  @HiveField(12)
  String? visibleToUserId;

  @HiveField(13)
  String? color;

  @HiveField(14)
  List<String> tags;

  @HiveField(15)
  Map<dynamic, dynamic> metadata; // Hive doesn't support typed maps directly

  @HiveField(16)
  DateTime createdAt;

  @HiveField(17)
  DateTime updatedAt;

  @HiveField(18)
  bool isSynced; // Track sync status with Supabase

  @HiveField(19)
  DateTime? lastSyncAttempt; // Track last sync attempt for retry logic

  @HiveField(20)
  bool isDeleted; // Soft delete flag

  @HiveField(21)
  DateTime? deletedAt; // When was this event deleted

  @HiveField(22)
  String? deletedBy; // Who deleted this event

  @HiveField(23)
  bool isPendingDelete; // Track if delete is pending sync to cloud

  CalendarEventLocal({
    required this.id,
    required this.pairId,
    this.createdBy,
    required this.title,
    this.description,
    required this.eventType,
    required this.startTime,
    this.endTime,
    this.isAllDay = false,
    this.location,
    this.locationCoordinates,
    required this.visibility,
    this.visibleToUserId,
    this.color,
    this.tags = const [],
    this.metadata = const {},
    required this.createdAt,
    required this.updatedAt,
    this.isSynced = false,
    this.lastSyncAttempt,
    this.isDeleted = false,
    this.deletedAt,
    this.deletedBy,
    this.isPendingDelete = false,
  });

  /// Convert from Hive model to app model (CalendarEvent)
  CalendarEvent toCalendarEvent() {
    return CalendarEvent(
      id: id,
      pairId: pairId,
      createdBy: createdBy,
      title: title,
      description: description,
      eventType: EventType.values.firstWhere(
        (e) => e.name == eventType,
        orElse: () => EventType.other,
      ),
      startTime: startTime,
      endTime: endTime,
      isAllDay: isAllDay,
      location: location,
      locationCoordinates: locationCoordinates,
      visibility: EventVisibility.values.firstWhere(
        (e) => e.name == visibility,
        orElse: () => EventVisibility.shared,
      ),
      visibleToUserId: visibleToUserId,
      color: color,
      tags: tags,
      metadata: Map<String, dynamic>.from(metadata),
      createdAt: createdAt,
      updatedAt: updatedAt,
      isDeleted: isDeleted,
      deletedAt: deletedAt,
      deletedBy: deletedBy,
    );
  }

  /// Convert from app model (CalendarEvent) to Hive model
  static CalendarEventLocal fromCalendarEvent(CalendarEvent event, {bool? isSynced}) {
    return CalendarEventLocal(
      id: event.id.isEmpty ? const Uuid().v4() : event.id,
      pairId: event.pairId,
      createdBy: event.createdBy,
      title: event.title,
      description: event.description,
      eventType: event.eventType.name,
      startTime: event.startTime,
      endTime: event.endTime,
      isAllDay: event.isAllDay,
      location: event.location,
      locationCoordinates: event.locationCoordinates,
      visibility: event.visibility.name,
      visibleToUserId: event.visibleToUserId,
      color: event.color,
      tags: event.tags,
      metadata: event.metadata,
      createdAt: event.createdAt,
      updatedAt: event.updatedAt,
      isSynced: isSynced ?? false,
      lastSyncAttempt: null,
      isDeleted: event.isDeleted,
      deletedAt: event.deletedAt,
      deletedBy: event.deletedBy,
      isPendingDelete: false,
    );
  }

  /// Create a new local event (not yet synced)
  static CalendarEventLocal createNew({
    required String pairId,
    required String createdBy,
    required String title,
    required EventType eventType,
    required DateTime startTime,
    String? description,
    DateTime? endTime,
    bool isAllDay = false,
    String? location,
    EventVisibility visibility = EventVisibility.shared,
    String? visibleToUserId,
    String? color,
    List<String> tags = const [],
    Map<String, dynamic> metadata = const {},
  }) {
    final now = DateTime.now();
    return CalendarEventLocal(
      id: const Uuid().v4(),
      pairId: pairId,
      createdBy: createdBy,
      title: title,
      description: description,
      eventType: eventType.name,
      startTime: startTime,
      endTime: endTime,
      isAllDay: isAllDay,
      location: location,
      locationCoordinates: null,
      visibility: visibility.name,
      visibleToUserId: visibleToUserId,
      color: color,
      tags: tags,
      metadata: metadata,
      createdAt: now,
      updatedAt: now,
      isSynced: false,
      lastSyncAttempt: null,
      isDeleted: false,
      deletedAt: null,
      deletedBy: null,
      isPendingDelete: false,
    );
  }

  /// Update this event's data
  void updateFrom({
    String? title,
    String? description,
    EventType? eventType,
    DateTime? startTime,
    DateTime? endTime,
    bool? isAllDay,
    String? location,
    EventVisibility? visibility,
    String? visibleToUserId,
    String? color,
    List<String>? tags,
    Map<String, dynamic>? metadata,
  }) {
    if (title != null) this.title = title;
    if (description != null) this.description = description;
    if (eventType != null) this.eventType = eventType.name;
    if (startTime != null) this.startTime = startTime;
    if (endTime != null) this.endTime = endTime;
    if (isAllDay != null) this.isAllDay = isAllDay;
    if (location != null) this.location = location;
    if (visibility != null) this.visibility = visibility.name;
    if (visibleToUserId != null) this.visibleToUserId = visibleToUserId;
    if (color != null) this.color = color;
    if (tags != null) this.tags = tags;
    if (metadata != null) this.metadata = metadata;

    updatedAt = DateTime.now();
    isSynced = false; // Mark as needing sync
  }

  /// Mark this event as successfully synced
  void markSynced() {
    isSynced = true;
    lastSyncAttempt = DateTime.now();
  }

  /// Mark sync attempt failed
  void markSyncFailed() {
    lastSyncAttempt = DateTime.now();
    // isSynced remains false
  }

  /// Check if this event needs sync retry
  bool get needsSyncRetry {
    if (isSynced) return false;
    if (lastSyncAttempt == null) return true;

    // Retry after 5 minutes
    final fiveMinutesAgo = DateTime.now().subtract(const Duration(minutes: 5));
    return lastSyncAttempt!.isBefore(fiveMinutesAgo);
  }

  /// Mark event for deletion (soft delete locally)
  void markForDeletion(String userId) {
    isDeleted = true;
    deletedAt = DateTime.now();
    deletedBy = userId;
    isPendingDelete = true; // Mark as pending sync
    updatedAt = DateTime.now();
    isSynced = false;
  }

  /// Mark delete successfully synced to cloud
  void markDeleteSynced() {
    isPendingDelete = false;
    isSynced = true;
    lastSyncAttempt = DateTime.now();
  }

  /// Check if this event should be filtered from UI
  bool get shouldHideFromUI => isDeleted;

  @override
  String toString() {
    return 'CalendarEventLocal{id: $id, title: $title, isSynced: $isSynced, isDeleted: $isDeleted}';
  }
}
