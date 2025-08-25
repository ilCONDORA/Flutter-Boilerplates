import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/language/language_cubit.dart';
import '../../bloc/theme/theme_cubit.dart';
import '../../l10n/app_localizations.dart';
import '../../scrollable_page_widget.dart';

class HomePage extends ScrollablePageWidget {
  const HomePage({super.key});

  @override
  Widget buildPageContent(BuildContext context) {
    return Column(
      spacing: 12,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: [
            // Test buttons to change the theme.
            ElevatedButton(
              onPressed:
                  () =>
                      context.read<ThemeCubit>().changeTheme(ThemeMode.system),
              child: Text('Toggle Theme System'),
            ),
            ElevatedButton(
              onPressed:
                  () => context.read<ThemeCubit>().changeTheme(ThemeMode.dark),
              child: Text('Toggle Theme Dark'),
            ),
            ElevatedButton(
              onPressed:
                  () => context.read<ThemeCubit>().changeTheme(ThemeMode.light),
              child: Text('Toggle Theme Light'),
            ),
          ],
        ),
        // Display example text from localization
        // This text will change based on the selected language
        Text(AppLocalizations.of(context)!.example_text),
        // Test buttons to change the language
        ElevatedButton(
          onPressed: () {
            // Change the app's locale to English (GB)
            context.read<LanguageCubit>().changeLanguage(
              const Locale('en', 'GB'),
            );
          },
          child: Text("Switch language to English (GB)"),
        ),
        ElevatedButton(
          onPressed: () {
            // Change the app's locale to English (US)
            context.read<LanguageCubit>().changeLanguage(
              const Locale('en', 'US'),
            );
          },
          child: Text("Switch language to English (US)"),
        ),
        ElevatedButton(
          onPressed: () {
            // Change the app's locale to Italian (IT)
            context.read<LanguageCubit>().changeLanguage(
              const Locale('it', 'IT'),
            );
          },
          child: Text("Switch language to Italian"),
        ),
      ],
    );
  }
}
