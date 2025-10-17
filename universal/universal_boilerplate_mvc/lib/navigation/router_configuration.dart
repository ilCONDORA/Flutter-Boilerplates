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
    redirect: (context, state) {
      if (state.uri.toString() == '/') {
        return '/home';
      }

      return null;
    },
    initialLocation: '/home',
    navigatorKey: rootNavigatorKey,
    routes: [
      StatefulShellRoute.indexedStack(
        branches: _convertToStatefulShellBranches(
          propRoutesDeclarationList: routesDeclarationList,
        ),
        builder:
            (context, state, navigationShell) =>
                LayoutDispatcher(navigationShell: navigationShell),
      ),
    ],
  );
}

/// Convert a list of [RoutesDeclaration] into a list of [StatefulShellBranch].
/// This is used to create branches for the [StatefulShellRoute].
/// Each branch corresponds to a main route and its children routes.
///
/// Also we can see that we use the [RoutesDeclaration.toStatefulShellBranch] method to convert the routes of each branch.
/// This allows us to keep the routes declaration clean and organized.
///
List<StatefulShellBranch> _convertToStatefulShellBranches({
  required List<RoutesDeclaration> propRoutesDeclarationList,
}) {
  return propRoutesDeclarationList
      .map((route) => route.toStatefulShellBranch())
      .toList();
}
