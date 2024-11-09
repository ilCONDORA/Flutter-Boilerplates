import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/app settings/menu_language_selector.dart';
import '../widgets/app settings/theme_segmented_button.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ThemeSegmentedButton(),
            const MenuLanguageSelector(),
            ElevatedButton(
              onPressed: () {
                context.goNamed('home');
              },
              child: const Text('Go To Home'),
            ),
          ],
        ),
      ),
    );
  }
}
