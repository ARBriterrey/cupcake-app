import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../core/models/calendar_event.dart';
import 'package:cupcake_ui/ui.dart';
import '../../calendar/providers/calendar_providers.dart';

/// Widget displaying upcoming calendar events on the dashboard
class UpcomingEventsCard extends ConsumerWidget {
  const UpcomingEventsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final upcomingEventsAsync = ref.watch(upcomingEventsProvider(limit: 3));

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: CupcakeTheme.primaryPink.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.calendar_today,
                        size: 20,
                        color: CupcakeTheme.primaryPink,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Upcoming Together',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: CupcakeTheme.textDark,
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    context.go('/calendar');
                  },
                  child: const Text('See all'),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Events list
            upcomingEventsAsync.when(
              data: (events) {
                if (events.isEmpty) {
                  return _buildEmptyState(context);
                }

                return Column(
                  children: events.map((event) {
                    return _EventItem(event: event);
                  }).toList(),
                );
              },
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(24.0),
                  child: CircularProgressIndicator(),
                ),
              ),
              error: (error, stack) => _buildErrorState(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return EmptyStateWidget(
      icon: Icons.event_outlined,
      title: 'No upcoming events',
      description: 'Tap + to add a moment together',
      actionLabel: 'Add your first moment',
      onActionPressed: () {
        context.go('/calendar');
      },
    );
  }

  Widget _buildErrorState() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Center(
        child: Text(
          'Unable to load events',
          style: TextStyle(
            fontSize: 14,
            color: CupcakeTheme.textLight,
          ),
        ),
      ),
    );
  }
}

class _EventItem extends StatelessWidget {
  final CalendarEvent event;

  const _EventItem({required this.event});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          context.go('/calendar');
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: CupcakeTheme.warmGray,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              // Date indicator
              Container(
                width: 50,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: _getEventTypeColor().withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Text(
                      DateFormat('MMM').format(event.startTime).toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: _getEventTypeColor(),
                      ),
                    ),
                    Text(
                      '${event.startTime.day}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: _getEventTypeColor(),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              // Event details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: CupcakeTheme.textDark,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 14,
                          color: CupcakeTheme.textLight,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _formatTime(),
                          style: TextStyle(
                            fontSize: 13,
                            color: CupcakeTheme.textLight,
                          ),
                        ),
                        if (_daysUntil() <= 7) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: CupcakeTheme.accentMint.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              _daysUntil() == 0
                                  ? 'Today'
                                  : _daysUntil() == 1
                                      ? 'Tomorrow'
                                      : 'In ${_daysUntil()} days',
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: CupcakeTheme.textDark,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),

              // Chevron
              Icon(
                Icons.chevron_right,
                color: CupcakeTheme.textLight,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getEventTypeColor() {
    return CupcakeTheme.getEventTypeColor(event.eventType);
  }

  String _formatTime() {
    if (event.isAllDay) {
      return 'All day';
    }

    final timeFormat = DateFormat('h:mm a');
    return timeFormat.format(event.startTime);
  }

  int _daysUntil() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final eventDate = DateTime(
      event.startTime.year,
      event.startTime.month,
      event.startTime.day,
    );
    return eventDate.difference(today).inDays;
  }
}
