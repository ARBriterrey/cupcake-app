import 'package:flutter/material.dart';
import '../../constants/spacing.dart';
import '../../helpers/text_styles.dart';

/// A section header with title and optional subtitle
///
/// Features:
/// - Large, bold title
/// - Optional subtitle with secondary text
/// - Consistent spacing
/// - Optional trailing widget (e.g., action button)
///
/// Example:
/// ```dart
/// SectionHeader(
///   title: 'Recent Activity',
///   subtitle: 'Your latest moments together',
///   trailing: IconButton(
///     icon: Icon(Icons.more_horiz),
///     onPressed: () {},
///   ),
/// )
/// ```
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
    this.spacing = Spacing.md,
  });

  final String title;
  final String? subtitle;
  final Widget? trailing;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(bottom: spacing),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: Spacing.xs),
                  Text(
                    subtitle!,
                    style: theme.textTheme.bodyMedium?.secondary,
                  ),
                ],
              ],
            ),
          ),
          if (trailing != null) ...[
            const SizedBox(width: Spacing.md),
            trailing!,
          ],
        ],
      ),
    );
  }
}
