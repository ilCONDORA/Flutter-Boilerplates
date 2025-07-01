import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/active/active_screen.dart';
import '../screens/active/single_active_screen.dart';
import '../screens/archived/archived_screen.dart';
import '../screens/home/home_screen.dart';

import 'layout_dispatcher.dart';

/// This variable holds the all the data related to the routes.
/// It's also used when we need to display dialogs and etc. at the root level.
///
final rootNavigatorKey = GlobalKey<NavigatorState>();

/// The [AppRouter] class is responsible for managing the application's routing.
/// It uses the [GoRouter] package to define the routes and navigation logic.
///
/// The first thing it does is to define the root navigator key,
/// which is used to control the navigation at the root level, then it defines
/// the initial location of the app, and finally it defines the routes.
///
class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/home',
    navigatorKey: rootNavigatorKey,
    routes: _routes,
  );
}

/// The [_routes] variable holds the list of all the routes in the application.
/// Instead of having a list of [RouteBase] we use the [StatefulShellRoute.indexedStack] to
/// manage the navigation between different screens by passing the routes index to a widget
/// responsible for displaying the correct screen based on the current index.
/// All this is managed by the [LayoutDispatcher] widget and [navigationShell] provided by [StatefulShellRoute].
///
final _routes = <RouteBase>[
  StatefulShellRoute.indexedStack(
    branches: [
      StatefulShellBranch(
        routes: [
          GoRoute(path: '/home', builder: (context, state) => HomeScreen()),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: '/active',
            builder: (context, state) => ActiveScreen(),
            routes: [
              GoRoute(
                path: ':activeId',
                builder: (context, state) {
                  final activeId = state.pathParameters['activeId']!;
                  return SingleActiveScreen(id: activeId);
                },
              ),
            ],
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: '/archived',
            builder: (context, state) => ArchivedScreen(),
          ),
        ],
      ),
    ],
    builder:
        (context, state, navigationShell) => LayoutDispatcher(
          navigationShell: navigationShell,
          child: navigationShell,
        ),
  ),
];
