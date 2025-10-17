import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'window_manager_state.dart';

/// [WindowManagerCubit] manages the application's window state and it also saves it thanks to the [HydratedBloc] implementation.
///
/// It allows the change of the windows size, window position and window maximized state through it's methods:
/// [changeWindowSize], [changeWindowPosition], [changeWindowMaximizedState].
///
/// The current settings are stored in the state, which is persisted using the [HydratedCubit] functionality.
///
class WindowManagerCubit extends HydratedCubit<WindowManagerState> {
  /// Constructor for [WindowManagerCubit]. It initializes the state by using the constructor of [WindowState].
  ///
  WindowManagerCubit() : super(WindowManagerInitial());

  // Debounce timers to avoid emitting state too frequently (e.g., during drag and resize).
  Timer? _sizeDebounce;
  Timer? _positionDebounce;
  final Duration _debounceDuration = const Duration(milliseconds: 250);

  /// Method called to change the state of the window size.
  ///
  void changeWindowSize(Size newSize) {
    if (state.windowSize == newSize) return;
    _sizeDebounce?.cancel();
    _sizeDebounce = Timer(_debounceDuration, () {
      if (state.windowSize != newSize) {
        emit(state.copyWith(windowSize: newSize));
      }
    });
  }

  /// Method called to change the state of the window position.
  ///
  void changeWindowPosition(Offset newPosition) {
    if (state.windowPosition == newPosition) return;
    _positionDebounce?.cancel();
    _positionDebounce = Timer(_debounceDuration, () {
      if (state.windowPosition != newPosition) {
        emit(state.copyWith(windowPosition: newPosition));
      }
    });
  }

  /// Method called to change the state of the window maximized state.
  ///
  void changeWindowMaximizedState() {
    emit(state.copyWith(isMaximized: !state.isMaximized));
  }

  @override
  Future<void> close() {
    _sizeDebounce?.cancel();
    _positionDebounce?.cancel();
    return super.close();
  }

  @override
  WindowManagerState? fromJson(Map<String, dynamic> json) {
    return WindowManagerState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(WindowManagerState state) {
    return state.toJson();
  }
}
