import 'package:flutter/material.dart';
import '../../constants/border_radii.dart';
import '../../constants/spacing.dart';

/// A base info card with consistent Cupcake styling
///
/// Features:
/// - Consistent rounded corners (16px)
/// - No elevation (flat design)
/// - White background
/// - Customizable padding
///
/// Example:
/// ```dart
/// InfoCard(
///   child: Column(
///     children: [
///       Text('Title'),
///       Text('Description'),
///     ],
///   ),
/// )
/// ```
class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(Spacing.md),
    this.color,
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final card = Card(
      color: color,
      child: Padding(
        padding: padding,
        child: child,
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadii.largeRadius,
        child: card,
      );
    }

    return card;
  }
}
