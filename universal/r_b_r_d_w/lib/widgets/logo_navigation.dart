import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LogoNavigation extends StatelessWidget {
  const LogoNavigation({
    super.key,
    required this.namedRoute,
    required this.height,
  });

  final String namedRoute;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).goNamed(namedRoute);
      },
      child: Image.asset(
        'assets/logo-placeholder.png',
        height: height,
      ),
    );
  }
}
