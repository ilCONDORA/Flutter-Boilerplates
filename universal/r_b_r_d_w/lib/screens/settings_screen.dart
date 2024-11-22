import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:r_b_r_d_w/widgets/app_settings/app_settings_builder.dart';

import '../widgets/app_bar_without_scaffold.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AppBarWithoutScaffold(
          title: Text('Settings'),
          showBackButton: true,
        ),
        const Text('Settings Screen'),
        const AppSettingsBuilder(direction: Axis.vertical),
        ElevatedButton(
          onPressed: () {
            context.goNamed('home');
          },
          child: const Text('Go To Home'),
        ),
      ],
    );
  }
}
