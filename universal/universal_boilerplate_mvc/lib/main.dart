import 'package:dynamic_path_url_strategy/dynamic_path_url_strategy.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:nested/nested.dart';

import 'bloc/language/language_cubit.dart';
import 'bloc/theme/theme_cubit.dart';
import 'l10n/l10n.dart';
import 'navigation/router_configuration.dart';
import 'utils/app_colors.dart';
import 'utils/get_correct_directory.dart';
import 'utils/window_manager_utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory:
        kIsWeb
            ? HydratedStorageDirectory.web
            : HydratedStorageDirectory((await getCorrectDirectory()).path),
  );

  setPathUrlStrategy();

  final bool useWindowManager = await activateWindowManager();

  runApp(
    useWindowManager ? WindowManagerWrapper(mainApp: MainApp()) : MainApp(),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <SingleChildWidget>[
        BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()),
        // We use the double dot to call the autoInitialize method and also create the instance of LanguageCubit. The single dot only calls the method.
        BlocProvider<LanguageCubit>(
          create: (_) => LanguageCubit()..autoInitialize(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (BuildContext context, ThemeState themeState) {
          return BlocBuilder<LanguageCubit, LanguageState>(
            builder: (BuildContext context, LanguageState languageState) {
              return MaterialApp.router(
                title: 'Universal Boilerplate App',
                debugShowCheckedModeBanner: false,
                routerConfig: RouterConfiguration.config,
                themeMode: themeState.themeMode,
                theme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: AppColors.airForceBlue,
                    brightness: Brightness.light,
                  ),
                  pageTransitionsTheme: PageTransitionsTheme(
                    builders: Map<
                      TargetPlatform,
                      PageTransitionsBuilder
                    >.fromIterable(
                      TargetPlatform.values,
                      value: (_) => const FadeForwardsPageTransitionsBuilder(),
                    ),
                  ),
                ),
                darkTheme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: AppColors.airForceBlue,
                    brightness: Brightness.dark,
                  ),
                  pageTransitionsTheme: PageTransitionsTheme(
                    builders: Map<
                      TargetPlatform,
                      PageTransitionsBuilder
                    >.fromIterable(
                      TargetPlatform.values,
                      value: (_) => const FadeForwardsPageTransitionsBuilder(),
                    ),
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
