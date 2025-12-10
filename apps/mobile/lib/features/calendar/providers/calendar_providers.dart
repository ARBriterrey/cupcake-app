import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/models/calendar_event.dart';
import '../../../core/models/calendar_event_local.dart';
import '../../../core/repositories/calendar_repository.dart';
import '../../../core/providers/supabase_providers.dart';
import '../../pairing/providers/pairing_providers.dart';

part 'calendar_providers.g.dart';

/// Active event type filters - all types enabled by default
final activeEventTypeFiltersProvider = StateProvider<Set<EventType>>((ref) {
  return EventType.values.toSet();
});

/// Provides the CalendarRepository (for Supabase sync)
@riverpod
CalendarRepository calendarRepository(CalendarRepositoryRef ref) {
  final supabase = ref.watch(supabaseClientProvider);
  return CalendarRepository(supabase);
}

/// State class for managing selected date in the calendar
@riverpod
class SelectedDate extends _$SelectedDate {
  @override
  DateTime build() {
    return DateTime.now();
  }

  void setDate(DateTime date) {
    state = date;
  }

  void setToday() {
    state = DateTime.now();
  }

  void nextMonth() {
    state = DateTime(state.year, state.month + 1, 1);
  }

  void previousMonth() {
    state = DateTime(state.year, state.month - 1, 1);
  }

  void nextDay() {
    state = state.add(const Duration(days: 1));
  }

  void previousDay() {
    state = state.subtract(const Duration(days: 1));
  }
}

/// Get events for a specific month (from local DB)
/// Filtered by active event type filters
@riverpod
Future<List<CalendarEvent>> monthlyEvents(
  MonthlyEventsRef ref, {
  required int year,
  required int month,
}) async {
  final currentPair = await ref.watch(currentPairProvider.future);
  final activeFilters = ref.watch(activeEventTypeFiltersProvider);

  if (currentPair == null) return [];

  final localRepo = ref.watch(calendarLocalRepositoryProvider);
  final localEvents = localRepo.getEventsForMonth(
    pairId: currentPair.id,
    year: year,
    month: month,
  );

  final allEvents = localEvents.map((e) => e.toCalendarEvent()).toList();

  // Apply event type filters to month view
  return allEvents.where((event) => activeFilters.contains(event.eventType)).toList();
}

/// Get events for a specific day (from local DB)
@riverpod
Future<List<CalendarEvent>> dailyEvents(
  DailyEventsRef ref,
  DateTime date,
) async {
  final currentPair = await ref.watch(currentPairProvider.future);
  if (currentPair == null) return [];

  final localRepo = ref.watch(calendarLocalRepositoryProvider);
  final localEvents = localRepo.getEventsForDay(
    pairId: currentPair.id,
    date: date,
  );

  return localEvents.map((e) => e.toCalendarEvent()).toList();
}

/// Get events for the currently selected date (from local DB)
/// Derives from monthly events to avoid redundant Hive query
/// Filtered by active event type filters (applied at monthly level)
@riverpod
Future<List<CalendarEvent>> selectedDateEvents(SelectedDateEventsRef ref) async {
  final selectedDate = ref.watch(selectedDateProvider);
  final currentPair = await ref.watch(currentPairProvider.future);

  if (currentPair == null) return [];

  // OPTIMIZATION: Use monthly data instead of querying Hive again
  final monthlyEvents = await ref.watch(
    monthlyEventsProvider(
      year: selectedDate.year,
      month: selectedDate.month,
    ).future,
  );

  // Filter to selected day (events are already filtered by type in monthlyEventsProvider)
  return monthlyEvents.where((event) {
    final eventDate = event.startTime.toLocal();
    return eventDate.year == selectedDate.year &&
           eventDate.month == selectedDate.month &&
           eventDate.day == selectedDate.day;
  }).toList();
}

