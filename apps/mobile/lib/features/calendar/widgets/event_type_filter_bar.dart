import 'package:flutter/material.dart';
import 'package:cupcake_core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cupcake_ui/ui.dart';
import '../providers/calendar_providers.dart';

/// Filter bar for toggling event type visibility
/// Displays horizontally scrollable filter chips for each event type
class EventTypeFilterBar extends ConsumerWidget {
  const EventTypeFilterBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(activeEventTypeFiltersProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: EventType.values.map((type) {
            final isActive = activeFilters.contains(type);
            final color = CupcakeTheme.getEventTypeColor(type);

            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(_getEventTypeLabel(type)),
                selected: isActive,
                onSelected: (selected) {
                  final newFilters = {...activeFilters};
                  if (selected) {
                    newFilters.add(type);
                  } else {
                    // Don't allow deselecting all filters
                    if (newFilters.length > 1) {
                      newFilters.remove(type);
                    }
                  }
                  ref.read(activeEventTypeFiltersProvider.notifier).state = newFilters;
                },
                backgroundColor: Colors.white,
                selectedColor: color.withOpacity(0.2),
                checkmarkColor: color,
                labelStyle: TextStyle(
                  color: isActive ? color : CupcakeTheme.textLight,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                  fontSize: 14,
                ),
                side: BorderSide(
                  color: isActive ? color : CupcakeTheme.textLight.withOpacity(0.3),
                  width: isActive ? 2 : 1,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
            );
          }).toList(),
        ),
      ),
    );
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
}
