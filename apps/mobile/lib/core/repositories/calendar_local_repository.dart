import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';
import '../models/calendar_event.dart';
import '../models/calendar_event_local.dart';

/// Local repository for calendar events using Hive
/// This is the source of truth for the offline-first architecture
class CalendarLocalRepository {
  static const String _boxName = 'calendar_events';
  final Logger _logger = Logger();

  /// Get the Hive box (assumes box was opened in main.dart)
  Box<CalendarEventLocal> get box {
    final box = Hive.box<CalendarEventLocal>(_boxName);
    if (!box.isOpen) {
      throw StateError('Hive box "$_boxName" is not open. Ensure it was opened in main.dart.');
    }
    return box;
  }

  /// Initialize the repository (no-op, box is opened in main.dart)
  Future<void> init() async {
    // Box is already opened in main.dart, just log the status
    try {
      final currentBox = Hive.box<CalendarEventLocal>(_boxName);
      _logger.i('CalendarLocalRepository initialized with ${currentBox.length} events');
    } catch (e) {
      _logger.w('CalendarLocalRepository init check: $e');
    }
  }

  /// Create a new event (saves immediately to local DB)
  Future<CalendarEventLocal> saveEvent(CalendarEventLocal event) async {
    try {
      await box.put(event.id, event);
      _logger.d('Saved event: ${event.id} - ${event.title}');
      return event;
    } catch (e, stack) {
      _logger.e('Failed to save event', error: e, stackTrace: stack);
      rethrow;
    }
  }

  /// Get a single event by ID
  CalendarEventLocal? getEventById(String eventId) {
    return box.get(eventId);
  }

  /// Get all events for a specific pair within a date range
  List<CalendarEventLocal> getEventsInRange({
    required String pairId,
    required DateTime startDate,
    required DateTime endDate,
  }) {
    try {
      final events = box.values
          .where((event) =>
              event.pairId == pairId &&
              !event.isDeleted && // Filter out soft-deleted events
              event.startTime.isAfter(startDate.subtract(const Duration(seconds: 1))) &&
              event.startTime.isBefore(endDate.add(const Duration(seconds: 1))))
          .toList();

      // Sort by start time
      events.sort((a, b) => a.startTime.compareTo(b.startTime));

      _logger.d('Retrieved ${events.length} events for pair $pairId from $startDate to $endDate');
      return events;
    } catch (e, stack) {
      _logger.e('Failed to get events in range', error: e, stackTrace: stack);
      return [];
    }
  }

  /// Get events for a specific month
  List<CalendarEventLocal> getEventsForMonth({
    required String pairId,
    required int year,
    required int month,
  }) {
    final startDate = DateTime(year, month, 1);
    final endDate = DateTime(year, month + 1, 0, 23, 59, 59);

    return getEventsInRange(
      pairId: pairId,
      startDate: startDate,
      endDate: endDate,
    );
  }

  /// Get events for a specific day
  List<CalendarEventLocal> getEventsForDay({
    required String pairId,
    required DateTime date,
  }) {
    final startDate = DateTime(date.year, date.month, date.day);
    final endDate = DateTime(date.year, date.month, date.day, 23, 59, 59);

    return getEventsInRange(
      pairId: pairId,
      startDate: startDate,
      endDate: endDate,
    );
  }

  /// Get upcoming events (next N days)
  List<CalendarEventLocal> getUpcomingEvents({
    required String pairId,
    int days = 30,
    int limit = 10,
  }) {
    final now = DateTime.now();
    final futureDate = now.add(Duration(days: days));

    final events = getEventsInRange(
      pairId: pairId,
      startDate: now,
      endDate: futureDate,
    );

    return events.take(limit).toList();
  }

  /// Get all unsynced events (for background sync)
  List<CalendarEventLocal> getUnsyncedEvents() {
    try {
      final unsynced = box.values.where((event) => !event.isSynced).toList();
      _logger.d('Found ${unsynced.length} unsynced events');
      return unsynced;
    } catch (e, stack) {
      _logger.e('Failed to get unsynced events', error: e, stackTrace: stack);
      return [];
    }
  }

