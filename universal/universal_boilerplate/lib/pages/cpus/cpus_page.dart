import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:universal_boilerplate/routes/router.gr.dart';

@RoutePage()
class CpusPage extends StatelessWidget {
  const CpusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('CPUs Page'),
            ElevatedButton(
              onPressed: () {
                context.router.navigate(CpuTypeChildrenNavigationRouter(cpuType: 'desktop'));
              },
              child: Text('Go to DESKTOP CPUs'),
            ),
            ElevatedButton(
              onPressed: () {
                context.router.navigate(CpuTypeChildrenNavigationRouter(cpuType: 'laptop'));
              },
              child: Text('Go to LAPTOP CPUs'),
            ),
            ElevatedButton(
              onPressed: () {
                context.router.navigate(CpuTypeChildrenNavigationRouter(cpuType: 'mobile'));
              },
              child: Text('Go to MOBILE CPUs'),
            ),
          ],
        ),
      ),
    );
  }
}
