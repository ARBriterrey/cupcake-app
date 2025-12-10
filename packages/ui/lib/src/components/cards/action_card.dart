import 'package:flutter/material.dart';
import '../../constants/spacing.dart';
import 'info_card.dart';

/// A card for quick actions with icon and label
///
/// Features:
/// - Centered icon
/// - Label below icon
/// - Tap feedback
/// - Consistent sizing
///
/// Example:
/// ```dart
/// ActionCard(
///   icon: Icons.calendar_today,
///   label: 'Calendar',
///   onTap: () => Navigator.push(...),
/// )
/// ```
class ActionCard extends StatelessWidget {
  const ActionCard({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.iconColor,
    this.iconSize = 32,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? iconColor;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InfoCard(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: iconSize,
            color: iconColor ?? theme.colorScheme.primary,
          ),
          const SizedBox(height: Spacing.sm),
          Text(
            label,
            style: theme.textTheme.labelLarge,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
