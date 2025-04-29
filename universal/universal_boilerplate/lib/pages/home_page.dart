import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Home Page'),
          for (var i = 0; i < 10; i++)
            Container(
              height: 300,
              width: 300,
              color: Colors.blue,
              child: Text('$i'),
            ),
         
        ],
      ),
    );
  }
}
