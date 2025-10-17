import 'package:flutter/widgets.dart';

/// A utility class to hold the custom colors used in the app.
///
class AppColors {
  static Color get airForceBlue => Color(0xFF46829E);
  static Color get lightOrange => Color(0xFFFED9B8);
  static Color get tiffanyBlue => Color(0xFF86DFE3);
  static Color get cordovanRed => Color(0xFF9C3848);
}

// Extension to provide handy color transforms like `darker` and `lighter`.
extension AppColorExtension on Color {
  /// Returns a darker version of this color.
  ///
  /// The optional [amount] is how much to reduce lightness (0.0 - 1.0).
  /// Default is 0.20 (20% darker).
  Color darken([double amount = 0.20]) {
    final hsl = HSLColor.fromColor(this);
    final lightness = (hsl.lightness - amount).clamp(0.0, 1.0);
    return hsl.withLightness(lightness).toColor();
  }

  /// A convenient getter for a slightly darker color.
  Color get darker => darken();

  /// Returns a lighter version of this color.
  ///
  /// The optional [amount] is how much to increase lightness (0.0 - 1.0).
  /// Default is 0.20 (20% lighter).
  Color lighten([double amount = 0.20]) {
    final hsl = HSLColor.fromColor(this);
    final lightness = (hsl.lightness + amount).clamp(0.0, 1.0);
    return hsl.withLightness(lightness).toColor();
  }

  /// A convenient getter for a slightly lighter color.
  Color get lighter => lighten();
}
