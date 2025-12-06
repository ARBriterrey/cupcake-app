import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/models/calendar_event.dart';
import '../../../core/theme/app_theme.dart';
import '../providers/calendar_providers.dart';
import '../widgets/calendar_header.dart';
import '../widgets/calendar_month_view.dart';
import '../widgets/calendar_event_list.dart';
import '../widgets/add_event_bottom_sheet.dart';
import '../widgets/event_details_bottom_sheet.dart';

class CalendarScreen extends ConsumerWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);
    final selectedDateEventsAsync = ref.watch(selectedDateEventsProvider);

    return Scaffold(
      backgroundColor: AppTheme.warmGray,
      appBar: AppBar(
        title: const Text('Our Calendar'),
        backgroundColor: AppTheme.warmGray,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _showAddEventBottomSheet(context, ref);
            },
            tooltip: 'Add event',
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Calendar header with month navigation
              const CalendarHeader(),

              // Month view calendar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Card(
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: CalendarMonthView(
                      year: selectedDate.year,
                      month: selectedDate.month,
                      onDaySelected: (date) {
                        // Scroll to events list when day is selected
                        // (Additional scroll logic can be added here)
                      },
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Selected date events section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _getDateHeader(selectedDate),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textDark,
                          ),
                        ),
                        if (_isToday(selectedDate))
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryPink.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'Today',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textDark,
                              ),
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Events list
                    selectedDateEventsAsync.when(
                      data: (events) => CalendarEventList(
                        events: events,
                        onEventTap: (event) {
                          _showEventDetailsBottomSheet(context, ref, event);
                        },
                      ),
                      loading: () => const Center(
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      error: (error, stack) => Center(
                        child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.error_outline,
                                size: 48,
                                color: AppTheme.textLight,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Error loading events',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppTheme.textLight,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddEventBottomSheet(context, ref);
        },
        backgroundColor: AppTheme.primaryPink,
        child: const Icon(Icons.add, color: Colors.white),
        tooltip: 'Add a moment together',
      ),
    );
  }

  String _getDateHeader(DateTime date) {
    final now = DateTime.now();
    if (date.year == now.year && date.month == now.month && date.day == now.day) {
      return 'Today';
    } else if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day + 1) {
      return 'Tomorrow';
    } else if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day - 1) {
      return 'Yesterday';
    }

    return DateFormat('EEEE, MMMM d').format(date);
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  void _showAddEventBottomSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddEventBottomSheet(),
    );
  }

  void _showEventDetailsBottomSheet(
    BuildContext context,
    WidgetRef ref,
    CalendarEvent event,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => EventDetailsBottomSheet(event: event),
    );
  }
}
