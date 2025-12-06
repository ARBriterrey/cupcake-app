# Calendar Synchronization Strategy

## Problem Analysis
The Cupcake app uses a "local-first" architecture where calendar events are stored in a local Hive database. Currently, when events are created or updated in the cloud (Supabase), they are not automatically synchronized down to the local device. This results in events being visible in the database but missing from the app's UI.

## Architecture: Offline-First with Real-Time Sync
The goal is to maintain the responsiveness of the local-first approach while ensuring data consistency with the cloud.

1.  **Read Path:** UI -> Providers -> Local Repository (Hive).
2.  **Write Path:** UI -> Controller -> Local Repository (Hive) -> Background Sync -> Cloud Repository (Supabase).
3.  **Sync Path (Missing Piece):** Cloud Repository (Supabase Realtime) -> Sync Provider -> Local Repository (Hive).

## Implementation Plan

### 1. New Component: `CalendarSyncProvider`
Create a new provider file: `apps/mobile/lib/features/calendar/providers/calendar_sync_provider.dart`.

This provider will be responsible for:
-   **Initial Fetch:** On startup, download all relevant events from Supabase to backfill the local database.
-   **Real-time Subscription:** Listen to `INSERT`, `UPDATE`, and `DELETE` events on the `calendar_events` table.
-   **Conflict Resolution:** Simple "last write wins" or "server wins" strategy for now.

#### Proposed Logic
```dart
@riverpod
class CalendarSync extends _$CalendarSync {
  @override
  Stream<void> build() {
    // 1. Listen to authentication state
    final authState = ref.watch(authStateProvider);
    
    if (authState.session != null) {
      // 2. Trigger initial fetch
      _initialSync();
      
      // 3. Subscribe to real-time changes
      return _subscribeToChanges();
    }
    
    return const Stream.empty();
  }
  
  Future<void> _initialSync() async {
    // Fetch events from Supabase
    // Upsert into Hive using CalendarLocalRepository
  }
  
  Stream<void> _subscribeToChanges() {
    // Use Supabase stream() or on() methods
    // On change: update Hive
  }
}
```

### 2. Integration
In `apps/mobile/lib/features/calendar/screens/calendar_screen.dart`, watch the sync provider to ensure it's active when the user is viewing the calendar.

```dart
// Inside build method
ref.watch(calendarSyncProvider);
```

### 3. Data Flow Details
-   **Incoming INSERT:** Convert JSON to `CalendarEventLocal` -> `box.put(id, event)`.
-   **Incoming UPDATE:** Convert JSON to `CalendarEventLocal` -> `box.put(id, event)`.
-   **Incoming DELETE:** `box.delete(id)`.

After any local database change, the existing Riverpod providers (like `monthlyEventsProvider`) will automatically rebuild because they watch the Hive box (or can be invalidated), updating the UI instantly.

## Checklist
- [ ] Create `calendar_sync_provider.dart`.
- [ ] Implement `_initialSync` to fetch upcoming/recent events.
- [ ] Implement `_subscribeToChanges` for real-time updates.
- [ ] Add `ref.watch(calendarSyncProvider)` to `CalendarScreen`.
- [ ] Verify additions, updates, and deletions reflect in the UI.
