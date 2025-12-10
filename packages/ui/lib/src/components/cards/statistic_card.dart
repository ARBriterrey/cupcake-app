import 'package:flutter/material.dart';
import '../../constants/spacing.dart';
import '../../helpers/text_styles.dart';
import 'info_card.dart';

/// A card displaying a statistic with label and optional icon
///
/// Features:
/// - Large number display
/// - Descriptive label
/// - Optional icon
/// - Centered layout
///
/// Example:
/// ```dart
/// StatisticCard(
///   value: '127',
///   label: 'Days Together',
///   icon: Icons.favorite,
///   iconColor: Colors.pink,
/// )
/// ```
class StatisticCard extends StatelessWidget {
  const StatisticCard({
    super.key,
    required this.value,
    required this.label,
    this.icon,
    this.iconColor,
    this.onTap,
  });

  final String value;
  final String label;
  final IconData? icon;
  final Color? iconColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InfoCard(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 32,
              color: iconColor ?? theme.colorScheme.primary,
            ),
            const SizedBox(height: Spacing.sm),
          ],
          Text(
            value,
            style: theme.textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: Spacing.xs),
          Text(
            label,
            style: theme.textTheme.bodyMedium?.secondary,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
