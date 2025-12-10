import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/calendar_event.dart';

class CalendarRepository {
  final SupabaseClient _supabase;

  CalendarRepository(this._supabase);

  /// Get all events for the current user's pair within a date range
  Future<List<CalendarEvent>> getEventsInRange({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return [];

    try {
      final response = await _supabase
          .from('calendar_events')
          .select()
          .eq('is_deleted', false) // Filter out soft-deleted events
          .gte('start_time', startDate.toIso8601String())
          .lte('start_time', endDate.toIso8601String())
          .order('start_time', ascending: true);

      return (response as List)
          .map((json) => CalendarEvent.fromJson(json))
          .toList();
    } catch (e) {
      // If table doesn't exist or other error, return empty list
      return [];
    }
  }

  /// Get events for a specific month
  Future<List<CalendarEvent>> getEventsForMonth({
    required int year,
    required int month,
  }) async {
    final startDate = DateTime(year, month, 1);
    final endDate = DateTime(year, month + 1, 0, 23, 59, 59);

    return getEventsInRange(startDate: startDate, endDate: endDate);
  }

  /// Get events for a specific day
  Future<List<CalendarEvent>> getEventsForDay(DateTime date) async {
    final startDate = DateTime(date.year, date.month, date.day);
    final endDate = DateTime(date.year, date.month, date.day, 23, 59, 59);

    return getEventsInRange(startDate: startDate, endDate: endDate);
  }

  /// Get upcoming events (next 30 days)
  Future<List<CalendarEvent>> getUpcomingEvents({int limit = 10}) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return [];

    try {
      final now = DateTime.now();
      final thirtyDaysFromNow = now.add(const Duration(days: 30));

      final response = await _supabase
          .from('calendar_events')
          .select()
          .eq('is_deleted', false) // Filter out soft-deleted events
          .gte('start_time', now.toIso8601String())
          .lte('start_time', thirtyDaysFromNow.toIso8601String())
          .order('start_time', ascending: true)
          .limit(limit);

      return (response as List)
          .map((json) => CalendarEvent.fromJson(json))
          .toList();
    } catch (e) {
      return [];
    }
  }

  /// Get today's events
  Future<List<CalendarEvent>> getTodaysEvents() async {
    final now = DateTime.now();
    return getEventsForDay(now);
  }

