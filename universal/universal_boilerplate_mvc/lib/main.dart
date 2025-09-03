import 'dart:io';

import 'package:dynamic_path_url_strategy/dynamic_path_url_strategy.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_boilerplate_mvc/bloc/cubit/window_manager_cubit.dart';
import 'package:window_manager/window_manager.dart';

import 'bloc/language/language_cubit.dart';
import 'bloc/pop_route/pop_route_cubit.dart';
import 'bloc/theme/theme_cubit.dart';
import 'l10n/l10n.dart';
import 'navigation/router_configuration.dart';

/// This method returns the correct path depending on the platform.
/// It's powered by the path_provider package, here's all the paths it can return:
/// - Android: getApplicationDocumentsDirectory()
/// - iOS: getLibraryDirectory()
/// - macOS: getLibraryDirectory()
/// - Windows: getApplicationSupportDirectory()
/// - Linux: getApplicationSupportDirectory()
/// If the app is running in debug mode on desktop platforms (Windows, Linux, macOS),
/// it will return a custom directory named 'DEBUG_STORAGE' in the current project directory.
///
Future<Directory> getCorrectDirectory() async {
  final platform = Platform.operatingSystem;

  if (kDebugMode && ['windows', 'linux', 'macos'].contains(platform)) {
    // Get the desktop project directory
    final projectDirectory = Directory.current;
    // Create a debug storage directory
    final desktopDebugStorageDirectory = Directory(
      '${projectDirectory.path}/DEBUG_STORAGE',
    );
    // Ensure the directory exists
    await desktopDebugStorageDirectory.create(recursive: true);
    return desktopDebugStorageDirectory;
  }

  switch (platform) {
    case 'android':
      return getApplicationDocumentsDirectory();
    case 'ios':
    case 'macos':
      return getLibraryDirectory();
    case 'windows':
    case 'linux':
      return getApplicationSupportDirectory();
    default:
      return getTemporaryDirectory();
  }
}

Future<void> main() async {
  // TODO: Add country flag from the other boilerplates
  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory:
        kIsWeb
            ? HydratedStorageDirectory.web
            : HydratedStorageDirectory((await getCorrectDirectory()).path),
  );

  setPathUrlStrategy();

  //TODO: This is relatively old, gonna search for a better way.
  // We use the if statement to cut off the window management system.
  if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
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
  }

  runApp(WindowManagerWrapper());
}

class WindowManagerWrapper extends StatefulWidget {
  const WindowManagerWrapper({super.key});

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
  void onWindowResized() async {
    if (mounted) {
      windowCubit.changeWindowSize(await windowManager.getSize());
    }
  }

  @override
  void onWindowMoved() async {
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
    return const MainApp();
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()),
        // We use the double dot to call the autoInitialize method and also create the instance of LanguageCubit. The single dot only calls the method.
        BlocProvider(create: (_) => LanguageCubit()..autoInitialize()),
        // Use only if we want to use the AutomaticPopRouteButton widget.
        BlocProvider<PopRouteCubit>(create: (_) => PopRouteCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return BlocBuilder<LanguageCubit, LanguageState>(
            builder: (context, languageState) {
              return MaterialApp.router(
                title: 'Universal Boilerplate App',
                debugShowCheckedModeBanner: false,
                routerConfig: RouterConfiguration.config,
                themeMode: themeState.themeMode,
                theme: ThemeData.from(
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: Colors.blue,
                    brightness: Brightness.light,
                  ),
                ),
                darkTheme: ThemeData.from(
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: Colors.blue,
                    brightness: Brightness.dark,
                  ),
                ),
                locale: languageState.activeLanguage,
                supportedLocales: L10n.supportedLanguages,
                localizationsDelegates: L10n.localizationsDelegates,
              );
            },
          );
        },
      ),
    );
  }
}
