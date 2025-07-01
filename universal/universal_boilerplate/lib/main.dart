import 'dart:io';

import 'package:condora_automatic_getter_storage_directory/condora_automatic_getter_storage_directory.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:universal_boilerplate/routes/router.dart';
import 'package:universal_boilerplate/navigation_genie2.dart';
import 'package:window_manager/window_manager.dart';
import 'package:dynamic_path_url_strategy/dynamic_path_url_strategy.dart';

import 'blocs/app_settings/app_settings_bloc.dart';
import 'layout_master.dart';

/// Method that is executed when the app is started.
///
/// Here we use hydrated_bloc to persist the state of the app and
/// condora_automatic_getter_storage_directory to automatically get
/// the correct storage directory based on the platform.
///
/// For desktop platforms we use window_manager to manage the window of the app.
///
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory(
            (await condoraAutomaticGetterStorageDirectory()).path,
          ),
  );

  // This if statement that checks if the platform 'is not web' is added to avoid errors on the web platform.
  // The Platform class is not available on the web.
  // This code was possible to create thanks to Claude 3.5 Sonnet, ChatGPT-4o and a ChatGPT-4o tailored to Flutter.
  // There's literally no documentation, just an example code, of this package and I must say, we use it in a better way.
  if (!kIsWeb) {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      await windowManager.ensureInitialized();

      final appSettingsBloc = AppSettingsBloc();
      final appSettingsModel = appSettingsBloc.state.appSettingsModel;

      // This is the starting configuration of the window.
      WindowOptions windowOptions = WindowOptions(
        size: appSettingsModel.windowSize,
        minimumSize: Size(600, 500),
      );

      windowManager.waitUntilReadyToShow(windowOptions, () async {
        await windowManager.setPosition(appSettingsModel.windowPosition);
        if (appSettingsModel.isMaximized) {
          await windowManager.maximize();
        }
        await windowManager.show();
        await windowManager.focus();
      });
    }
  }

  // By calling this method we don't see the #/ in the URL.
  setPathUrlStrategy();

  runApp(const MainApp());
}

/// Instead of using the default Flutter [MaterialApp] we use it's brother, [MaterialApp.router].
/// This allows us to use our coustom configuration provided by the [getRouterConfiguration] method,
/// we must do this because we use go_router.
///
/// In the app we can change it's language and theme. These are stored in the [AppSettingsModel]
/// and it's managed by [AppSettingsBloc].
/// That's why we use [BlocProvider] to provide the [AppSettingsBloc] to the whole app and
/// [BlocBuilder] to rebuild the app when the state changes.
///
/// [MainApp] was originally a [StatelessWidget] but we changed it to a [StatefulWidget] to implement [WindowListener].
/// [WindowListener] is an interface that allows us to listen to window events like resize, move, maximize and unmaximize
/// so that we can save the various states to the app settings.
///
/// We also use google_fonts package to use a different font from the default one because it's too ugly.
///
/// As for the theme of the app, the most important option is colorSchemeSeed,
/// this is the color that will be used as a seed to generate the other colors and the base one is a kind of purple.
///
class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with WindowListener {
  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
  }

// #region WindowListener code

  @override
  void onWindowMaximize() {
    if (mounted) {
      final appSettingsBloc = AppSettingsBloc();
      final appSettingsModel = appSettingsBloc.state.appSettingsModel;

      final updatedSettings = appSettingsModel.copyWith(
        isMaximized: true,
      );

      appSettingsBloc.add(ChangeAppSettings(appSettingsModel: updatedSettings));
    }
  }

  @override
  void onWindowUnmaximize() {
    if (mounted) {
      final appSettingsBloc = AppSettingsBloc();
      final appSettingsModel = appSettingsBloc.state.appSettingsModel;

      final updatedSettings = appSettingsModel.copyWith(
        isMaximized: false,
      );

      appSettingsBloc.add(ChangeAppSettings(appSettingsModel: updatedSettings));
    }
  }

  @override
  void onWindowResized() {
    saveWindowSizeAndPosition();
  }

  @override
  void onWindowMoved() {
    saveWindowSizeAndPosition();
  }

  /// Saves the current window size and position to the app settings.
  ///
  /// This method retrieves the current window size and position,
  /// updates the app settings, and dispatches an event to save the changes.
  ///
  Future<void> saveWindowSizeAndPosition() async {
    Size size = await windowManager.getSize();
    Offset position = await windowManager.getPosition();

    if (mounted) {
      final appSettingsBloc = AppSettingsBloc();
      final appSettingsModel = appSettingsBloc.state.appSettingsModel;

      final updatedSettings = appSettingsModel.copyWith(
        windowSize: size,
        windowPosition: position,
      );

      appSettingsBloc.add(ChangeAppSettings(appSettingsModel: updatedSettings));
    }
  }

// #endregion

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  //final _newAppRouter = NewAppRouter();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppSettingsBloc(),
      child: BlocBuilder<AppSettingsBloc, AppSettingsState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'UniBoil',
            routerConfig: branchesGenerator(), //_newAppRouter.config(),
            debugShowCheckedModeBanner: false,
            locale: state.appSettingsModel.localeLanguage,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            themeMode: state.appSettingsModel.themeMode,
            theme: ThemeData(
              colorSchemeSeed: Color(0xFF344A9F),
              scaffoldBackgroundColor: Color(0xFF344A9F),
              fontFamily: GoogleFonts.notoSans().fontFamily,
            ),
            darkTheme: ThemeData(
              colorSchemeSeed: Color(0xFF344A9F),
              scaffoldBackgroundColor: Color(0xFF1E1F2A),
              fontFamily: GoogleFonts.notoSans().fontFamily,
            ),
          );
        },
      ),
    );
  }
}
