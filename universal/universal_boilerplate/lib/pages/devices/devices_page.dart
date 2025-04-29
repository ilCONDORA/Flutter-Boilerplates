import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../routes/router.gr.dart';

@RoutePage()
class DevicesPage extends StatelessWidget {
  const DevicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('Devices Page'),
            ElevatedButton(
              onPressed: () {
                // The difference between push and navigate is that we use push if we stay in the branch of the stack,
                // navigate is used if we want to go to another branch of the stack. This is done by
                //context.navigateTo(SingleDeviceRoute(deviceId: '1')); // TODO: test if it's the same as context.router.navigate
                context.router.navigate(SingleDeviceRoute(deviceId: '1'));
              },
              child: Text('Go to Cool Laptop'),
            ),
          ],
        ),
      ),
    );
  }
}
