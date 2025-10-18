part of 'theme_cubit.dart';

/// [ThemeState] manages the state of the application's theme settings.
///
/// Here we define the variables and methods that will be used to manage the state.
///
@immutable
class ThemeState {
  final ThemeMode themeMode;

  /// Constructor for [ThemeState].
  /// The default theme mode is set to [ThemeMode.system].
  ///
  const ThemeState({this.themeMode = ThemeMode.system});

  /// This method creates a copy of the current state with an optional new value for [themeMode].
  ///
  /// It will be used by the [changeTheme] method in the [ThemeCubit] class to change the theme mode.
  ///
  ThemeState copyWith({ThemeMode? themeMode}) {
    return ThemeState(themeMode: themeMode ?? this.themeMode);
  }

  /// Converts the current state to a JSON map.
  /// See concrete implementation in [ThemeCubit].
  ///
  Map<String, dynamic> toJson() {
    return <String, dynamic>{'themeMode': themeMode.index};
  }

  /// Creates a new instance of [ThemeState] from a JSON map.
  /// See concrete implementation in [ThemeCubit].
  ///
  static ThemeState fromJson(Map<String, dynamic> json) {
    return ThemeState(themeMode: ThemeMode.values[json['themeMode'] as int]);
  }
}

/// This class is used by [ThemeCubit] as a constructor for the initial state.
/// [ThemeInitial] extends [ThemeState] so the real constructor is the one in [ThemeState].
///
final class ThemeInitial extends ThemeState {}
