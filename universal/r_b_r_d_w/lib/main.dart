import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:condora_automatic_getter_storage_directory/condora_automatic_getter_storage_directory.dart';

import 'blocs/app_settings/app_settings_bloc.dart';
import 'config/custom_app_themes.dart';
import 'config/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await condoraAutomaticGetterStorageDirectory(
      webStorageDirectory: HydratedStorage.webStorageDirectory,
    ),
  );

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  // create the configuration for routing
  late final _router = createRouter();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppSettingsBloc(),
      child: BlocBuilder<AppSettingsBloc, AppSettingsState>(
        builder: (context, state) {
          return MaterialApp.router(
            routerConfig: _router,
            debugShowCheckedModeBanner: false,
            locale: state.appSettingsModel.localeLanguage,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            themeMode: state.appSettingsModel.themeMode,
            theme: CustomAppThemes.lightTheme,
            darkTheme: CustomAppThemes.darkTheme,
          );
        },
      ),
    );
  }
}
