import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../routes/router.gr.dart';

@RoutePage()
class SingleDevicePage extends StatelessWidget {
  const SingleDevicePage({super.key, @PathParam() required this.deviceId});
  final String deviceId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('Single Device Page'),
            Text('Device Name: $deviceId'),
            ElevatedButton(
              onPressed: () {
                context.router.navigate(
                  CpusChildrenNavigationRouter(
                    children: [
                      CpuTypeChildrenNavigationRouter(
                        cpuType: 'laptop',
                        children: [
                          SingleCpuRoute(cpuName: 'amd-ryzen-9-7945hx'),
                        ],
                      ),
                    ],
                  ),
                );
              },
              child: Text('Go to the CPU'),
            ),
          ],
        ),
      ),
    );
  }
}
