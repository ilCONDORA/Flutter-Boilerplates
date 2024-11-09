import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'routes.dart';

class ScaffoldDynamicNavigationOrientation extends StatelessWidget {
  const ScaffoldDynamicNavigationOrientation({
    Key? key,
    required this.navigationShell,
  }) : super(
            key: key ?? const ValueKey('ScaffoldDynamicNavigationOrientation'));
  final StatefulNavigationShell navigationShell;

  void _goToBranch(int index) {
    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        bool isLandscape = orientation == Orientation.landscape;
        return Scaffold(
          body: isLandscape
              ? Row(
                  children: [
                    NavigationRail(
                      destinations: [
                        for (int i = 0;
                            i <
                                getDestinations(
                                        navigationType: NavigationType.rail)
                                    .length;
                            i++)
                          getDestinations(
                                  navigationType: NavigationType.rail)[i]
                              .navigationWidget(context),
                      ],
                      selectedIndex: navigationShell.currentIndex,
                      labelType: NavigationRailLabelType.all,
                      onDestinationSelected: _goToBranch,
                    ),
                    const VerticalDivider(
                      width: 1,
                    ),
                    Expanded(child: navigationShell),
                  ],
                )
              : navigationShell,
          bottomNavigationBar: isLandscape
              ? null
              : BottomNavigationBar(
                  items: [
                    for (int i = 0;
                        i <
                            getDestinations(
                                    navigationType: NavigationType.bottom)
                                .length;
                        i++)
                      getDestinations(navigationType: NavigationType.bottom)[i]
                          .navigationWidget(context),
                  ],
                  currentIndex: navigationShell.currentIndex,
                  onTap: _goToBranch,
                ),
        );
      },
    );
  }
}