/// Get today's events (from local DB)
@riverpod
Future<List<CalendarEvent>> todaysEvents(TodaysEventsRef ref) async {
  final currentPair = await ref.watch(currentPairProvider.future);
  if (currentPair == null) return [];

  final localRepo = ref.watch(calendarLocalRepositoryProvider);
  final today = DateTime.now();
  final localEvents = localRepo.getEventsForDay(
    pairId: currentPair.id,
    date: today,
  );

  return localEvents.map((e) => e.toCalendarEvent()).toList();
}

/// Get upcoming events (next 30 days, from local DB)
@riverpod
Future<List<CalendarEvent>> upcomingEvents(
  UpcomingEventsRef ref, {
  int limit = 10,
}) async {
  final currentPair = await ref.watch(currentPairProvider.future);
  if (currentPair == null) return [];

  final localRepo = ref.watch(calendarLocalRepositoryProvider);
  final localEvents = localRepo.getUpcomingEvents(
    pairId: currentPair.id,
    days: 30,
    limit: limit,
  );

  return localEvents.map((e) => e.toCalendarEvent()).toList();
}

/// Get events by type (from local DB)
@riverpod
Future<List<CalendarEvent>> eventsByType(
  EventsByTypeRef ref, {
  required EventType eventType,
  DateTime? startDate,
  DateTime? endDate,
}) async {
  final currentPair = await ref.watch(currentPairProvider.future);
  if (currentPair == null) return [];

  final localRepo = ref.watch(calendarLocalRepositoryProvider);

  // Use provided dates or default to wide range
  final start = startDate ?? DateTime.now().subtract(const Duration(days: 365));
  final end = endDate ?? DateTime.now().add(const Duration(days: 365));

  final localEvents = localRepo.getEventsInRange(
    pairId: currentPair.id,
    startDate: start,
    endDate: end,
  );

  // Filter by event type
  final filteredEvents = localEvents
      .where((e) => e.eventType == eventType.name)
      .map((e) => e.toCalendarEvent())
      .toList();

  return filteredEvents;
}

/// Get events by tag (from local DB)
@riverpod
Future<List<CalendarEvent>> eventsByTag(
  EventsByTagRef ref,
  String tag,
) async {
  final currentPair = await ref.watch(currentPairProvider.future);
  if (currentPair == null) return [];

  final localRepo = ref.watch(calendarLocalRepositoryProvider);

  // Get all events for the pair
  final allEvents = localRepo.getAllEventsForPair(currentPair.id);

  // Filter by tag
  final filteredEvents = allEvents
      .where((e) => e.tags.contains(tag))
      .map((e) => e.toCalendarEvent())
      .toList();

  return filteredEvents;
}

/// Stream events for a specific month with real-time updates
@riverpod
Stream<List<CalendarEvent>> monthlyEventsStream(
  MonthlyEventsStreamRef ref, {
  required int year,
  required int month,
}) {
  final repository = ref.watch(calendarRepositoryProvider);
  final startDate = DateTime(year, month, 1);
  final endDate = DateTime(year, month + 1, 0, 23, 59, 59);

  return repository.streamEventsInRange(
    startDate: startDate,
    endDate: endDate,
  );
}

/// Stream today's events with real-time updates
@riverpod
Stream<List<CalendarEvent>> todaysEventsStream(TodaysEventsStreamRef ref) {
  final repository = ref.watch(calendarRepositoryProvider);
  return repository.streamTodaysEvents();
}

/// Stream events for the currently selected month
@riverpod
Stream<List<CalendarEvent>> selectedMonthEventsStream(
  SelectedMonthEventsStreamRef ref,
) {
  final selectedDate = ref.watch(selectedDateProvider);
  final repository = ref.watch(calendarRepositoryProvider);

  return repository.streamEventsForMonth(
    year: selectedDate.year,
    month: selectedDate.month,
  );
}

/// Controller for creating calendar events
@riverpod
class CalendarEventCreator extends _$CalendarEventCreator {
  @override
  FutureOr<CalendarEvent?> build() {
    return null;
  }

