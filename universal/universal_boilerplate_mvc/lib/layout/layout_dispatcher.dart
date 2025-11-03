import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../navigation/route_declaration_model.dart';
import '../navigation/routes_declaration.dart';

/// [LayoutDispatcher] is responsible for showing all the pages that need an app bar.
///
class LayoutDispatcher extends StatelessWidget {
  const LayoutDispatcher({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final Size windowSize = MediaQuery.sizeOf(context);

    final bool tooSmallForFullSideMenuAndTooBigForBottomNavBar = windowSize.width >= 850 && windowSize.width < 1300;
    final bool showBottomNavBar = windowSize.width < 850;

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: windowSize.width,
          height: windowSize.height,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Offstage(
                offstage: showBottomNavBar,
                child: Container(
                  width: tooSmallForFullSideMenuAndTooBigForBottomNavBar ? 50 : 200,
                  height: windowSize.height,
                  color: Colors.indigo,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
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
              Expanded(child: navigationShell),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Offstage(
        offstage: !showBottomNavBar,
        child: NavigationBar(
          maintainBottomViewPadding: true,
          selectedIndex: navigationShell.currentIndex,
          // If the user taps the currently active tab, navigate to the branch's
          // initial location (this effectively pops any subroutes and returns
          // to the base route). If they tap a different tab, switch branches
          // without changing that branch's current inner stack.
          onDestinationSelected:
              (int selectedIndex) => navigationShell.goBranch(
                selectedIndex,
                initialLocation: selectedIndex == navigationShell.currentIndex ? true : false,
              ),
          destinations:
              bottomNavigationRoutes
                  .map(
                    (RouteDeclarationModel singleRouteDeclaration) => NavigationDestination(
                      icon: Icon(singleRouteDeclaration.icon ?? Icons.error),
                      selectedIcon: Icon(singleRouteDeclaration.selectedIcon ?? Icons.error),
                      label: singleRouteDeclaration.definedRoute.getLocalizedName(context),
                    ),
                  )
                  .toList(),
        ),
      ),
    );
  }
}
