part of 'window_manager_cubit.dart';

/// [WindowManagerState] manages the state of the application's window state.
///
/// Here we define all the variables and methods used to manage the state.
///
@immutable
class WindowManagerState {
  final Size? windowSize;
  final Offset? windowPosition;
  final bool isMaximized;

  /// Constructor for [WindowManagerState].
  /// The only variable instantiated is [isMaximized] and is set to false,
  /// the other two can be null an will stay null until the first app launch.
  ///
  const WindowManagerState({
    this.windowSize,
    this.windowPosition,
    this.isMaximized = false,
  });

  /// This method will be used by the other methods inside [WindowManagerCubit],
  /// it's a simple way to set only one value or more without problems for the other ones.
  ///
  WindowManagerState copyWith({
    Size? windowSize,
    Offset? windowPosition,
    bool? isMaximized,
  }) {
    return WindowManagerState(
      windowSize: windowSize ?? this.windowSize,
      windowPosition: windowPosition ?? this.windowPosition,
      isMaximized: isMaximized ?? this.isMaximized,
    );
  }

  /// Converts the current state to a JSON map.
  /// See concrete implementation in [WindowManagerCubit].
  ///
  Map<String, dynamic> toJson() {
    return {
      'windowSize':
          windowSize == null
              ? null
              : {'width': windowSize!.width, 'height': windowSize!.height},
      'windowPosition':
          windowPosition == null
              ? null
              : {'x': windowPosition!.dx, 'y': windowPosition!.dy},
      'isMaximized': isMaximized,
    };
  }

  /// Creates a new instance of [WindowManagerState] from a JSON map.
  /// See concrete implementation in [WindowManagerCubit].
  ///
  static WindowManagerState fromJson(Map<String, dynamic> json) {
    return WindowManagerState(
      windowSize: Size(
        json['windowSize']['width'] as double,
        json['windowSize']['height'] as double,
      ),
      windowPosition: Offset(
        json['windowPosition']['x'] as double,
        json['windowPosition']['y'] as double,
      ),
      isMaximized: json['isMaximized'] as bool,
    );
  }
}

/// This class is used by [WindowManagerCubit] as a constructor for the initial state.
/// [WindowManagerInitial] extends [WindowManagerState] so the real constructor is the one in [WindowManagerState].
///
final class WindowManagerInitial extends WindowManagerState {}
