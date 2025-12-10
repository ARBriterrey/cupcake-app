import 'package:flutter/material.dart';

/// Standard border radius constants for consistent rounded corners
///
/// Follows the Cupcake brand guidelines: warm, soft, minimal with rounded corners.
class BorderRadii {
  const BorderRadii._();

  /// Small radius (8px)
  static const double sm = 8.0;

  /// Medium radius (12px) - Default for inputs and smaller buttons
  static const double md = 12.0;

  /// Large radius (16px) - Default for cards
  static const double lg = 16.0;

  /// Extra large radius (24px)
  static const double xl = 24.0;

  /// Circular (pill shape)
  static const double circular = 999.0;

  // BorderRadius helpers
  static BorderRadius get smallRadius => BorderRadius.circular(sm);
  static BorderRadius get mediumRadius => BorderRadius.circular(md);
  static BorderRadius get largeRadius => BorderRadius.circular(lg);
  static BorderRadius get extraLargeRadius => BorderRadius.circular(xl);
  static BorderRadius get circularRadius => BorderRadius.circular(circular);
}
