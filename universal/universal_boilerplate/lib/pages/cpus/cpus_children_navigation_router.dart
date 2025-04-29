import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CpusChildrenNavigationRouter extends StatelessWidget {
  const CpusChildrenNavigationRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoRouter();
  }
}
