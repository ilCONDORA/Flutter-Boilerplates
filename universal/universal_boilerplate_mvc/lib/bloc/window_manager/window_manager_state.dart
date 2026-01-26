part of 'window_manager_cubit.dart';

/// [WindowManagerState] manages the state of the application's window state.
///
/// Here we define all the variables and methods used to manage the state.
///
@immutable
class WindowManagerState {
  final double? positionScaleFactor;
  final Size? windowSize;
  final Offset? windowPosition;
  final bool isMaximized;
  final bool isFullScreen;

  /// Constructor for [WindowManagerState].
  /// The only variables instantiated are [isMaximized] and [isFullScreen], both set to false,
  /// the other two can be null an will stay null until the first app launch.
  ///
  const WindowManagerState({
    this.positionScaleFactor,
    this.windowSize,
    this.windowPosition,
    this.isMaximized = false,
    this.isFullScreen = false,
  });

  /// This method will be used by the other methods inside [WindowManagerCubit],
  /// it's a simple way to set only one value or more without problems for the other ones.
  ///
  WindowManagerState copyWith({
    double? positionScaleFactor,
    Size? windowSize,
    Offset? windowPosition,
    bool? isMaximized,
    bool? isFullScreen,
  }) {
    return WindowManagerState(
      positionScaleFactor: positionScaleFactor ?? this.positionScaleFactor,
      windowSize: windowSize ?? this.windowSize,
      windowPosition: windowPosition ?? this.windowPosition,
      isMaximized: isMaximized ?? this.isMaximized,
      isFullScreen: isFullScreen ?? this.isFullScreen,
    );
  }

  /// Converts the current state to a JSON map.
  /// See concrete implementation in [WindowManagerCubit].
  ///
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'positionScaleFactor': positionScaleFactor,
      'windowSize':
          windowSize == null
              ? null
              : <String, double>{
                'width': windowSize!.width,
                'height': windowSize!.height,
              },
      'windowPosition':
          windowPosition == null
              ? null
              : <String, double>{
                'x': windowPosition!.dx,
                'y': windowPosition!.dy,
              },
      'isMaximized': isMaximized,
      'isFullScreen': isFullScreen,
    };
  }

  /// Creates a new instance of [WindowManagerState] from a JSON map.
  /// See concrete implementation in [WindowManagerCubit].
  ///
  static WindowManagerState fromJson(Map<String, dynamic> json) {
    return WindowManagerState(
      positionScaleFactor: json['positionScaleFactor'] as double?,
      windowSize: Size(
        json['windowSize']['width'] as double,
        json['windowSize']['height'] as double,
      ),
      windowPosition: Offset(
        json['windowPosition']['x'] as double,
        json['windowPosition']['y'] as double,
      ),
      isMaximized: json['isMaximized'] as bool,
      isFullScreen: json['isFullScreen'] as bool,
    );
  }
}

/// This class is used by [WindowManagerCubit] as a constructor for the initial state.
/// [WindowManagerInitial] extends [WindowManagerState] so the real constructor is the one in [WindowManagerState].
///
final class WindowManagerInitial extends WindowManagerState {}
