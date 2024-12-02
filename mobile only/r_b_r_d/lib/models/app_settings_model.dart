import 'package:flutter/material.dart';

/// Model for the application settings.
class AppSettingsModel {
  final Locale localeLanguage;
  final Locale localeCurrency;
  final ThemeMode themeMode;

  /// Sets the default value for the application theme.
  static const ThemeMode defaultThemeMode = ThemeMode.light;

  /// Sets the default value for the application locale language.
  static const Locale defaultLocaleLanguage = Locale('en', 'US');

  /// Sets the default value for the application locale currency.
  static const Locale defaultLocaleCurrency = defaultLocaleLanguage;

  /// Constructor for creating an AppSettings instance.
  AppSettingsModel({
    this.localeLanguage = defaultLocaleLanguage,
    this.localeCurrency = defaultLocaleCurrency,
    this.themeMode = defaultThemeMode,
  });

  /// Create an AppSettings instance from a JSON map.
  factory AppSettingsModel.fromJson(Map<String, dynamic> json) {
    return AppSettingsModel(
      localeLanguage: Locale(
        json['languageCodeLang'] as String? ?? defaultLocaleLanguage.languageCode,
        json['countryCodeLang'] as String? ?? defaultLocaleLanguage.countryCode,
      ),
      localeCurrency: Locale(
        json['languageCodeCurr'] as String? ?? defaultLocaleCurrency.languageCode,
        json['countryCodeCurr'] as String? ?? defaultLocaleCurrency.countryCode,
      ),
      themeMode:
          ThemeMode.values[json['themeMode'] as int? ?? defaultThemeMode.index],
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
    };
  }

  /// Creates a copy of the current AppSettingsModel with the option to modify specific properties. If a property is not provided, the current value is retained.
  /// This method is used to create a new instance of AppSettingsModel with modified properties.
  AppSettingsModel copyWith({
    Locale? localeLanguage,
    Locale? localeCurrency,
    ThemeMode? themeMode,
  }) {
    return AppSettingsModel(
      localeLanguage: localeLanguage ?? this.localeLanguage,
      localeCurrency: localeCurrency ?? this.localeCurrency,
      themeMode: themeMode ?? this.themeMode,
    );
  }
}
