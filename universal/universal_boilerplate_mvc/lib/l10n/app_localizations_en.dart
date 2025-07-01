// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get app_name => 'Application Example Internationalization';

  @override
  String get example_text => 'This text is an example, trash can is US specific';
}

/// The translations for English, as used in the United Kingdom (`en_GB`).
class AppLocalizationsEnGb extends AppLocalizationsEn {
  AppLocalizationsEnGb(): super('en_GB');

  @override
  String get app_name => 'Application Example Internationalization';

  @override
  String get example_text => 'This text is an example, rubbish bin is GB specific';
}
