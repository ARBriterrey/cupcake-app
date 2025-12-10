import 'package:flutter/material.dart';
import '../../../core/models/calendar_event.dart';
import '../../../core/theme/app_theme.dart';

/// A single day cell in the calendar month view
class CalendarDayCell extends StatelessWidget {
  final DateTime date;
  final bool isSelected;
  final bool isToday;
  final int eventCount;
  final List<CalendarEvent> events;
  final VoidCallback? onTap;

  const CalendarDayCell({
    super.key,
    required this.date,
    this.isSelected = false,
    this.isToday = false,
    this.eventCount = 0,
    this.events = const [],
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: _getBackgroundColor(),
          borderRadius: BorderRadius.circular(12),
          border: isToday
              ? Border.all(
                  color: AppTheme.primaryPink,
                  width: 2,
                )
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Day number
            Text(
              '${date.day}',
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected || isToday ? FontWeight.w600 : FontWeight.normal,
                color: _getTextColor(),
              ),
            ),

            const SizedBox(height: 4),

            // Event indicators
            if (eventCount > 0) _buildEventIndicators(),
          ],
        ),
      ),
    );
  }

  Color _getBackgroundColor() {
    if (isSelected) {
      return AppTheme.primaryPink;
    }
    if (isToday) {
      return AppTheme.primaryPink.withOpacity(0.1);
    }
    return Colors.transparent;
  }

  Color _getTextColor() {
    if (isSelected) {
      return Colors.white;
    }
    if (isToday) {
      return AppTheme.textDark;
    }
    return AppTheme.textDark;
  }

  Widget _buildEventIndicators() {
    if (eventCount == 0) return const SizedBox.shrink();

    // Show up to 3 dots for events
    final dotCount = eventCount > 3 ? 3 : eventCount;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        dotCount,
        (index) {
          Color dotColor;

          if (index < events.length) {
            // Use event-specific color if available
            if (events[index].color != null) {
              dotColor = Color(
                int.parse(events[index].color!.replaceFirst('#', '0xff')),
              );
            } else {
              // Use event type colors
              dotColor = _getEventTypeColor(events[index].eventType);
            }
          } else {
            dotColor = AppTheme.primaryPeach;
          }

          // If selected, make dots white
          if (isSelected) {
            dotColor = Colors.white;
          }

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 1.5),
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: dotColor,
              shape: BoxShape.circle,
            ),
          );
        },
      ),
    );
  }

  Color _getEventTypeColor(EventType type) {
    return AppTheme.getEventTypeColor(type);
  }
}