  Future<CalendarEvent> createEvent({
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
    // Get current user and pair synchronously from provider cache
    final currentUser = Supabase.instance.client.auth.currentUser;
    final currentPair = ref.read(currentPairProvider).value;

    if (currentUser == null || currentPair == null) {
      final error = Exception('You must be signed in and paired to create calendar events');
      state = AsyncError(error, StackTrace.current);
      throw error;
    }

    try {
      // Create local event (saves IMMEDIATELY to Hive)
      final localRepo = ref.read(calendarLocalRepositoryProvider);
      final localEvent = CalendarEventLocal.createNew(
        pairId: currentPair.id,
        createdBy: currentUser.id,
        title: title,
        description: description,
        eventType: eventType,
        startTime: startTime,
        endTime: endTime,
        isAllDay: isAllDay,
        location: location,
        visibility: visibility,
        visibleToUserId: visibleToUserId,
        color: color,
        tags: tags,
        metadata: metadata,
      );

      // Save to local DB (instant, synchronous operation)
      await localRepo.saveEvent(localEvent);

      // Convert to CalendarEvent for return
      final event = localEvent.toCalendarEvent();
      state = AsyncData(event);

      // Invalidate all relevant providers to refresh UI
      ref.invalidate(monthlyEventsProvider);
      ref.invalidate(monthlyEventsStreamProvider);
      ref.invalidate(todaysEventsProvider);
      ref.invalidate(upcomingEventsProvider);
      ref.invalidate(selectedDateEventsProvider);
      ref.invalidate(selectedMonthEventsStreamProvider);

      // Background sync to Supabase happens asynchronously (don't wait for it)
      _syncEventToCloud(localEvent);

      return event;
    } catch (e, stack) {
      state = AsyncError(e, stack);
      rethrow;
    }
  }

  /// Background sync to Supabase (fire and forget)
  Future<void> _syncEventToCloud(CalendarEventLocal localEvent) async {
    try {
      final cloudRepo = ref.read(calendarRepositoryProvider);
      await cloudRepo.createEvent(
        pairId: localEvent.pairId,
        title: localEvent.title,
        description: localEvent.description,
        eventType: EventType.values.firstWhere((e) => e.name == localEvent.eventType),
        startTime: localEvent.startTime,
        endTime: localEvent.endTime,
        isAllDay: localEvent.isAllDay,
        location: localEvent.location,
        visibility: EventVisibility.values.firstWhere((e) => e.name == localEvent.visibility),
        visibleToUserId: localEvent.visibleToUserId,
        color: localEvent.color,
        tags: localEvent.tags,
        metadata: Map<String, dynamic>.from(localEvent.metadata),
      );

      // Mark as synced
      final localRepo = ref.read(calendarLocalRepositoryProvider);
      await localRepo.markAsSynced(localEvent.id);
    } catch (e) {
      // Sync failed - mark for retry
      final localRepo = ref.read(calendarLocalRepositoryProvider);
      await localRepo.markSyncFailed(localEvent.id);
    }
  }
}

/// Controller for updating calendar events
@riverpod
class CalendarEventUpdater extends _$CalendarEventUpdater {
  @override
  FutureOr<CalendarEvent?> build() {
    return null;
  }

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
    try {
      // Update local event (instant operation)
      final localRepo = ref.read(calendarLocalRepositoryProvider);
      final localEvent = await localRepo.updateEvent(
        eventId: eventId,
        title: title,
        description: description,
        eventType: eventType,
        startTime: startTime,
        endTime: endTime,
        isAllDay: isAllDay,
        location: location,
        visibility: visibility,
        visibleToUserId: visibleToUserId,
        color: color,
        tags: tags,
        metadata: metadata,
      );

      final event = localEvent.toCalendarEvent();
      state = AsyncData(event);

      // Invalidate relevant providers to refresh the UI
      ref.invalidate(monthlyEventsProvider);
      ref.invalidate(monthlyEventsStreamProvider);
      ref.invalidate(todaysEventsProvider);
      ref.invalidate(upcomingEventsProvider);
      ref.invalidate(selectedDateEventsProvider);

      // Background sync to Supabase (fire and forget)
      _syncUpdateToCloud(localEvent);

      return event;
    } catch (e, stack) {
      state = AsyncError(e, stack);
      rethrow;
    }
  }

