import 'package:flutter/material.dart';
import 'package:cupcake_core/core.dart';

/// Cupcake app theme following brand guidelines:
/// - Warm, soft, minimal, intimate, gentle
/// - Soft pastels, warm neutrals, rounded corners
class CupcakeTheme {
  // Brand Colors
  static const Color primaryPink = Color(0xFFFFC3D0);
  static const Color primaryPeach = Color(0xFFFFD4B8);
  static const Color accentLavender = Color(0xFFE6D5F5);
  static const Color accentMint = Color(0xFFD4F4E6);

  static const Color warmGray = Color(0xFFF5F5F0);
  static const Color textDark = Color(0xFF4A4A4A);
  static const Color textLight = Color(0xFF8A8A8A);

  /// Get color for a specific event type
  /// Each event type has a unique color aligned with the addon categories
  static Color getEventTypeColor(EventType type) {
    switch (type) {
      case EventType.wellness:
        return accentMint; // Soft green for health
      case EventType.reflections:
        return accentLavender; // Soft purple for reflection
      case EventType.habits:
        return primaryPeach; // Warm peach for habits
      case EventType.games:
        return primaryPink; // Playful pink for games
      case EventType.annuals:
        return const Color(0xFFFF6B9D); // Deep pink for celebrations
      case EventType.reminders:
        return const Color(0xFFFFF4B8); // Soft yellow for reminders
      case EventType.others:
        return textLight; // Gray for misc
    }
  }

  /// Light theme (primary theme for Cupcake)
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.light(
      primary: primaryPink,
      secondary: primaryPeach,
      tertiary: accentLavender,
      surface: warmGray,
      onSurface: textDark,
    ),

    // Typography - soft and readable
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: textDark,
        letterSpacing: -0.5,
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: textDark,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: textDark,
        height: 1.5,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: textDark,
        height: 1.5,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textDark,
      ),
    ),

    // Shape - rounded corners throughout
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Colors.white,
    ),

    // Buttons - soft and inviting
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: warmGray),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryPink, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    ),

    // App Bar - clean and minimal
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: warmGray,
      foregroundColor: textDark,
      centerTitle: true,
    ),
  );
}

/// Interface for future custom themes
abstract class CupcakeColors {
  Color get primary;
  Color get secondary;
  Color get surface;
  Color get background;
  Color get textPrimary;
  Color get textSecondary;
}
