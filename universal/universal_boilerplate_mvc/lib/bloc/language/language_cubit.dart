import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../l10n/l10n.dart';

part 'language_state.dart';

/// [LanguageCubit] manages the application's language settings and it also saves it thanks to the [HydratedBloc] implementation.
///
/// First of all call [autoInitialize], "BlocProvider(create: (_) => LanguageCubit()..autoInitialize())", to set the initial language based on the system locale.
/// If the system locale language is not supported, it will search for the closest supported language using the [_findBestSupportedLanguage] method.
/// If there's no match, it will default to the default language defined in the constant variable [_defaultLanguage].
///
/// To change the language, use the [changeLanguage] method.
///
class LanguageCubit extends HydratedCubit<LanguageState> {
  static const Locale _defaultLanguage = Locale('en', 'US');

  /// Constructor for [LanguageCubit]. It uses the constructor of [LanguageState] that requires an initial active language and [LanguageState.isInitialized] but this one is false by default
  /// and no one is allowed to change it except the [autoInitialize] method.
  ///
  /// This initial(default) language will be overridden by the [autoInitialize] method when it's called in the [BlocProvider].
  ///
  LanguageCubit() : super(LanguageState(activeLanguage: _defaultLanguage));

  /// Method that needs to be called to initialize the language settings based on the system locale.
  ///
  /// When you start the app for the first time the if statement will return false because [LanguageState.isInitialized] will be equal to false because
  /// it is set to false by default in the constructor of [LanguageState], and then it will get the system locale using [PlatformDispatcher.instance.locale] and
  /// by calling the [_findBestSupportedLanguage] method it will find the closest supported language to the system locale and set it as the active language.
  ///
  /// All the other times you open the app, the if statement will return true because [LanguageState.isInitialized] will be equal to true, so it will not trigger the initialization process again and
  /// the active language will remain the same as the one set in the previous initialization thanks to the [HydratedCubit] implementation that saves the state in the local storage.
  ///
  void autoInitialize() {
    if (state.isInitialized) return;

    final Locale systemLocale = PlatformDispatcher.instance.locale;
    final Locale selectedLanguage = _findBestSupportedLanguage(systemLocale);

    emit(state.copyWith(activeLanguage: selectedLanguage, isInitialized: true));
  }

  /// Method that finds the best supported language based on the locale passed as a parameter, likely the system locale.
  ///
  /// So, the method will first look for an exact match of the language and country code, then it will look for a match only for the language code.
  /// If no match is found, it will return the default language defined in the constant variable [_defaultLanguage].
  ///
  Locale _findBestSupportedLanguage(Locale systemLocale) {
    final List<Locale> supportedLanguages = L10n.supportedLanguages;

    // First of all, look for an exact match (language + country).
    for (final Locale supportedLanguage in supportedLanguages) {
      if (supportedLanguage.languageCode == systemLocale.languageCode &&
          supportedLanguage.countryCode == systemLocale.countryCode) {
        return supportedLanguage;
      }
    }

    // Then look for a matching only for the language code.
    for (final Locale supportedLanguage in supportedLanguages) {
      if (supportedLanguage.languageCode == systemLocale.languageCode) {
        return supportedLanguage;
      }
    }

    // If no match is found, return the default language.
    return _defaultLanguage;
  }

  /// Method that accepts a new locale and emits a new [LanguageState] with the updated active language only if it's different from the current language.
  ///
  void changeLanguage(Locale newLocale) {
    if (state.activeLanguage != newLocale) {
      emit(state.copyWith(activeLanguage: newLocale));
    }
  }

  @override
  LanguageState? fromJson(Map<String, dynamic> json) {
    return LanguageState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(LanguageState state) {
    return state.toJson();
  }
}
