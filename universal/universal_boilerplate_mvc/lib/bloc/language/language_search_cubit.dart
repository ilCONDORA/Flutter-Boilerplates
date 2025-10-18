import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../l10n/l10n.dart';

/// [LanguageSearchCubit] manages the search functionality for filtering supported languages based on user input.
///
/// This cubit will be used by the dialog that allows users to change the app language.
///
/// The only thing that we can do is use the [search] method to filter the list of supported languages based on the query passed as a parameter.
///
class LanguageSearchCubit extends Cubit<List<Locale>> {
  static final List<Locale> allLanguages = L10n.supportedLanguages;

  LanguageSearchCubit() : super(allLanguages);

  Timer? _searchTimer;

  @override
  Future<void> close() {
    _searchTimer?.cancel();
    return super.close();
  }

  /// Method that filters the list of supported languages based on the query passed as a parameter.
  ///
  /// Before searching, it cancels any existing timer to debounce the input, ensuring that the search is performed only after the user has stopped typing for 250 milliseconds.
  /// The first check inside the timer callback is to see if the query is empty. If it is, it emits the full list of supported languages.
  /// If the query is not empty, it converts the query to lowercase and trims any leading or trailing whitespace.
  /// Then, it filters the list of all supported languages by checking if the language name (in lowercase) contains the query or if the language code contains the query.
  /// Finally, it emits the filtered list of languages.
  ///
  void search(String query) {
    _searchTimer?.cancel();
    _searchTimer = Timer(const Duration(milliseconds: 250), () {
      if (query.isEmpty) {
        emit(allLanguages);
      } else {
        final String formattedQuery = query.toLowerCase().trim();
        emit(
          allLanguages.where((Locale singleLanguage) {
            final String languageName =
                lookupAppLocalizations(
                  singleLanguage,
                ).languageName.toLowerCase();
            return languageName.contains(formattedQuery) ||
                singleLanguage.languageCode.contains(formattedQuery);
          }).toList(),
        );
      }
    });
  }
}