  /// Create a new calendar event
  Future<CalendarEvent> createEvent({
    required String pairId,
    required String title,
    required DateTime startTime,
    String? description,
    EventType eventType = EventType.reminders,
    DateTime? endTime,
    bool isAllDay = false,
    String? location,
    EventVisibility visibility = EventVisibility.shared,
    String? visibleToUserId,
    String? color,
    List<String> tags = const [],
    Map<String, dynamic> metadata = const {},
  }) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) throw Exception('User not authenticated');

    // Validate visibility
    if (visibility == EventVisibility.private && visibleToUserId == null) {
      visibleToUserId = userId; // Default to current user for private events
    }

    final response = await _supabase
        .from('calendar_events')
        .insert({
          'pair_id': pairId,
          'created_by': userId,
          'title': title,
          'description': description,
          'event_type': eventType.name,
          'start_time': startTime.toIso8601String(),
          'end_time': endTime?.toIso8601String(),
          'is_all_day': isAllDay,
          'location': location,
          'visibility': visibility.name,
          'visible_to_user_id': visibleToUserId,
          'color': color,
          'tags': tags,
          'metadata': metadata,
        })
        .select()
        .single();

    return CalendarEvent.fromJson(response);
  }

  /// Update an existing calendar event
  Future<CalendarEvent> updateEvent({
    required String eventId,
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
  }) async {
    final updates = <String, dynamic>{};

    if (title != null) updates['title'] = title;
    if (description != null) updates['description'] = description;
    if (eventType != null) updates['event_type'] = eventType.name;
    if (startTime != null) updates['start_time'] = startTime.toIso8601String();
    if (endTime != null) updates['end_time'] = endTime.toIso8601String();
    if (isAllDay != null) updates['is_all_day'] = isAllDay;
    if (location != null) updates['location'] = location;
    if (visibility != null) updates['visibility'] = visibility.name;
    if (visibleToUserId != null) updates['visible_to_user_id'] = visibleToUserId;
    if (color != null) updates['color'] = color;
    if (tags != null) updates['tags'] = tags;
    if (metadata != null) updates['metadata'] = metadata;

    final response = await _supabase
        .from('calendar_events')
        .update(updates)
        .eq('id', eventId)
        .select()
        .single();

    return CalendarEvent.fromJson(response);
  }

  /// Soft delete a calendar event (marks as deleted, doesn't remove from DB)
  Future<void> deleteEvent(String eventId) async {
    await _supabase.rpc('soft_delete_calendar_event', params: {
      'p_event_id': eventId,
    });
  }

  /// Get soft-deleted events
  Future<List<CalendarEvent>> getDeletedEvents() async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return [];

    try {
      final response = await _supabase
          .from('calendar_events')
          .select()
          .eq('is_deleted', true)
          .order('deleted_at', ascending: false);

      return (response as List)
          .map((json) => CalendarEvent.fromJson(json))
          .toList();
    } catch (e) {
      return [];
    }
  }

  /// Restore a soft-deleted event
  Future<void> restoreEvent(String eventId) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) throw Exception('User not authenticated');

    await _supabase.from('calendar_events').update({
      'is_deleted': false,
      'deleted_at': null,
      'deleted_by': null,
      'updated_at': DateTime.now().toIso8601String(),
    }).eq('id', eventId);
  }

  /// Hard delete a calendar event (permanently remove from database)
  /// Only used for cleanup/garbage collection
  Future<void> hardDeleteEvent(String eventId) async {
    await _supabase.from('calendar_events').delete().eq('id', eventId);
  }

  /// Get a single event by ID
  Future<CalendarEvent?> getEventById(String eventId) async {
    try {
      final response = await _supabase
          .from('calendar_events')
          .select()
          .eq('id', eventId)
          .single();

      return CalendarEvent.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  /// Get events by type
  Future<List<CalendarEvent>> getEventsByType({
    required EventType eventType,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return [];

    try {
      var query = _supabase
          .from('calendar_events')
          .select()
          .eq('is_deleted', false) // Filter out soft-deleted events
          .eq('event_type', eventType.name);

      if (startDate != null) {
        query = query.gte('start_time', startDate.toIso8601String());
      }
      if (endDate != null) {
        query = query.lte('start_time', endDate.toIso8601String());
      }

      final response = await query.order('start_time', ascending: true);

      return (response as List)
          .map((json) => CalendarEvent.fromJson(json))
          .toList();
    } catch (e) {
      return [];
    }
  }

  /// Get events by tag
  Future<List<CalendarEvent>> getEventsByTag(String tag) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return [];

    try {
      final response = await _supabase
          .from('calendar_events')
          .select()
          .eq('is_deleted', false) // Filter out soft-deleted events
          .contains('tags', [tag])
          .order('start_time', ascending: true);

      return (response as List)
          .map((json) => CalendarEvent.fromJson(json))
          .toList();
    } catch (e) {
      return [];
    }
  }

  /// Stream events in real-time for a date range
  /// This will emit new data whenever events are added, updated, or deleted
  Stream<List<CalendarEvent>> streamEventsInRange({
    required DateTime startDate,
    required DateTime endDate,
  }) {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) {
      return Stream.value([]);
    }

    // Create a stream that listens to real-time changes
    // Note: Stream filters are limited, so we filter in memory
    return _supabase
        .from('calendar_events')
        .stream(primaryKey: ['id'])
        .map((data) {
          final events = data
              .map((json) => CalendarEvent.fromJson(json))
              .where((event) =>
                  !event.isDeleted && // Filter out soft-deleted events
                  event.startTime.isAfter(startDate.subtract(const Duration(seconds: 1))) &&
                  event.startTime.isBefore(endDate.add(const Duration(seconds: 1))))
              .toList();

          // Sort by start time
          events.sort((a, b) => a.startTime.compareTo(b.startTime));
          return events;
        });
  }

  /// Stream today's events in real-time
  Stream<List<CalendarEvent>> streamTodaysEvents() {
    final now = DateTime.now();
    final startDate = DateTime(now.year, now.month, now.day);
    final endDate = DateTime(now.year, now.month, now.day, 23, 59, 59);

    return streamEventsInRange(startDate: startDate, endDate: endDate);
  }

  /// Stream events for a specific month in real-time
  Stream<List<CalendarEvent>> streamEventsForMonth({
    required int year,
    required int month,
  }) {
    final startDate = DateTime(year, month, 1);
    final endDate = DateTime(year, month + 1, 0, 23, 59, 59);

    return streamEventsInRange(startDate: startDate, endDate: endDate);
  }
}