  /// Background sync update to Supabase
  Future<void> _syncUpdateToCloud(CalendarEventLocal localEvent) async {
    try {
      final cloudRepo = ref.read(calendarRepositoryProvider);
      await cloudRepo.updateEvent(
        eventId: localEvent.id,
        title: localEvent.title,
        description: localEvent.description,
        eventType: EventType.values.firstWhere((e) => e.name == localEvent.eventType),
        startTime: localEvent.startTime,
        endTime: localEvent.endTime,
        isAllDay: localEvent.isAllDay,
        location: localEvent.location,
        visibility: EventVisibility.values.firstWhere((e) => e.name == localEvent.visibility),
        visibleToUserId: localEvent.visibleToUserId,
        color: localEvent.color,
        tags: localEvent.tags,
        metadata: Map<String, dynamic>.from(localEvent.metadata),
      );

      // Mark as synced
      final localRepo = ref.read(calendarLocalRepositoryProvider);
      await localRepo.markAsSynced(localEvent.id);
    } catch (e) {
      // Sync failed - mark for retry
      final localRepo = ref.read(calendarLocalRepositoryProvider);
      await localRepo.markSyncFailed(localEvent.id);
    }
  }
}

/// Controller for deleting calendar events
@riverpod
class CalendarEventDeleter extends _$CalendarEventDeleter {
  @override
  FutureOr<void> build() {
    return null;
  }

  Future<void> deleteEvent(String eventId) async {
    final currentUser = Supabase.instance.client.auth.currentUser;
    if (currentUser == null) {
      final error = Exception('User not authenticated');
      state = AsyncError(error, StackTrace.current);
      throw error;
    }

    try {
      // PHASE 1: Soft delete locally (immediate UI update)
      final localRepo = ref.read(calendarLocalRepositoryProvider);
      await localRepo.softDeleteEvent(eventId, currentUser.id);

      state = const AsyncData(null);

      // Invalidate relevant providers to refresh the UI
      ref.invalidate(monthlyEventsProvider);
      ref.invalidate(monthlyEventsStreamProvider);
      ref.invalidate(todaysEventsProvider);
      ref.invalidate(upcomingEventsProvider);
      ref.invalidate(selectedDateEventsProvider);

      // PHASE 2: Background sync to cloud (async, non-blocking)
      _syncDeleteToCloud(eventId);
    } catch (e, stack) {
      state = AsyncError(e, stack);
      rethrow;
    }
  }

  /// Background sync delete to Supabase
  Future<void> _syncDeleteToCloud(String eventId) async {
    try {
      final cloudRepo = ref.read(calendarRepositoryProvider);
      await cloudRepo.deleteEvent(eventId); // Now calls soft delete RPC

      // Mark as successfully synced
      final localRepo = ref.read(calendarLocalRepositoryProvider);
      await localRepo.markDeleteSynced(eventId);
    } catch (e) {
      // Sync failed - mark for retry
      final localRepo = ref.read(calendarLocalRepositoryProvider);
      await localRepo.markSyncFailed(eventId);
    }
  }

