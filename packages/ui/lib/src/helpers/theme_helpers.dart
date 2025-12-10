import 'package:flutter/material.dart';

/// Extension on BuildContext for quick theme access
///
/// Makes accessing theme properties more concise and readable.
///
/// Example:
/// ```dart
/// // Instead of:
/// final color = Theme.of(context).colorScheme.primary;
///
/// // Use:
/// final color = context.colors.primary;
/// ```
extension ThemeQuickAccess on BuildContext {
  /// Quick access to ColorScheme
  ColorScheme get colors => Theme.of(this).colorScheme;

  /// Quick access to TextTheme
  TextTheme get textStyles => Theme.of(this).textTheme;

  /// Quick access to full ThemeData
  ThemeData get theme => Theme.of(this);
}
