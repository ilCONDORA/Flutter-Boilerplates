import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'theme_state.dart';

/// [ThemeCubit] manages the application's theme settings and it also saves it thanks to the [HydratedBloc] implementation.
///
/// It allows the change of the theme mode (light, dark, or system default) through the [changeTheme] method.
/// The current theme mode is stored in the state, which is persisted using the [HydratedCubit] functionality.
///
class ThemeCubit extends HydratedCubit<ThemeState> {
  /// Constructor for [ThemeCubit]. It initializes the state with a default theme mode, which is set to [ThemeMode.system].
  ///
  ThemeCubit() : super(ThemeInitial());

  /// Method called to change the theme mode of the application by passing a [ThemeMode] parameter and
  /// updating the state with the new theme mode.
  ///
  void changeTheme(ThemeMode themeMode) {
    emit(state.copyWith(themeMode: themeMode));
  }

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    return ThemeState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(ThemeState state) {
    return state.toJson();
  }
}
