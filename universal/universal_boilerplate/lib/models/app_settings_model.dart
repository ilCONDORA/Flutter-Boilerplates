import 'package:flutter/material.dart';

/// Model for the application settings.
class AppSettingsModel {
  final Locale localeLanguage;
  final Locale localeCurrency;
  final ThemeMode themeMode;
  final Size windowSize;
  final Offset windowPosition;
  final bool isMaximized;

  /// Sets the default value for the application theme.
  static const ThemeMode defaultThemeMode = ThemeMode.light;

  /// Sets the default value for the application locale language.
  static const Locale defaultLocaleLanguage = Locale('en', 'US');

  /// Sets the default value for the application locale currency.
  static const Locale defaultLocaleCurrency = defaultLocaleLanguage;

  /// Sets the default/minimum value for the application window size.
  static const Size defaultWindowSize = Size(800, 700);

  /// Sets the default value for the application window position.
  static const Offset defaultWindowPosition = Offset(100, 100);

  /// Sets the default value for the application window maximization state.
  static const bool defaultIsMaximized = false;

  /// Constructor for creating an AppSettings instance.
  AppSettingsModel({
    this.localeLanguage = defaultLocaleLanguage,
    this.localeCurrency = defaultLocaleCurrency,
    this.themeMode = defaultThemeMode,
    this.windowSize = defaultWindowSize,
    this.windowPosition = defaultWindowPosition,
    this.isMaximized = defaultIsMaximized,
  });

  /// Create an AppSettings instance from a JSON map.
  factory AppSettingsModel.fromJson(Map<String, dynamic> json) {
    return AppSettingsModel(
      localeLanguage: Locale(
        json['languageCodeLang'] as String? ??
            defaultLocaleLanguage.languageCode,
        json['countryCodeLang'] as String? ?? defaultLocaleLanguage.countryCode,
      ),
      localeCurrency: Locale(
        json['languageCodeCurr'] as String? ??
            defaultLocaleCurrency.languageCode,
        json['countryCodeCurr'] as String? ?? defaultLocaleCurrency.countryCode,
      ),
      themeMode:
          ThemeMode.values[json['themeMode'] as int? ?? defaultThemeMode.index],
      windowSize: Size(
        json['windowSize']['width'] as double? ?? defaultWindowSize.width,
        json['windowSize']['height'] as double? ?? defaultWindowSize.height,
      ),
      windowPosition: Offset(
        json['windowPosition']['x'] as double? ?? defaultWindowPosition.dx,
        json['windowPosition']['y'] as double? ?? defaultWindowPosition.dy,
      ),
      isMaximized: json['isMaximized'] as bool? ?? defaultIsMaximized,
    );
  }

  /// Converts an AppSettings instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'languageCodeLang': localeLanguage.languageCode,
      'countryCodeLang': localeLanguage.countryCode,
      'languageCodeCurr': localeCurrency.languageCode,
      'countryCodeCurr': localeCurrency.countryCode,
      'themeMode': themeMode.index,
      'windowSize': {
        'width': windowSize.width,
        'height': windowSize.height,
      },
      'windowPosition': {
        'x': windowPosition.dx,
        'y': windowPosition.dy,
      },
      'isMaximized': isMaximized,
    };
  }

  /// Creates a copy of the current AppSettingsModel with the option to modify specific properties. If a property is not provided, the current value is retained.
  /// This method is used to create a new instance of AppSettingsModel with modified properties.
  AppSettingsModel copyWith({
    Locale? localeLanguage,
    Locale? localeCurrency,
    ThemeMode? themeMode,
    Size? windowSize,
    Offset? windowPosition,
    bool? isMaximized,
  }) {
    return AppSettingsModel(
      localeLanguage: localeLanguage ?? this.localeLanguage,
      localeCurrency: localeCurrency ?? this.localeCurrency,
      themeMode: themeMode ?? this.themeMode,
      windowSize: windowSize ?? this.windowSize,
      windowPosition: windowPosition ?? this.windowPosition,
      isMaximized: isMaximized ?? this.isMaximized,
    );
  }
}
