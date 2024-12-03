import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Is used to create a button that goes back to the previous screen.
/// 
/// It uses [GoRouter.of(context).pop()] to go back to the previous screen.
class GoBackButton extends StatelessWidget {
  const GoBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => GoRouter.of(context).pop(),
      icon: const Icon(Icons.arrow_back),
    );
  }
}
