import 'package:flutter/material.dart';

import '../navigation/my_bottom_nav_bar.dart';

/// [LayoutDispatcher] is responsible for showing all the pages that need an app bar.
///
class LayoutDispatcher extends StatelessWidget {
  const LayoutDispatcher({super.key, required this.screenWidget});

  final Widget screenWidget;

  @override
  Widget build(BuildContext context) {
    final Size windowSize = MediaQuery.sizeOf(context);

    final bool tooSmallForFullSideMenuAndTooBigForBottomNavBar =
        windowSize.width >= 850 && windowSize.width < 1300;
    final bool showBottomNavBar = windowSize.width < 850;

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: windowSize.width,
          height: windowSize.height,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Offstage(
                offstage: showBottomNavBar,
                child: Container(
                  width:
                      tooSmallForFullSideMenuAndTooBigForBottomNavBar
                          ? 50
                          : 200,
                  height: windowSize.height,
                  color: Colors.indigo,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Side Menu'),
                        Container(
                          height: 2000,
                          width: 30,
                          color: Colors.amberAccent,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(child: screenWidget),
            ],
          ),
        ),
        bottomNavigationBar: Offstage(
          offstage: !showBottomNavBar,
          child: MyBottomNavBar(),
        ),
      ),
    );
  }
}
