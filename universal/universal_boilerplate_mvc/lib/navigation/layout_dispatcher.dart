import 'package:flutter/material.dart';

import '../widgets/my_app_bar.dart';

/// [LayoutDispatcher] is responsible for showing all the pages that need an app bar.
///
class LayoutDispatcher extends StatelessWidget {
  const LayoutDispatcher({super.key, required this.screenWidget});

  final Widget screenWidget;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyAppBar(),
              Expanded(child: screenWidget),
            ],
          ),
        ),
      ),
    );
  }
}
