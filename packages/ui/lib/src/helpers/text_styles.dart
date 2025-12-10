import 'package:flutter/material.dart';
import '../constants/opacities.dart';

/// Extension methods for TextStyle to make common modifications easier
extension TextStyleHelpers on TextStyle {
  /// Apply secondary opacity (60%) to the text color
  TextStyle get secondary => copyWith(
        color: color?.withOpacity(Opacities.secondary),
      );

  /// Apply disabled opacity (38%) to the text color
  TextStyle get disabled => copyWith(
        color: color?.withOpacity(Opacities.disabled),
      );

  /// Apply subtle opacity (87%) to the text color
  TextStyle get subtle => copyWith(
        color: color?.withOpacity(Opacities.subtle),
      );

  /// Make the text bold (FontWeight.w700)
  TextStyle get bold => copyWith(fontWeight: FontWeight.w700);

  /// Make the text semi-bold (FontWeight.w600)
  TextStyle get semiBold => copyWith(fontWeight: FontWeight.w600);

  /// Make the text medium weight (FontWeight.w500)
  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);

  /// Make the text regular weight (FontWeight.w400)
  TextStyle get regular => copyWith(fontWeight: FontWeight.w400);

  /// Apply italic style
  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);
}