  /// Get events that need sync retry
  List<CalendarEventLocal> getEventsNeedingSyncRetry() {
    try {
      final needsRetry = box.values.where((event) => event.needsSyncRetry).toList();
      _logger.d('Found ${needsRetry.length} events needing sync retry');
      return needsRetry;
    } catch (e, stack) {
      _logger.e('Failed to get events needing retry', error: e, stackTrace: stack);
      return [];
    }
  }

  /// Mark an event as successfully synced
  Future<void> markAsSynced(String eventId) async {
    try {
      final event = box.get(eventId);
      if (event != null) {
        event.markSynced();
        await event.save();
        _logger.d('Marked event $eventId as synced');
      }
    } catch (e, stack) {
      _logger.e('Failed to mark event as synced', error: e, stackTrace: stack);
    }
  }

  /// Mark sync attempt as failed
  Future<void> markSyncFailed(String eventId) async {
    try {
      final event = box.get(eventId);
      if (event != null) {
        event.markSyncFailed();
        await event.save();
        _logger.d('Marked sync failed for event $eventId');
      }
    } catch (e, stack) {
      _logger.e('Failed to mark sync failed', error: e, stackTrace: stack);
    }
  }

  /// Update an existing event
  Future<CalendarEventLocal> updateEvent({
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
      final event = box.get(eventId);
      if (event == null) {
        throw Exception('Event not found: $eventId');
      }

      event.updateFrom(
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

      await event.save();
      _logger.d('Updated event: $eventId');
      return event;
    } catch (e, stack) {
      _logger.e('Failed to update event', error: e, stackTrace: stack);
      rethrow;
    }
  }

  /// Soft delete an event locally (marks as deleted, doesn't remove from Hive)
  Future<void> softDeleteEvent(String eventId, String userId) async {
    try {
      final event = box.get(eventId);
      if (event != null) {
        event.markForDeletion(userId);
        await event.save();
        _logger.d('Soft deleted event: $eventId');
      }
    } catch (e, stack) {
      _logger.e('Failed to soft delete event', error: e, stackTrace: stack);
      rethrow;
    }
  }

  /// Delete an event (supports both soft and hard delete)
  Future<void> deleteEvent(String eventId, {String? userId, bool hard = false}) async {
    try {
      if (hard) {
        // Hard delete: immediately remove from Hive
        await box.delete(eventId);
        _logger.d('Hard deleted event: $eventId');
      } else {
        // Soft delete: mark as deleted
        if (userId == null) {
          throw Exception('userId required for soft delete');
        }
        await softDeleteEvent(eventId, userId);
      }
    } catch (e, stack) {
      _logger.e('Failed to delete event', error: e, stackTrace: stack);
      rethrow;
    }
  }

  /// Get soft-deleted events (for Trash/Restore UI)
  List<CalendarEventLocal> getDeletedEvents() {
    try {
      // Filter for deleted events, sorted by deletedAt descending (most recently deleted first)
      final deleted = box.values
          .where((event) => event.isDeleted)
          .toList();
      
      deleted.sort((a, b) {
        final aDate = a.deletedAt ?? DateTime(0);
        final bDate = b.deletedAt ?? DateTime(0);
        return bDate.compareTo(aDate);
      });

      _logger.d('Found ${deleted.length} deleted events');
      return deleted;
    } catch (e, stack) {
      _logger.e('Failed to get deleted events', error: e, stackTrace: stack);
      return [];
    }
  }

  /// Restore a soft-deleted event
  Future<void> restoreEvent(String eventId) async {
    try {
      final event = box.get(eventId);
      if (event != null) {
        event.isDeleted = false;
        event.deletedAt = null;
        event.deletedBy = null;
        event.isPendingDelete = false;
        event.updatedAt = DateTime.now();
        event.isSynced = false; // Mark as needing sync (update)
        
        await event.save();
        _logger.d('Restored event: $eventId');
      }
    } catch (e, stack) {
      _logger.e('Failed to restore event', error: e, stackTrace: stack);
      rethrow;
    }
  }

  /// Get events pending delete sync (soft-deleted but not yet synced to cloud)
  List<CalendarEventLocal> getEventsPendingDeleteSync() {
    try {
      final pending = box.values.where((event) => event.isPendingDelete).toList();
      _logger.d('Found ${pending.length} events pending delete sync');
      return pending;
    } catch (e, stack) {
      _logger.e('Failed to get events pending delete sync', error: e, stackTrace: stack);
      return [];
    }
  }

  /// Mark delete as successfully synced to cloud
  Future<void> markDeleteSynced(String eventId) async {
    try {
      final event = box.get(eventId);
      if (event != null) {
        event.markDeleteSynced();
        await event.save();
        _logger.d('Marked delete synced for event $eventId');
      }
    } catch (e, stack) {
      _logger.e('Failed to mark delete synced', error: e, stackTrace: stack);
    }
  }

  /// Cleanup deleted events older than retention period (garbage collection)
  Future<int> cleanupDeletedEvents({int retentionDays = 30}) async {
    try {
      final cutoffDate = DateTime.now().subtract(Duration(days: retentionDays));
      final eventsToDelete = box.values
          .where((event) =>
              event.isDeleted &&
              event.deletedAt != null &&
              event.deletedAt!.isBefore(cutoffDate))
          .toList();

      for (final event in eventsToDelete) {
        await box.delete(event.id);
      }

      _logger.i('Cleaned up ${eventsToDelete.length} deleted events older than $retentionDays days');
      return eventsToDelete.length;
    } catch (e, stack) {
      _logger.e('Failed to cleanup deleted events', error: e, stackTrace: stack);
      return 0;
    }
  }

  /// Get all events for a pair (useful for full sync)
  List<CalendarEventLocal> getAllEventsForPair(String pairId, {bool includeDeleted = false}) {
    try {
      final events = box.values
          .where((event) =>
              event.pairId == pairId &&
              (includeDeleted || !event.isDeleted))
          .toList();

      events.sort((a, b) => a.startTime.compareTo(b.startTime));
      _logger.d('Retrieved ${events.length} total events for pair $pairId');
      return events;
    } catch (e, stack) {
      _logger.e('Failed to get all events for pair', error: e, stackTrace: stack);
      return [];
    }
  }

  /// Clear all events (use with caution!)
  Future<void> clearAll() async {
    try {
      await box.clear();
      _logger.w('Cleared all calendar events from local storage');
    } catch (e, stack) {
      _logger.e('Failed to clear events', error: e, stackTrace: stack);
      rethrow;
    }
  }

  /// Get statistics about local storage
  Map<String, dynamic> getStats() {
    try {
      final total = box.length;
      final synced = box.values.where((e) => e.isSynced).length;
      final unsynced = box.values.where((e) => !e.isSynced).length;
      final deleted = box.values.where((e) => e.isDeleted).length;
      final pendingDelete = box.values.where((e) => e.isPendingDelete).length;

      return {
        'total': total,
        'synced': synced,
        'unsynced': unsynced,
        'needsRetry': box.values.where((e) => e.needsSyncRetry).length,
        'deleted': deleted,
        'pendingDelete': pendingDelete,
      };
    } catch (e) {
      return {'error': e.toString()};
    }
  }

  /// Close the repository (closes the Hive box)
  Future<void> close() async {
    try {
      final currentBox = Hive.box<CalendarEventLocal>(_boxName);
      if (currentBox.isOpen) {
        await currentBox.close();
        _logger.i('CalendarLocalRepository closed');
      }
    } catch (e) {
      _logger.w('CalendarLocalRepository close: $e');
    }
  }
}
