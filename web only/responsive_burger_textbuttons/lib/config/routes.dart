import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../screens/home_screen.dart';
import '../screens/products_screen.dart';
import 'navigation/custom_navigation_destination.dart';
import 'navigation/scaffold_with_header_navbar_and_drawer.dart';

/// [getDestinations] returns the list of destinations for the app.
///
/// It returns a list of [CustomNavigationDestination] objects, where each object represents a destination in the app.
List<CustomNavigationDestination> getDestinations() => [
      const CustomNavigationDestination(
        path: '/',
        name: 'home',
        screen: HomeScreen(),
        showAsTab: false,
      ),
      CustomNavigationDestination(
        path: '/products',
        name: 'products',
        labelBuilder: (context) => AppLocalizations.of(context)!.tab_products,
        screen: const ProductsScreen(),
        showAsTab: true,
      ),
      // Add more destinations here.
      // ...
    ];

/// [createRouter] creates the router for the app.
///
/// It returns a [GoRouter] object that represents the router for the app.
/// Inside the router, it defines the branches of the app using the method [getDestinations].
GoRouter createRouter(GlobalKey<NavigatorState> rootNavigatorKey) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithHeaderNavbarAndDrawer(
            navigationShell: navigationShell,
            destinations: getDestinations(),
          );
        },
        branches: [
          for (final destination in getDestinations())
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: destination.path,
                  name: destination.name,
                  builder: (context, state) => destination.screen,
                ),
              ],
            ),
        ],
      ),
    ],
  );
}
