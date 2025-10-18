part of 'language_cubit.dart';

/// [LanguageState] manages the state of the application's language settings.
///
/// Here we define the variables and methods that will be used to manage the state.
///
@immutable
class LanguageState {
  final Locale activeLanguage;
  final bool isInitialized;

  /// Constructor for [LanguageState].
  ///
  /// It requires an initial active language and a boolean indicating whether the state has been initialized.
  /// the [isInitialized] parameter will be overridden by the [autoInitialize] method in the [LanguageCubit] class when it is called for the first ever time.
  /// The [activeLanguage] parameter is required and should be a [Locale] present in the [L10n.supportedLanguages] list.
  ///
  const LanguageState({
    required this.activeLanguage,
    this.isInitialized = false,
  });

  /// This method creates a copy of the current state with optional new values for [activeLanguage] and [isInitialized].
  ///
  /// It will be used by [changeLanguage] method in the [LanguageCubit] class to change the active language
  /// and for one time only to set the [isInitialized] parameter to true when the [autoInitialize] method is called.
  ///
  LanguageState copyWith({Locale? activeLanguage, bool? isInitialized}) {
    return LanguageState(
      activeLanguage: activeLanguage ?? this.activeLanguage,
      isInitialized: isInitialized ?? this.isInitialized,
    );
  }

  /// Converts the current state to a JSON map.
  /// See concrete implementation in [LanguageCubit].
  ///
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'languageCode': activeLanguage.languageCode,
      'countryCode': activeLanguage.countryCode,
      'isInitialized': isInitialized,
    };
  }

  /// Creates a new instance of [LanguageState] from a JSON map.
  /// See concrete implementation in [LanguageCubit].
  ///
  static LanguageState fromJson(Map<String, dynamic> json) {
    return LanguageState(
      activeLanguage: Locale(
        json['languageCode'] as String,
        json['countryCode'] as String?,
      ),
      isInitialized: json['isInitialized'] as bool? ?? false,
    );
  }
}
