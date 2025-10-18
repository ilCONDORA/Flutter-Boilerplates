import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

import '../utils/app_colors.dart';
import 'routes_declaration.dart';

/// This class creates a custom bottom navigation bar using the [StylishBottomBar] package.
///
/// It defines the routes that will appear in the bottom navigation bar,
/// along with their corresponding icons for selected and unselected states.
///
/// The class also includes helper methods to convert between route names and indices,
/// facilitating navigation when a user taps on a bottom bar item.
///
class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final bottomBarRoutes = bottomNavigationRoutes;

    return StylishBottomBar(
      backgroundColor: AppColors.lightOrange.lighten(0.04),
      option: AnimatedBarOptions(iconStyle: IconStyle.animated),
      fabLocation: StylishBarFabLocation.center,
      currentIndex: navigationShell.currentIndex,
      // If the user taps the currently active tab, navigate to the branch's
      // initial location (this effectively pops any subroutes and returns
      // to the base route). If they tap a different tab, switch branches
      // without changing that branch's current inner stack.
      onTap:
          (selectedIndex) => navigationShell.goBranch(
            selectedIndex,
            initialLocation:
                selectedIndex == navigationShell.currentIndex ? true : false,
          ),
      items:
          bottomBarRoutes.map((routeDeclaration) {
            return BottomBarItem(
              icon: Icon(routeDeclaration.icon ?? Icons.error),
              unSelectedColor: Colors.grey.shade700,
              selectedIcon: Icon(
                routeDeclaration.selectedIcon ??
                    routeDeclaration.icon ??
                    Icons.error,
              ),
              selectedColor: AppColors.airForceBlue.darker,
              title: Text(
                DefinedRoutes.values
                    .firstWhere(
                      (element) => element.name == routeDeclaration.name,
                    )
                    .getLocalizedName(context),
              ),
            );
          }).toList(),
    );
  }
}
