import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../screens/home_screen.dart';
import '../screens/product_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/settings_screen.dart';
import 'scaffold_dynamic_orientation.dart';

/// [NavigationType] is used by [getDestinations] to determine which tipe of navigation to use.
///
/// It's supposed to be used with orientation of the device to decide to use either [BottomNavigationBar] or [NavigationRail].
enum NavigationType { bottom, rail }

/// [NavigationInformations] is used by [getDestinations] and provide the necessary informations for the navigation.
///
/// The properties are:
/// - [path] is the path of the route.
/// - [name] is the name of the route.
/// - [screen] is the screen to display when the route is selected.
/// - [navigationWidget] is the widget used to display the navigation item.
/// - [subRoutes] is the list of sub routes.
///
/// [navigationWidget] is a function that takes a [BuildContext] and it's supposed to use a
/// switch statement with [NavigationType] to determine which widget to use.
class NavigationInformations {
  final GlobalKey<NavigatorState> shellNavigatorKey;
  final String path;
  final String name;
  final Widget screen;
  final Object Function(BuildContext) navigationWidget;
  final List<RouteBase> subRoutes;

  const NavigationInformations({
    required this.shellNavigatorKey,
    required this.path,
    required this.name,
    this.screen = const Placeholder(),
    required this.navigationWidget,
    this.subRoutes = const <RouteBase>[],
  });
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorHomeKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellHome');
final _shellNavigatorProductsKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellProducts');
final _shellNavigatorProfileKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellProfile');

/// [getDestinations] is used to get the destinations for the navigation.
///
/// It accepts a [NavigationType] and returns a list of [NavigationInformations] with a different navigation widget based on the [NavigationType].
///
/// It returns a list of [NavigationInformations] and these are used by [createRouter] to create the branches.
List getDestinations({
  required NavigationType navigationType,
}) =>
    [
      NavigationInformations(
        shellNavigatorKey: _shellNavigatorHomeKey,
        path: '/',
        name: 'home',
        navigationWidget: (context) => switch (navigationType) {
          NavigationType.bottom => BottomNavigationBarItem(
              icon: const Icon(Icons.home_outlined),
              activeIcon: const Icon(Icons.home),
              label: AppLocalizations.of(context)!.home_label,
            ),
          NavigationType.rail => NavigationRailDestination(
              icon: const Icon(Icons.home_outlined),
              selectedIcon: const Icon(Icons.home),
              label: Text(AppLocalizations.of(context)!.home_label),
            ),
        },
        screen: const HomeScreen(),
      ),
      NavigationInformations(
        shellNavigatorKey: _shellNavigatorProductsKey,
        path: '/products',
        name: 'products',
        navigationWidget: (context) => switch (navigationType) {
          NavigationType.bottom => BottomNavigationBarItem(
              icon: const Icon(Icons.business),
              label: AppLocalizations.of(context)!.products_label,
            ),
          NavigationType.rail => NavigationRailDestination(
              icon: const Icon(Icons.business),
              label: Text(AppLocalizations.of(context)!.products_label),
            ),
        },
        screen: const ProductScreen(),
      ),
      NavigationInformations(
        shellNavigatorKey: _shellNavigatorProfileKey,
        path: '/profile',
        name: 'profile',
        navigationWidget: (context) => switch (navigationType) {
          NavigationType.bottom => BottomNavigationBarItem(
              icon: const Icon(Icons.school_outlined),
              activeIcon: const Icon(Icons.school),
              label: AppLocalizations.of(context)!.profile_label,
              tooltip: AppLocalizations.of(context)!
                  .tooltip_tap_again_to_go_to_the_beginning,
            ),
          NavigationType.rail => NavigationRailDestination(
              icon: Tooltip(
                message: AppLocalizations.of(context)!
                    .tooltip_tap_again_to_go_to_the_beginning,
                child: const Icon(Icons.school_outlined),
              ),
              selectedIcon: Tooltip(
                message: AppLocalizations.of(context)!
                    .tooltip_tap_again_to_go_to_the_beginning,
                child: const Icon(Icons.school),
              ),
              label: Text(AppLocalizations.of(context)!.profile_label),
            ),
        },
        screen: const ProfileScreen(),
        subRoutes: [
          GoRoute(
            parentNavigatorKey: _shellNavigatorProfileKey,
            path: 'settings',
            name: 'settings',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: SettingsScreen()),
          ),
        ],
      ),
    ];

/// [createRouter] is used to create the router configuration.
///
/// It returns a [GoRouter] with the necessary configurations.
///
/// In the branches, it uses [getDestinations] to create all the different branches.
GoRouter createRouter() {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldDynamicNavigationOrientation(
            navigationShell: navigationShell,
          );
        },
        branches: getDestinations(
          navigationType:
              NavigationType.bottom, // navigationType can be any value
        ).map((destination) {
          return StatefulShellBranch(
            navigatorKey: destination.shellNavigatorKey,
            routes: [
              GoRoute(
                path: destination.path,
                name: destination.name,
                builder: (context, state) => destination.screen,
                routes: destination.subRoutes,
              ),
            ],
          );
        }).toList(),
      ),
    ],
  );
}
