import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_localizations.dart';

//* Run 'flutter gen-l10n' every time that you add a new locale or add something in the arb files.

/// This class contains the localization settings for the application.
/// For localization we intend language and currency.
///
/// [supportedLanguages] is a list of [Locale] objects that represent the languages supported by the application.
///
/// [localizationsDelegates] is a list of delegates that provide localized resources for the application. Only used in the main.dart file.
///
class L10n {
  static final List<Locale> supportedLanguages = <Locale>[
    //const Locale('en', 'US'),
    //const Locale('en', 'GB'),
    //const Locale('it', 'IT'),
    const Locale('it'),
    const Locale('en'),
  ];

  static const List<LocalizationsDelegate<Object>> localizationsDelegates =
      <LocalizationsDelegate<Object>>[
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ];
}
