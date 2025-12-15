import 'package:flutter/material.dart';
import 'package:cupcake_core/core.dart';
import 'package:intl/intl.dart';
import '../../../core/models/calendar_event.dart';
import 'package:cupcake_ui/ui.dart';

/// A list widget that displays calendar events for a specific date
class CalendarEventList extends StatelessWidget {
  final List<CalendarEvent> events;
  final Function(CalendarEvent)? onEventTap;

  const CalendarEventList({
    super.key,
    required this.events,
    this.onEventTap,
  });

  @override
  Widget build(BuildContext context) {
    if (events.isEmpty) {
      return const EmptyStateWidget(
        icon: Icons.event_outlined,
        title: 'No events today',
        description: 'Tap + to add a moment together',
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: events.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final event = events[index];
        return _EventCard(
          event: event,
          onTap: onEventTap != null ? () => onEventTap!(event) : null,
        );
      },
    );
  }
}

class _EventCard extends StatelessWidget {
  final CalendarEvent event;
  final VoidCallback? onTap;

  const _EventCard({
    required this.event,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final eventColor = _getEventColor();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: eventColor.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event type indicator
            Container(
              width: 4,
              height: 48,
              decoration: BoxDecoration(
                color: eventColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 12),

            // Event details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    event.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),

                  const SizedBox(height: 4),

                  // Time
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 14,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _formatTime(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),

                  // Location
                  if (event.location != null) ...[
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 14,
                          color: CupcakeTheme.textLight,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            event.location!,
                            style: TextStyle(
                              fontSize: 13,
                              color: CupcakeTheme.textLight,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],

                  // Description preview
                  if (event.description != null && event.description!.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      event.description!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: CupcakeTheme.textDark,
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],

                  // Tags
                  if (event.tags.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: event.tags.take(3).map((tag) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: eventColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            tag,
                            style: TextStyle(
                              fontSize: 11,
                              color: eventColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ],
              ),
            ),

            // Visibility indicator
            if (event.visibility == EventVisibility.private)
              Icon(
                Icons.lock_outline,
                size: 16,
                color: CupcakeTheme.textLight,
              ),
          ],
        ),
      ),
    );
  }

  Color _getEventColor() {
    // Use custom color if set
    if (event.color != null) {
      try {
        return Color(int.parse(event.color!.replaceFirst('#', '0xff')));
      } catch (e) {
        // Fall through to type-based color
      }
    }

    // Use event type color
    return CupcakeTheme.getEventTypeColor(event.eventType);
  }

  String _formatTime() {
    if (event.isAllDay) {
      return 'All day';
    }

    final timeFormat = DateFormat('h:mm a');
    if (event.endTime != null) {
      return '${timeFormat.format(event.startTime)} - ${timeFormat.format(event.endTime!)}';
    }

    return timeFormat.format(event.startTime);
  }
}
