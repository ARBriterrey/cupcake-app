import 'package:flutter/material.dart';
import 'package:cupcake_core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/models/calendar_event.dart';
import 'package:cupcake_ui/ui.dart';
import '../providers/calendar_providers.dart';
import 'add_event_bottom_sheet.dart';

/// Bottom sheet for viewing and managing an event
class EventDetailsBottomSheet extends ConsumerStatefulWidget {
  final CalendarEvent event;

  const EventDetailsBottomSheet({
    super.key,
    required this.event,
  });

  @override
  ConsumerState<EventDetailsBottomSheet> createState() =>
      _EventDetailsBottomSheetState();
}

class _EventDetailsBottomSheetState
    extends ConsumerState<EventDetailsBottomSheet> {
  bool _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    final event = widget.event;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header with close button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        event.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: CupcakeTheme.textDark,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close),
                      color: CupcakeTheme.textLight,
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Event type badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _getEventTypeColor(event.eventType).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _getEventTypeLabel(event.eventType),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: _getEventTypeColor(event.eventType),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Date and time
                _buildInfoRow(
                  icon: Icons.calendar_today,
                  label: 'Date',
                  value: DateFormat('EEEE, MMMM d, y').format(event.startTime),
                ),

                const SizedBox(height: 16),

                _buildInfoRow(
                  icon: Icons.access_time,
                  label: 'Time',
                  value: _formatTime(event),
                ),

                // Location
                if (event.location != null) ...[
                  const SizedBox(height: 16),
                  _buildInfoRow(
                    icon: Icons.location_on_outlined,
                    label: 'Location',
                    value: event.location!,
                  ),
                ],

                // Description
                if (event.description != null &&
                    event.description!.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: CupcakeTheme.textLight,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    event.description!,
                    style: const TextStyle(
                      fontSize: 16,
                      color: CupcakeTheme.textDark,
                      height: 1.5,
                    ),
                  ),
                ],

                // Tags
                if (event.tags.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  const Text(
                    'Tags',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: CupcakeTheme.textLight,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: event.tags.map((tag) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: CupcakeTheme.primaryPink.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          tag,
                          style: const TextStyle(
                            fontSize: 13,
                            color: CupcakeTheme.textDark,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],

                // Visibility
                const SizedBox(height: 24),
                _buildInfoRow(
                  icon: event.visibility == EventVisibility.shared
                      ? Icons.people_outline
                      : Icons.lock_outline,
                  label: 'Visibility',
                  value: event.visibility == EventVisibility.shared
                      ? 'Shared with your partner'
                      : 'Private',
                ),

                const SizedBox(height: 32),

                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _isDeleting ? null : _deleteEvent,
                        icon: _isDeleting
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(Icons.delete_outline),
                        label: const Text('Delete'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _isDeleting ? null : _editEvent,
                        icon: const Icon(Icons.edit_outlined),
                        label: const Text('Edit'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CupcakeTheme.primaryPink,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20,
          color: CupcakeTheme.textLight,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: CupcakeTheme.textLight,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  color: CupcakeTheme.textDark,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatTime(CalendarEvent event) {
    if (event.isAllDay) {
      return 'All day';
    }

    final timeFormat = DateFormat('h:mm a');
    if (event.endTime != null) {
      return '${timeFormat.format(event.startTime)} - ${timeFormat.format(event.endTime!)}';
    }

    return timeFormat.format(event.startTime);
  }

  Color _getEventTypeColor(EventType type) {
    return CupcakeTheme.getEventTypeColor(type);
  }

  String _getEventTypeLabel(EventType type) {
    switch (type) {
      case EventType.wellness:
        return 'Wellness';
      case EventType.reflections:
        return 'Reflections';
      case EventType.habits:
        return 'Habits';
      case EventType.games:
        return 'Games';
      case EventType.annuals:
        return 'Annuals';
      case EventType.reminders:
        return 'Reminders';
      case EventType.others:
        return 'Others';
    }
  }

  Future<void> _deleteEvent() async {
    // Show confirmation dialog
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete event?'),
        content: const Text(
          'This event will be deleted. Recoverable for 30 days.',
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      setState(() {
        _isDeleting = true;
      });

      try {
        await ref
            .read(calendarEventDeleterProvider.notifier)
            .deleteEvent(widget.event.id);

        if (mounted) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Event deleted'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error deleting event: ${e.toString()}'),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isDeleting = false;
          });
        }
      }
    }
  }

  void _editEvent() {
    Navigator.of(context).pop();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddEventBottomSheet(
        eventToEdit: widget.event,
      ),
    );
  }
}
