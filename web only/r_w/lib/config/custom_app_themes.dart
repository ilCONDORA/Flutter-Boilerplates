import 'package:flutter/material.dart';

/// [CustomAppThemes] is responsible for the creation of the themes for the app.
class CustomAppThemes {
  /// [_baseTheme] is the base theme of the app.
  /// It is used as a base to create the light and dark themes.
  static ThemeData _baseTheme() => ThemeData();

  static ThemeData get lightTheme => _baseTheme().copyWith(
    scaffoldBackgroundColor: Colors.white,
  );

  static ThemeData get darkTheme => _baseTheme().copyWith(
    scaffoldBackgroundColor: Colors.black,
  );
}
