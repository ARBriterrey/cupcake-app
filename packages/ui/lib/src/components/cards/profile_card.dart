import 'package:flutter/material.dart';
import '../../constants/spacing.dart';
import '../../helpers/text_styles.dart';
import 'info_card.dart';

/// A card displaying user profile information
///
/// Features:
/// - Avatar (CircleAvatar or custom widget)
/// - Primary text (name/title)
/// - Secondary text (email/subtitle)
/// - Consistent layout and spacing
///
/// Example:
/// ```dart
/// ProfileCard(
///   avatar: CircleAvatar(child: Text('AB')),
///   primaryText: 'Alice Brown',
///   secondaryText: 'alice@example.com',
/// )
/// ```
class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    this.avatar,
    required this.primaryText,
    this.secondaryText,
    this.trailing,
    this.onTap,
  });

  final Widget? avatar;
  final String primaryText;
  final String? secondaryText;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InfoCard(
      onTap: onTap,
      child: Row(
        children: [
          if (avatar != null) ...[
            avatar!,
            const SizedBox(width: Spacing.md),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  primaryText,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (secondaryText != null) ...[
                  const SizedBox(height: Spacing.xs),
                  Text(
                    secondaryText!,
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
