import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// [L10n] is responsible for declaring the supported locales for languages and currencies.
class L10n {
  static final supportedLocalesLanguages = [
    const Locale('en', 'US'),
    const Locale('it', 'IT'),
  ];
  static final supportedLocalesCurrencies = [
    const Locale('en', 'US'),
    const Locale('en', 'GB'),
    const Locale('it', 'IT'),
  ];

  static const localizationsDelegates = [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];
}

// Run 'flutter gen-l10n' every time that you add a new locale or add something in the arb files.