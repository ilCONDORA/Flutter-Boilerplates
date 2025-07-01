import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/theme/theme_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            spacing: 8,
            mainAxisAlignment: MainAxisAlignment.center,
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
      
          for (int i = 0; i < 20; i++)
            ListTile(
              title: Text('Home Item $i'),
              subtitle: Text('Subtitle $i'),
              leading: Icon(Icons.archive),
              trailing: Icon(Icons.arrow_forward),
            ),
        ],
      ),
    );
  }
}
