import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../navigation/routes_declaration.dart';

class NavigationButtons extends StatelessWidget {
  const NavigationButtons({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return GNav(
      tabBorderRadius: 16,
      padding: EdgeInsets.all(12),
      tabActiveBorder: Border.all(color: Colors.black),
      tabBorder: Border.all(color: Colors.grey),
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      tabs:
          routesDeclarationList.map((firstRouteDeclaration) {
            return GButton(
              icon:
                  firstRouteDeclaration.navigationItemModel?.icon ??
                  Icons.error,
              text: firstRouteDeclaration.navigationItemModel?.text ?? "Error",
            );
          }).toList(),
      selectedIndex: navigationShell.currentIndex,
      onTabChange:
          (index) => navigationShell.goBranch(index, initialLocation: true),
    );
  }
}
