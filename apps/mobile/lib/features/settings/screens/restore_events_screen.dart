import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/models/calendar_event.dart';
import 'package:cupcake_ui/ui.dart';
import '../../calendar/providers/calendar_providers.dart';

class RestoreEventsScreen extends ConsumerWidget {
  const RestoreEventsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deletedEventsAsync = ref.watch(deletedEventsProvider);

    return Scaffold(
      backgroundColor: CupcakeTheme.warmGray,
      appBar: AppBar(
        title: const Text('Restore Events'),
        backgroundColor: CupcakeTheme.warmGray,
      ),
      body: deletedEventsAsync.when(
        data: (events) {
          if (events.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.delete_outline,
                    size: 64,
                    color: CupcakeTheme.textLight.withOpacity(0.5),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No deleted events found',
                    style: TextStyle(
                      fontSize: 16,
                      color: CupcakeTheme.textLight,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: events.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final event = events[index];
              return _DeletedEventCard(event: event, ref: ref);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}

class _DeletedEventCard extends StatelessWidget {
  final CalendarEvent event;
  final WidgetRef ref;

  const _DeletedEventCard({required this.event, required this.ref});

  @override
  Widget build(BuildContext context) {
    final textColor = event.isPast ? CupcakeTheme.textLight : CupcakeTheme.textDark;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Date Box
            Container(
              width: 50,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: CupcakeTheme.warmGray,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Text(
                    DateFormat('MMM').format(event.startTime).toUpperCase(),
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: CupcakeTheme.textLight,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    event.startTime.day.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: CupcakeTheme.textDark,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                      decoration: event.isPast ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Deleted ${event.deletedAt != null ? _formatRelative(event.deletedAt!) : ''}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.redAccent,
                    ),
                  ),
                ],
              ),
            ),

            // Restore Button
            IconButton(
              icon: const Icon(Icons.restore, color: CupcakeTheme.primaryPink),
              tooltip: 'Restore Event',
              onPressed: () => _showRestoreConfirmation(context, event),
            ),
          ],
        ),
      ),
    );
  }

  String _formatRelative(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inDays > 0) return '${diff.inDays}d ago';
    if (diff.inHours > 0) return '${diff.inHours}h ago';
    if (diff.inMinutes > 0) return '${diff.inMinutes}m ago';
    return 'just now';
  }

  void _showRestoreConfirmation(BuildContext context, CalendarEvent event) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Restore Event?'),
        content: Text('Do you want to restore "${event.title}" to your calendar?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              
              // Call provider to restore
              await ref.read(calendarEventDeleterProvider.notifier).restoreEvent(event.id);
              
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Restored "${event.title}"')),
                );
              }
            },
            child: const Text('Restore'),
          ),
        ],
      ),
    );
  }
}
