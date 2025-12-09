import 'dart:async';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/models/calendar_event.dart';
import '../../../core/models/calendar_event_local.dart';
import '../../../core/models/sync_status.dart';
import '../../../core/providers/supabase_providers.dart';
import '../../../core/repositories/calendar_local_repository.dart';
import '../../../features/auth/providers/auth_providers.dart';
import '../../../features/pairing/providers/pairing_providers.dart';
import 'calendar_providers.dart';

part 'calendar_sync_provider.g.dart';

final _logger = Logger();

@riverpod
class CalendarSync extends _$CalendarSync {
  RealtimeChannel? _channel;
  Timer? _reconnectTimer;

  @override
  Stream<SyncStatus> build() async* {
    // Watch auth state and current pair
    final authStateAsync = ref.watch(authStateProvider);
    final currentPairAsync = ref.watch(currentPairProvider);

    // Cleanup on dispose
    ref.onDispose(() {
      _logger.d('CalendarSync: Disposing sync provider');
      _channel?.unsubscribe();
      _reconnectTimer?.cancel();
    });

    // Wait for auth state
    final authState = authStateAsync.whenData((state) => state).value;

    // Not authenticated - idle state
    if (authState?.session == null) {
      _logger.d('CalendarSync: No active session, staying idle');
      yield const SyncStatus.idle();
      return;
    }

    // Wait for pair data
    final currentPair = currentPairAsync.whenData((pair) => pair).value;

    // No pair - idle state
    if (currentPair == null) {
      _logger.d('CalendarSync: No active pair, staying idle');
      yield const SyncStatus.idle();
      return;
    }

    _logger.i('CalendarSync: Starting sync for pair ${currentPair.id}');
    yield const SyncStatus.syncing(message: 'Initializing sync...');

    try {
      // Perform initial sync
      final eventsSynced = await _performInitialSync(currentPair.id);
      _logger.i('CalendarSync: Initial sync completed, synced $eventsSynced events');

      yield SyncStatus.syncing(
        message: 'Setting up real-time sync...',
      );

      // Set up real-time subscription
      await _subscribeToChanges(currentPair.id);

      _logger.i('CalendarSync: Real-time sync established');
      yield SyncStatus.synced(
        lastSyncedAt: DateTime.now(),
        eventsSynced: eventsSynced,
      );

      // Keep the stream alive
      await for (final _ in Stream.periodic(const Duration(minutes: 5))) {
        // Periodic heartbeat to keep stream alive
        yield SyncStatus.synced(
          lastSyncedAt: DateTime.now(),
          eventsSynced: eventsSynced,
        );
      }
    } catch (e, stackTrace) {
      _logger.e('CalendarSync: Error during sync', error: e, stackTrace: stackTrace);
      yield SyncStatus.error(
        message: 'Sync failed: ${e.toString()}',
        lastSyncedAt: DateTime.now(),
      );

      // Retry after 30 seconds
      _reconnectTimer = Timer(const Duration(seconds: 30), () {
        ref.invalidateSelf();
      });
    }
  }

  /// Performs initial sync by fetching events from cloud and storing locally
  Future<int> _performInitialSync(String pairId) async {
    final calendarRepo = ref.read(calendarRepositoryProvider);
    final localRepo = ref.read(calendarLocalRepositoryProvider);

    // Fetch events from last 30 days to next 365 days
    final now = DateTime.now();
    final startDate = now.subtract(const Duration(days: 30));
    final endDate = now.add(const Duration(days: 365));

    _logger.d('CalendarSync: Fetching events from $startDate to $endDate');

    try {
      final cloudEvents = await calendarRepo.getEventsInRange(
        startDate: startDate,
        endDate: endDate,
      );

      _logger.d('CalendarSync: Fetched ${cloudEvents.length} events from cloud');

      // Convert and save to local storage
      int syncedCount = 0;
      for (final cloudEvent in cloudEvents) {
        await _upsertEventLocally(cloudEvent, localRepo);
        syncedCount++;
      }

      // Invalidate providers to refresh UI
      _invalidateProviders();

      return syncedCount;
    } catch (e) {
      _logger.e('CalendarSync: Error during initial sync', error: e);
      rethrow;
    }
  }

