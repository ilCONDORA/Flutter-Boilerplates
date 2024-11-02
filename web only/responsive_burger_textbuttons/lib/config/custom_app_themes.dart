import 'package:flutter/material.dart';

/// [CustomAppThemes] is responsible for the creation of the themes for the app.
class CustomAppThemes {
  /// [_baseTheme] is the base theme of the app.
  /// It is used as a base to create the light and dark themes.
  static ThemeData _baseTheme() => ThemeData();

  static ThemeData get lightTheme => _baseTheme().copyWith(
        scaffoldBackgroundColor: Color(Colors.grey.shade100.value),
        iconTheme: const IconThemeData(color: Colors.black),
        appBarTheme: AppBarTheme(color: Colors.grey.shade300),
        drawerTheme: DrawerThemeData(backgroundColor: Colors.grey.shade300),
      );

  static ThemeData get darkTheme => _baseTheme().copyWith(
        scaffoldBackgroundColor: Color(Colors.grey.shade600.value),
        iconTheme: const IconThemeData(color: Colors.white),
        appBarTheme: const AppBarTheme(color: Colors.black54),
        drawerTheme: DrawerThemeData(backgroundColor: Colors.grey.shade500),
      );
}
