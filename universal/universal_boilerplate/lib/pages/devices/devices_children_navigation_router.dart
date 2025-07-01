import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class DevicesChildrenNavigationRouter extends StatelessWidget {
  const DevicesChildrenNavigationRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoRouter();
  }
}