  /// Subscribes to real-time changes from Supabase
  Future<void> _subscribeToChanges(String pairId) async {
    final supabase = ref.read(supabaseClientProvider);
    final localRepo = ref.read(calendarLocalRepositoryProvider);

    _logger.d('CalendarSync: Setting up real-time subscription for pair $pairId');

    try {
      // Unsubscribe from previous channel if exists
      await _channel?.unsubscribe();

      // Create new channel for calendar events filtered by pair_id
      _channel = supabase
          .channel('calendar_events:$pairId')
          .onPostgresChanges(
            event: PostgresChangeEvent.all,
            schema: 'public',
            table: 'calendar_events',
            filter: PostgresChangeFilter(
              type: PostgresChangeFilterType.eq,
              column: 'pair_id',
              value: pairId,
            ),
            callback: (payload) async {
              _logger.i('CalendarSync: 🔔 REAL-TIME EVENT RECEIVED: ${payload.eventType}');

              try {
                switch (payload.eventType) {
                  case PostgresChangeEvent.insert:
                    _logger.d('CalendarSync: Processing INSERT payload');
                    await _handleInsert(payload.newRecord, localRepo);
                    break;
                  case PostgresChangeEvent.update:
                    _logger.d('CalendarSync: Processing UPDATE payload');
                    await _handleUpdate(payload.newRecord, localRepo);
                    break;
                  case PostgresChangeEvent.delete:
                    _logger.d('CalendarSync: Processing DELETE payload');
                    await _handleDelete(payload.oldRecord, localRepo);
                    break;
                  default:
                    _logger.w('CalendarSync: Unknown event type: ${payload.eventType}');
                }

                // Invalidate providers to refresh UI
                _logger.i('CalendarSync: 🔄 Invalidating providers to trigger UI rebuild');
                _invalidateProviders();
              } catch (e) {
                _logger.e('CalendarSync: Error handling realtime event', error: e);
              }
            },
          )
          .subscribe();

      _logger.i('CalendarSync: Real-time subscription established');
    } catch (e) {
      _logger.e('CalendarSync: Error setting up subscription', error: e);
      rethrow;
    }
  }

  /// Handles INSERT events from Supabase
  Future<void> _handleInsert(
    Map<String, dynamic> record,
    CalendarLocalRepository localRepo,
  ) async {
    _logger.d('CalendarSync: Handling INSERT for event ${record['id']}');

    try {
      final cloudEvent = CalendarEvent.fromJson(record);
      await _upsertEventLocally(cloudEvent, localRepo);
      _logger.i('CalendarSync: Successfully inserted event ${cloudEvent.id}');
    } catch (e) {
      _logger.e('CalendarSync: Error handling INSERT', error: e);
    }
  }

  /// Handles UPDATE events from Supabase
  Future<void> _handleUpdate(
    Map<String, dynamic> record,
    CalendarLocalRepository localRepo,
  ) async {
    _logger.d('CalendarSync: Handling UPDATE for event ${record['id']}');

    try {
      final cloudEvent = CalendarEvent.fromJson(record);
      final eventId = cloudEvent.id;

      // Check if update is a soft delete
      if (cloudEvent.isDeleted) {
        _logger.d('CalendarSync: Received soft delete for ${cloudEvent.id}');
      }

      // Check if we have a local version
      final localEvent = localRepo.getEventById(eventId);

      if (localEvent != null) {
        // Conflict resolution: compare timestamps
        final cloudUpdatedAt = cloudEvent.updatedAt;
        final localUpdatedAt = localEvent.updatedAt;

        if (cloudUpdatedAt.isAfter(localUpdatedAt)) {
          // Cloud is newer - accept the update
          _logger.d('CalendarSync: Cloud event is newer, updating local');
          await _upsertEventLocally(cloudEvent, localRepo);
        } else {
          // Local is newer - keep local version (it will sync up later)
          _logger.d('CalendarSync: Local event is newer, keeping local version');
          // Mark as needing sync if not already synced
          if (!localEvent.isSynced) {
            _logger.d('CalendarSync: Local event needs re-sync');
          }
        }
      } else {
        // No local version - just insert
        _logger.d('CalendarSync: No local version, inserting');
        await _upsertEventLocally(cloudEvent, localRepo);
      }

      _logger.i('CalendarSync: Successfully handled update for event ${cloudEvent.id}');
    } catch (e) {
      _logger.e('CalendarSync: Error handling UPDATE', error: e);
    }
  }

  /// Handles DELETE events from Supabase (hard delete - actual removal from DB)
  Future<void> _handleDelete(
    Map<String, dynamic> record,
    CalendarLocalRepository localRepo,
  ) async {
    final eventId = record['id'] as String;
    _logger.d('CalendarSync: Handling hard DELETE for event $eventId');

    try {
      // This is a hard delete (actual removal from database after retention period)
      await localRepo.deleteEvent(eventId, hard: true);
      _logger.i('CalendarSync: Successfully hard deleted event $eventId');
    } catch (e) {
      _logger.e('CalendarSync: Error handling DELETE', error: e);
    }
  }

  /// Upserts a cloud event to local storage with conflict resolution
  Future<void> _upsertEventLocally(
    CalendarEvent cloudEvent,
    CalendarLocalRepository localRepo,
  ) async {
    // Convert cloud event to local event
    final localEvent = CalendarEventLocal.fromCalendarEvent(cloudEvent);

    // Mark as synced since it came from cloud
    localEvent.isSynced = true;
    localEvent.lastSyncAttempt = DateTime.now();

    await localRepo.saveEvent(localEvent);
  }

  /// Invalidates relevant providers to trigger UI refresh
  void _invalidateProviders() {
    // Invalidate all event providers to refresh UI
    ref.invalidate(monthlyEventsProvider);
    ref.invalidate(dailyEventsProvider);
    ref.invalidate(selectedDateEventsProvider);
    ref.invalidate(todaysEventsProvider);
    ref.invalidate(upcomingEventsProvider);
    ref.invalidate(allEventTagsProvider);

    _logger.d('CalendarSync: Invalidated event providers');
  }
}
