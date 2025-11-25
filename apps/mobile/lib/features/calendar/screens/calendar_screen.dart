import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/widgets/empty_state_widget.dart';

class CalendarScreen extends ConsumerWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(24),
        child: EmptyStateWidget(
          icon: Icons.calendar_month_outlined,
          title: 'Calendar Coming Soon',
          description:
              'Your shared calendar for tracking moments, events, and memories together.',
        ),
      ),
    );
  }
}