  /// Restore a deleted event
  Future<void> restoreEvent(String eventId) async {
    final currentUser = Supabase.instance.client.auth.currentUser;
    if (currentUser == null) {
      final error = Exception('User not authenticated');
      state = AsyncError(error, StackTrace.current);
      throw error;
    }

    try {
      // PHASE 1: Restore locally (immediate UI update)
      final localRepo = ref.read(calendarLocalRepositoryProvider);
      await localRepo.restoreEvent(eventId);

      state = const AsyncData(null);

      // Invalidate relevant providers to refresh the UI
      ref.invalidate(monthlyEventsProvider);
      ref.invalidate(monthlyEventsStreamProvider);
      ref.invalidate(todaysEventsProvider);
      ref.invalidate(upcomingEventsProvider);
      ref.invalidate(selectedDateEventsProvider);
      ref.invalidate(deletedEventsProvider); // Refresh deleted list

      // PHASE 2: Background sync to cloud (async, non-blocking)
      _syncRestoreToCloud(eventId);
    } catch (e, stack) {
      state = AsyncError(e, stack);
      rethrow;
    }
  }

  /// Background sync restore to Supabase
  Future<void> _syncRestoreToCloud(String eventId) async {
    try {
      final cloudRepo = ref.read(calendarRepositoryProvider);
      await cloudRepo.restoreEvent(eventId);

      // Mark as successfully synced
      final localRepo = ref.read(calendarLocalRepositoryProvider);
      await localRepo.markAsSynced(eventId);
    } catch (e) {
      // Sync failed - mark for retry
      final localRepo = ref.read(calendarLocalRepositoryProvider);
      await localRepo.markSyncFailed(eventId);
    }
  }
}

/// Get deleted events (for Trash bin)
@riverpod
Future<List<CalendarEvent>> deletedEvents(DeletedEventsRef ref) async {
  final currentPair = await ref.watch(currentPairProvider.future);
  if (currentPair == null) return [];

  final localRepo = ref.watch(calendarLocalRepositoryProvider);
  final localEvents = localRepo.getDeletedEvents();

  return localEvents.map((e) => e.toCalendarEvent()).toList();
}

/// Get a single event by ID (from local DB)
@riverpod
Future<CalendarEvent?> calendarEvent(
  CalendarEventRef ref,
  String eventId,
) async {
  final localRepo = ref.watch(calendarLocalRepositoryProvider);
  final localEvent = localRepo.getEventById(eventId);
  return localEvent?.toCalendarEvent();
}

/// Helper to check if a date has any events
@riverpod
Future<bool> hasEventsOnDate(
  HasEventsOnDateRef ref,
  DateTime date,
) async {
  final events = await ref.watch(dailyEventsProvider(date).future);
  return events.isNotEmpty;
}

/// Get all unique tags from events
@riverpod
Future<List<String>> allEventTags(AllEventTagsRef ref) async {
  // Get events for the current month
  final selectedDate = ref.watch(selectedDateProvider);
  final events = await ref.watch(
    monthlyEventsProvider(
      year: selectedDate.year,
      month: selectedDate.month,
    ).future,
  );

  // Extract and deduplicate tags
  final tags = <String>{};
  for (final event in events) {
    tags.addAll(event.tags);
  }

  return tags.toList()..sort();
}

/// Background worker to sync pending deletes
@riverpod
class DeleteSyncWorker extends _$DeleteSyncWorker {
  @override
  Future<void> build() async {
    // Run initial sync
    await _syncPendingDeletes();

    // Schedule periodic sync (every 5 minutes)
    ref.onDispose(() {});

    // Note: For production, use a proper background task scheduler
    // like workmanager or flutter_background_service
    return;
  }

  Future<void> _syncPendingDeletes() async {
    try {
      final localRepo = ref.read(calendarLocalRepositoryProvider);
      final cloudRepo = ref.read(calendarRepositoryProvider);

      final pending = localRepo.getEventsPendingDeleteSync();

      for (final event in pending) {
        try {
          await cloudRepo.deleteEvent(event.id);
          await localRepo.markDeleteSynced(event.id);
        } catch (e) {
          await localRepo.markSyncFailed(event.id);
        }
      }
    } catch (e) {
      // Sync worker failed - will retry on next scheduled run
    }
  }

  /// Manual trigger for sync (can be called from UI or periodic timer)
  Future<void> syncNow() async {
    await _syncPendingDeletes();
  }
}
