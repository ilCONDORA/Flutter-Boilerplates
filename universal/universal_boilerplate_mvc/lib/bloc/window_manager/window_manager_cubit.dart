import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:screen_retriever/screen_retriever.dart';

part 'window_manager_state.dart';

class WindowManagerCubit extends HydratedCubit<WindowManagerState> {
  ///
  /// It allows the change of the windows size, window position, window maximized state, and window full screen state through it's methods:
  /// [changeWindowSize], [changeWindowPosition], [changeWindowMaximizedState], [changeWindowFullScreenState].
  ///
  /// It has an init method [setPositionScaleFactor] that sets the position scale factor based on the primary display's scale factor.
  ///
  /// The current settings are stored in the state, which is persisted using the [HydratedCubit] functionality.
  ///
  WindowManagerCubit() : super(WindowManagerInitial()) {
    setPositionScaleFactor();
  }

  // Debounce timers to avoid emitting state too frequently (e.g., during drag and resize).
  Timer? _sizeDebounce;
  Timer? _positionDebounce;
  final Duration _debounceDuration = const Duration(milliseconds: 250);

  /// Method called to set the position scale factor based on the primary display's scale factor.
  /// It's extremely important to call this method at the start of the app/cubit because the position differs between screens
  /// and the scale factor used globally is the one from the primary screen.
  /// 
  void setPositionScaleFactor() async {
    if (state.positionScaleFactor == null) {
      final Display primaryDisplay = await screenRetriever.getPrimaryDisplay();
      final WindowManagerState newState = state.copyWith(
        positionScaleFactor: primaryDisplay.scaleFactor?.toDouble() ?? 1.0,
      );
      emit(newState);
    } else {
      final Display primaryDisplay = await screenRetriever.getPrimaryDisplay();
      final double scaleFactor = primaryDisplay.scaleFactor?.toDouble() ?? 1.0;
      if (state.positionScaleFactor != scaleFactor) {
        final WindowManagerState newState = state.copyWith(positionScaleFactor: scaleFactor);
        emit(newState);
      }
    }
  }

  /// Method called to change the state of the window size.
  ///
  void changeWindowSize(Size newSize) {
    if (state.windowSize == newSize) return;
    _sizeDebounce?.cancel();
    _sizeDebounce = Timer(_debounceDuration, () {
      if (state.windowSize != newSize) {
        final WindowManagerState newState = state.copyWith(windowSize: newSize);
        emit(newState);
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
        final WindowManagerState newState = state.copyWith(windowPosition: newPosition / state.positionScaleFactor!);
        emit(newState);
      }
    });
  }

  /// Method called to change the state of the window maximized state.
  ///
  void changeWindowMaximizedState() {
    emit(state.copyWith(isMaximized: !state.isMaximized));
  }

  /// Method called to change the state of the window full screen state.
  ///
  void changeWindowFullScreenState() {
    emit(state.copyWith(isFullScreen: !state.isFullScreen));
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
