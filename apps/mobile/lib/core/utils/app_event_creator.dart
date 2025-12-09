/// Helper utility for creating app-triggered calendar events
/// Used by sprinkles/addons to create events that integrate with the calendar
class AppEventCreator {
  /// Creates metadata for an app-triggered event
  ///
  /// [source] - The name of the sprinkle/app creating the event (e.g., 'habit_tracker', 'anniversary_reminder')
  /// [triggeredBy] - The specific action that triggered the event (e.g., 'habit_completion', 'anniversary_detected')
  /// [additionalData] - Any additional metadata specific to the source app
  ///
  /// Returns a Map that should be passed as the `metadata` parameter when creating a CalendarEvent
  static Map<String, dynamic> createAppEventMetadata({
    required String source,
    String? triggeredBy,
    Map<String, dynamic>? additionalData,
  }) {
    return {
      'app_triggered': true,
      'source': source,
      if (triggeredBy != null) 'triggered_by': triggeredBy,
      'triggered_at': DateTime.now().toIso8601String(),
      ...?additionalData,
    };
  }

  /// Checks if an event was created by an app/sprinkle
  ///
  /// [metadata] - The metadata map from a CalendarEvent
  ///
  /// Returns true if the event was app-triggered, false if user-created
  static bool isAppTriggered(Map<String, dynamic> metadata) {
    return metadata['app_triggered'] == true || metadata['source'] == 'app';
  }

  /// Gets the source app name from event metadata
  ///
  /// [metadata] - The metadata map from a CalendarEvent
  ///
  /// Returns the source app name, or 'user' if it was user-created
  static String getEventSource(Map<String, dynamic> metadata) {
    return metadata['source'] as String? ?? 'user';
  }

  /// Gets the trigger action from event metadata
  ///
  /// [metadata] - The metadata map from a CalendarEvent
  ///
  /// Returns the trigger action, or null if not specified
  static String? getTriggerAction(Map<String, dynamic> metadata) {
    return metadata['triggered_by'] as String?;
  }

  /// Gets the timestamp when the event was triggered
  ///
  /// [metadata] - The metadata map from a CalendarEvent
  ///
  /// Returns the DateTime when triggered, or null if not available
  static DateTime? getTriggeredAt(Map<String, dynamic> metadata) {
    final timestamp = metadata['triggered_at'] as String?;
    if (timestamp == null) return null;
    try {
      return DateTime.parse(timestamp);
    } catch (e) {
      return null;
    }
  }
}
