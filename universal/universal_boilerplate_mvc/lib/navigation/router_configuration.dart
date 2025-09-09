import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../layout/layout_dispatcher.dart';
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
    routes: [
      ShellRoute(
        routes: _convertToGoRoutes(routesDeclarationList),
        builder:
            (context, state, child) => LayoutDispatcher(screenWidget: child),
      ),
    ],
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
      pageBuilder: (context, state) => route.pageBuilder(context, state),
      routes: route.routes.isNotEmpty ? _convertToGoRoutes(route.routes) : [],
    );
  }).toList();
}
