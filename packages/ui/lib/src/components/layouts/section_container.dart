import 'package:flutter/material.dart';
import '../../constants/spacing.dart';

/// A container for sections with consistent padding
///
/// Features:
/// - Default medium padding (16px)
/// - Customizable padding
/// - Consistent spacing across app
///
/// Example:
/// ```dart
/// SectionContainer(
///   child: Column(
///     children: [
///       Text('Section content'),
///       // More widgets...
///     ],
///   ),
/// )
/// ```
class SectionContainer extends StatelessWidget {
  const SectionContainer({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(Spacing.md),
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: child,
    );
  }
}
