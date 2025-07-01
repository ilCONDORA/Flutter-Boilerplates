import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CpuTypeChildrenNavigationRouter extends StatelessWidget {
  const CpuTypeChildrenNavigationRouter({super.key, @PathParam() required this.cpuType});
  final String cpuType;

  @override
  Widget build(BuildContext context) {
    return AutoRouter();
  }
}
