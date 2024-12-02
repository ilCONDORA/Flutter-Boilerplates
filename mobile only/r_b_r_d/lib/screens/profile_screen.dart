import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Profile Screen'),
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            context.goNamed('settings');
          },
        )
      ],
    );
  }
}
