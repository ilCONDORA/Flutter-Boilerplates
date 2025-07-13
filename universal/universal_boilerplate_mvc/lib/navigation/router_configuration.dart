import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'layout_dispatcher.dart';
import 'routes_declaration.dart';

/// This variable holds the all the data related to the routes.
/// It's also used when we need to display dialogs and etc. at the root level.
///
final rootNavigatorKey = GlobalKey<NavigatorState>();

/// The [RouterConfiguration] class is responsible for managing the application's routing.
/// It uses the [GoRouter] package to define the routes and navigation logic.
///
/// The first thing it does is to define the root navigator key,
/// which is used to control the navigation at the root level, then it defines
/// the initial location of the app, and finally it defines the routes.
///
class RouterConfiguration {
  static final GoRouter config = GoRouter(
    initialLocation: '/',
    navigatorKey: rootNavigatorKey,
    routes: _routes,
  );
}

/// Convert a list of [RoutesDeclaration] into a list of [GoRoute].
/// This is used to create the routes for the [GoRouter].
///
/// Here we can see that this method is called inside itself recursively to convert the routes.
///
List<GoRoute> _convertToGoRoutes(List<RoutesDeclaration> routesDeclaration) {
  return routesDeclaration.map((route) {
    return GoRoute(
      name: route.name,
      path: route.path,
      pageBuilder: route.pageBuilder,
      routes: route.routes.isNotEmpty ? _convertToGoRoutes(route.routes) : [],
    );
  }).toList();
}

/// Convert a list of [RoutesDeclaration] into a list of [StatefulShellBranch].
/// This is used to create branches for the [StatefulShellRoute].
/// Each branch corresponds to a main route and its children routes.
///
/// Also we can see that we use the [_convertToGoRoutes] method to convert the routes of each branch.
/// This allows us to keep the routes declaration clean and organized.
///
List<StatefulShellBranch> _convertToStatefulShellBranches({
  required List<RoutesDeclaration> propRoutesDeclarationList,
}) {
  return propRoutesDeclarationList.map((route) {
    return StatefulShellBranch(
      routes: [
        GoRoute(
          name: route.name,
          path: route.path,
          pageBuilder: route.pageBuilder,
          routes:
              route.routes.isNotEmpty ? _convertToGoRoutes(route.routes) : [],
        ),
      ],
    );
  }).toList();
}

/// The [_routes] variable holds the list of all the routes in the application.
/// Instead of having a list of [RouteBase] we use the [StatefulShellRoute.indexedStack] to
/// manage the navigation between different screens by passing the routes index to a widget
/// responsible for displaying the correct screen based on the current index.
/// All this is managed by the [LayoutDispatcher] widget and [navigationShell] provided by [StatefulShellRoute].
///
/// We can also see that we use the [routesDeclarationList] variable and [_convertToStatefulShellBranches] method
/// to create the branches of the [StatefulShellRoute].
///
final _routes = <RouteBase>[
  StatefulShellRoute.indexedStack(
    branches: _convertToStatefulShellBranches(
      propRoutesDeclarationList: routesDeclarationList,
    ),
    builder:
        (context, state, navigationShell) =>
            LayoutDispatcher(navigationShell: navigationShell),
  ),
];
