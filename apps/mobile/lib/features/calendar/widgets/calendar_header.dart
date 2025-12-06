import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_theme.dart';
import '../providers/calendar_providers.dart';

/// Calendar header with month/year display and navigation controls
class CalendarHeader extends ConsumerWidget {
  const CalendarHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);
    final monthYear = DateFormat('MMMM yyyy').format(selectedDate);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Previous month button
          IconButton(
            onPressed: () {
              ref.read(selectedDateProvider.notifier).previousMonth();
            },
            icon: const Icon(Icons.chevron_left),
            color: AppTheme.textDark,
            tooltip: 'Previous month',
          ),

          // Month and year
          Expanded(
            child: GestureDetector(
              onTap: () {
                ref.read(selectedDateProvider.notifier).setToday();
              },
              child: Column(
                children: [
                  Text(
                    monthYear,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textDark,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (!_isCurrentMonth(selectedDate))
                    Text(
                      'Tap to go to today',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppTheme.textLight,
                      ),
                    ),
                ],
              ),
            ),
          ),

          // Next month button
          IconButton(
            onPressed: () {
              ref.read(selectedDateProvider.notifier).nextMonth();
            },
            icon: const Icon(Icons.chevron_right),
            color: AppTheme.textDark,
            tooltip: 'Next month',
          ),
        ],
      ),
    );
  }

  bool _isCurrentMonth(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month;
  }
}
