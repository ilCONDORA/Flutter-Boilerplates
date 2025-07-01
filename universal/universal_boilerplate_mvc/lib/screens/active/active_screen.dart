import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:universal_boilerplate_mvc/bloc/language/language_cubit.dart';

import '../../l10n/app_localizations.dart';

class ActiveScreen extends StatelessWidget {
  const ActiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 10,
          children: [
            Text('Active'),
            // Test button to navigate to a specific item
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).go('/active/1');
              },
              child: Text('Go to Active Item 1'),
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
        ),
      ),
    );
  }
}
