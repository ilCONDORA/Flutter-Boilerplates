import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:window_manager/window_manager.dart';

import '../bloc/window_manager/window_manager_cubit.dart';
import '../main.dart';

// Lazily instantiate the cubit to avoid creating a HydratedCubit before
// HydratedBloc.storage is configured in `main()` (imports run at app
// initialization time). This prevents initialization-order issues.
WindowManagerCubit? _windowManagerCubit;
WindowManagerCubit get windowManagerCubit {
  _windowManagerCubit ??= WindowManagerCubit();
  return _windowManagerCubit!;
}

/// Close and clear the lazily-created cubit (useful for tests or app teardown).
Future<void> disposeWindowManagerCubit() async {
  await _windowManagerCubit?.close();
  _windowManagerCubit = null;
}

Future<bool> activateWindowManager() async {
  // We use the if statement to cut off the window management system.
  if (!kIsWeb && (Platform.isWindows || Platform.isMacOS || Platform.isLinux)) {
    await windowManager.ensureInitialized();

    final WindowManagerState windowState = windowManagerCubit.state;

    await windowManager.waitUntilReadyToShow(WindowOptions(), () async {
      windowManager.setMinimumSize(const Size(700, 600));

      if (windowState.windowSize != null) {
        await windowManager.setSize(windowState.windowSize!);
      }
      if (windowState.windowPosition != null) {
        await windowManager.setPosition(windowState.windowPosition!);
      } else {
        await windowManager.center();
      }
      if (windowState.isMaximized) {
        await windowManager.maximize();
      }
      if (windowState.isFullScreen) {
        await windowManager.setFullScreen(true);
      }

      await windowManager.show();
      await windowManager.focus();
    });
    return true;
  } else {
    return false;
  }
}

class WindowManagerWrapper extends StatefulWidget {
  const WindowManagerWrapper({super.key, required this.mainApp});

  final MainApp mainApp;

  @override
  State<WindowManagerWrapper> createState() => _WindowManagerWrapperState();
}

class _WindowManagerWrapperState extends State<WindowManagerWrapper> with WindowListener {
  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
  }

  @override
  void onWindowMaximize() {
    if (mounted) {
      windowManagerCubit.changeWindowMaximizedState();
    }
  }

  @override
  void onWindowUnmaximize() {
    if (mounted) {
      windowManagerCubit.changeWindowMaximizedState();
    }
  }

  @override
  void onWindowResize() async {
    if (mounted) {
      final Size newSize = await windowManager.getSize();
      final Offset newPosition = await windowManager.getPosition();
      windowManagerCubit.changeWindowSize(newSize);
      windowManagerCubit.changeWindowPosition(newPosition);
    }
  }

  @override
  void onWindowMove() async {
    if (mounted) {
      final Offset newPosition = await windowManager.getPosition();
      windowManagerCubit.changeWindowPosition(newPosition);
    }
  }

  @override
  void onWindowBlur() async {
    if (mounted) {
      final Size newSize = await windowManager.getSize();
      final Offset newPosition = await windowManager.getPosition();
      windowManagerCubit.changeWindowSize(newSize);
      windowManagerCubit.changeWindowPosition(newPosition);
    }
  }

  @override
  void onWindowEnterFullScreen() {
    if (mounted) {
      windowManagerCubit.changeWindowFullScreenState();
    }
  }

  @override
  void onWindowLeaveFullScreen() {
    if (mounted) {
      windowManagerCubit.changeWindowFullScreenState();
    }
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.mainApp;
  }
}
