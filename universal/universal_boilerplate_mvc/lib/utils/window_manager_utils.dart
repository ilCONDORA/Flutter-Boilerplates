import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:universal_boilerplate_mvc/bloc/window_manager/window_manager_cubit.dart';
import 'package:window_manager/window_manager.dart';

import '../main.dart';

Future<bool> activateWindowManager() async {
  // We use the if statement to cut off the window management system.
  if (!kIsWeb && (Platform.isWindows || Platform.isMacOS || Platform.isLinux)) {
    await windowManager.ensureInitialized();

    final windowState = WindowManagerCubit().state;

    // This variable has a lot of options, we are going to use the size, center and minimumSize.
    WindowOptions windowOptions = WindowOptions(
      size:
          windowState
              .windowSize, // At first launch it will be null and id doesn't give any errors but after that it will use the size saved in the state.
      center:
          windowState.windowPosition ==
          null, // If the position is null, so after the first launch, it will center the window and after it will use the position saved in the state.
      minimumSize: Size(700, 600),
    );

    // After setting the size, constraint and other things we call this method to set other options.
    // Fun fact: here we have the 'windowManager.setSize' method but it doesn't work, that's why we set the size in the options.
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      if (windowState.windowPosition != null) {
        await windowManager.setPosition(windowState.windowPosition!);
      }
      if (windowState.isMaximized) {
        await windowManager.maximize();
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

class _WindowManagerWrapperState extends State<WindowManagerWrapper>
    with WindowListener {
  final WindowManagerCubit windowCubit = WindowManagerCubit();

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
  }

  @override
  void onWindowMaximize() {
    if (mounted) {
      windowCubit.changeWindowMaximizedState(true);
    }
  }

  @override
  void onWindowUnmaximize() {
    if (mounted) {
      windowCubit.changeWindowMaximizedState(false);
    }
  }

  @override
  void onWindowResize() async {
    if (mounted) {
      windowCubit.changeWindowSize(await windowManager.getSize());
    }
  }

  @override
  void onWindowMove() async {
    if (mounted) {
      windowCubit.changeWindowPosition(await windowManager.getPosition());
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
