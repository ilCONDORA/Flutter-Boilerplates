import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../routes/router.gr.dart';

@RoutePage()
class SingleCpuPage extends StatelessWidget {
  const SingleCpuPage({super.key, @PathParam() required this.cpuName});
  final String cpuName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('Single CPU Page'),
            Text('CPU Name: $cpuName'),
            ElevatedButton(
              onPressed: () {
                context.router.navigate(
                  DevicesChildrenNavigationRouter(
                    children: [
                      SingleDeviceRoute(deviceId: '1'),
                    ],
                  ),
                );
              },
              child: Text('Go to Device 1'),
            ),
          ],
        ),
      ),
    );
  }
}
