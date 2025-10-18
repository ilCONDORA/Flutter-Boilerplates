import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_it.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('it'),
  ];

  /// Name of the language in English
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageName;

  /// An example text translated into English
  ///
  /// In en, this message translates to:
  /// **'Example text in English'**
  String get example_text;

  /// Name of the Home route
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home_route_name;

  /// Name of the Tasks route
  ///
  /// In en, this message translates to:
  /// **'Tasks'**
  String get tasks_route_name;

  /// Name of the Task Details route
  ///
  /// In en, this message translates to:
  /// **'Task Details'**
  String get task_details_route_name;

  /// Title of the tasks page
  ///
  /// In en, this message translates to:
  /// **'My Tasks'**
  String get tasks_page_title;

  /// Title of the task with ID
  ///
  /// In en, this message translates to:
  /// **'Task {id}'**
  String task_with_id(Object id);

  /// Description of the task with ID
  ///
  /// In en, this message translates to:
  /// **'Description of task with id {id}'**
  String task_description_with_id(Object id);

  /// Description of the task detail page with ID
  ///
  /// In en, this message translates to:
  /// **'Task Detail Page with ID: {id}'**
  String task_detail_page_with_id(Object id);

  /// Error message for loading task details with ID
  ///
  /// In en, this message translates to:
  /// **'Error loading task details with ID: {id}'**
  String task_detail_page_error_with_id(Object id);

  /// Label for the theme setting
  ///
  /// In en, this message translates to:
  /// **'Change Theme'**
  String get setting_theme;

  /// Option for system theme
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get setting_theme_system;

  /// Label for the language setting
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get setting_language;

  /// Input hint for the language dialog search
  ///
  /// In en, this message translates to:
  /// **'Search language...'**
  String get setting_language_dialog_input_hint;

  /// Label for the close button in the language dialog
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get setting_language_dialog_close_button;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'it'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'it':
      return AppLocalizationsIt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
