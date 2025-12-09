import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/calendar_event.dart';
import '../../../core/theme/app_theme.dart';
import '../providers/calendar_providers.dart';
import 'calendar_day_cell.dart';

/// A month view calendar widget that displays all days in a month with events
class CalendarMonthView extends ConsumerWidget {
  final int year;
  final int month;
  final Function(DateTime)? onDaySelected;

  const CalendarMonthView({
    super.key,
    required this.year,
    required this.month,
    this.onDaySelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);
    final eventsAsync = ref.watch(
      monthlyEventsProvider(year: year, month: month),
    );

    // Get the first day of the month and calculate the grid
    final firstDayOfMonth = DateTime(year, month, 1);
    final lastDayOfMonth = DateTime(year, month + 1, 0);
    final daysInMonth = lastDayOfMonth.day;
    final firstWeekday = firstDayOfMonth.weekday % 7; // 0 = Sunday

    return Column(
      children: [
        // Weekday headers
        _buildWeekdayHeaders(),
        const SizedBox(height: 8),

        // Calendar grid
        eventsAsync.when(
          data: (events) {
            // Group events by day
            final eventsByDay = <int, List<CalendarEvent>>{};
            for (final event in events) {
              final day = event.startTime.toLocal().day;
              eventsByDay.putIfAbsent(day, () => []).add(event);
            }

            return _buildCalendarGrid(
              context,
              ref,
              firstWeekday,
              daysInMonth,
              selectedDate,
              eventsByDay,
            );
          },
          loading: () => const Center(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: CircularProgressIndicator(),
            ),
          ),
          error: (error, stack) => _buildCalendarGrid(
            context,
            ref,
            firstWeekday,
            daysInMonth,
            selectedDate,
            {},
          ),
        ),
      ],
    );
  }

  Widget _buildWeekdayHeaders() {
    const weekdays = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: weekdays.map((day) {
        return Expanded(
          child: Center(
            child: Text(
              day,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppTheme.textLight,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCalendarGrid(
    BuildContext context,
    WidgetRef ref,
    int firstWeekday,
    int daysInMonth,
    DateTime selectedDate,
    Map<int, List<CalendarEvent>> eventsByDay,
  ) {
    final cells = <Widget>[];

    // Add empty cells for days before the first day of the month
    for (int i = 0; i < firstWeekday; i++) {
      cells.add(const SizedBox.shrink());
    }

    // Add cells for each day in the month
    for (int day = 1; day <= daysInMonth; day++) {
      final date = DateTime(year, month, day);
      final isSelected = selectedDate.year == year &&
          selectedDate.month == month &&
          selectedDate.day == day;
      final isToday = DateTime.now().year == year &&
          DateTime.now().month == month &&
          DateTime.now().day == day;
      final events = eventsByDay[day] ?? [];

      cells.add(
        CalendarDayCell(
          date: date,
          isSelected: isSelected,
          isToday: isToday,
          eventCount: events.length,
          events: events,
          onTap: () {
            ref.read(selectedDateProvider.notifier).setDate(date);
            onDaySelected?.call(date);
          },
        ),
      );
    }

    return GridView.count(
      crossAxisCount: 7,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: 0.85,
      children: cells,
    );
  }
}
