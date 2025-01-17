import 'package:condora_automatic_getter_storage_directory/condora_automatic_getter_storage_directory.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'blocs/app_settings/app_settings_bloc.dart';
import 'layout_master.dart';

/// Method that is executed when the app is started.
///
/// Here we use hydrated_bloc to persist the state of the app and
/// condora_automatic_getter_storage_directory to automatically get
/// the correct storage directory based on the platform.
///
//TODO: add support for the window management for desktop platforms, go see old desktop only code
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory(
            (await condoraAutomaticGetterStorageDirectory()).path,
          ),
  );

  runApp(MainApp());
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
/// We also use google_fonts package to use a different font from the default one because it's too ugly.
///
/// As for the theme of the app, the most important option is colorSchemeSeed,
/// this is the color that will be used as a seed to generate the other colors and the base one is a kind of purple.
///
class MainApp extends StatelessWidget {
  MainApp({super.key});

  // get the configuration for the routing of the app.
  late final RouterConfig<Object> _routerConfiguration =
      getRouterConfiguration();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppSettingsBloc(),
      child: BlocBuilder<AppSettingsBloc, AppSettingsState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'UniBoil',
            routerConfig: _routerConfiguration,
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
