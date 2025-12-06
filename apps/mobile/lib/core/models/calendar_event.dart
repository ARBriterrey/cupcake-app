import 'package:freezed_annotation/freezed_annotation.dart';

part 'calendar_event.freezed.dart';
part 'calendar_event.g.dart';

enum EventType {
  moment,
  date,
  appointment,
  reminder,
  anniversary,
  other,
}

enum EventVisibility {
  private,
  shared,
}

@freezed
class CalendarEvent with _$CalendarEvent {
  const factory CalendarEvent({
    required String id,
    @JsonKey(name: 'pair_id') required String pairId,
    @JsonKey(name: 'created_by') String? createdBy,

    // Event details
    required String title,
    String? description,
    @JsonKey(name: 'event_type') required EventType eventType,

    // Timing
    @JsonKey(name: 'start_time') required DateTime startTime,
    @JsonKey(name: 'end_time') DateTime? endTime,
    @JsonKey(name: 'is_all_day') @Default(false) bool isAllDay,

    // Location
    String? location,
    @JsonKey(name: 'location_coordinates') String? locationCoordinates,

    // Visibility and privacy
    required EventVisibility visibility,
    @JsonKey(name: 'visible_to_user_id') String? visibleToUserId,

    // Metadata
    String? color,
    @Default([]) List<String> tags,
    @Default({}) Map<String, dynamic> metadata,

    // Timestamps
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _CalendarEvent;

  factory CalendarEvent.fromJson(Map<String, dynamic> json) =>
      _$CalendarEventFromJson(json);
}

/// Extension methods for CalendarEvent
extension CalendarEventExtensions on CalendarEvent {
  /// Check if the event is happening today
  bool get isToday {
    final now = DateTime.now();
    final eventDate = startTime;
    return eventDate.year == now.year &&
        eventDate.month == now.month &&
        eventDate.day == now.day;
  }

  /// Check if the event is in the past
  bool get isPast {
    return startTime.isBefore(DateTime.now());
  }

  /// Check if the event is upcoming (in the future)
  bool get isUpcoming {
    return startTime.isAfter(DateTime.now());
  }

  /// Get a user-friendly date range string
  String get dateRangeString {
    if (isAllDay) {
      if (endTime == null) {
        return 'All day';
      }
      final startDate = startTime;
      final endDate = endTime!;
      if (startDate.day == endDate.day &&
          startDate.month == endDate.month &&
          startDate.year == endDate.year) {
        return 'All day';
      }
      return 'All day, ${startDate.month}/${startDate.day} - ${endDate.month}/${endDate.day}';
    }

    if (endTime == null) {
      return '${startTime.hour}:${startTime.minute.toString().padLeft(2, '0')}';
    }

    return '${startTime.hour}:${startTime.minute.toString().padLeft(2, '0')} - ${endTime!.hour}:${endTime!.minute.toString().padLeft(2, '0')}';
  }

  /// Check if the event is owned by the current user
  bool isOwnedBy(String userId) {
    return createdBy == userId;
  }

  /// Check if the event is visible to a specific user
  bool isVisibleTo(String userId) {
    if (visibility == EventVisibility.shared) {
      return true;
    }
    return visibleToUserId == userId;
  }

  /// Get event duration in hours
  double? get durationInHours {
    if (endTime == null) return null;
    return endTime!.difference(startTime).inMinutes / 60.0;
  }

  /// Check if this is a multi-day event
  bool get isMultiDay {
    if (endTime == null) return false;
    return endTime!.difference(startTime).inDays > 0;
  }
}

/// Helper class to create a new calendar event with default values
class CalendarEventBuilder {
  static CalendarEvent create({
    required String pairId,
    required String createdBy,
    required String title,
    required DateTime startTime,
    String? description,
    EventType eventType = EventType.moment,
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
    return CalendarEvent(
      id: '', // Will be set by Supabase
      pairId: pairId,
      createdBy: createdBy,
      title: title,
      description: description,
      eventType: eventType,
      startTime: startTime,
      endTime: endTime,
      isAllDay: isAllDay,
      location: location,
      locationCoordinates: null,
      visibility: visibility,
      visibleToUserId: visibleToUserId,
      color: color,
      tags: tags,
      metadata: metadata,
      createdAt: now,
      updatedAt: now,
    );
  }
}
