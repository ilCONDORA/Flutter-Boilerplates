import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../layout/layout_dispatcher.dart';
import 'routes_declaration.dart';
import 'route_declaration_model.dart';

/// This variable holds the all the data related to the routes.
/// It's also used when we need to display dialogs and etc. at the root level.
///
final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

/// The [RouterConfiguration] class is responsible for managing the application's routing.
/// It uses the [GoRouter] package to define the routes and navigation logic.
///
/// The first thing it does is to define the root navigator key,
/// which is used to control the navigation at the root level, then it defines
/// the initial location of the app, and finally it defines the routes.
///
class RouterConfiguration {
  static final GoRouter config = GoRouter(
    redirect: (BuildContext context, GoRouterState state) {
      if (state.uri.toString() == '/') {
        return '/home';
      }

      return null;
    },
    initialLocation: '/home',
    navigatorKey: rootNavigatorKey,
    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
        branches: routesDeclarationList.convertToStatefulShellBranches(),
        builder:
            (
              BuildContext context,
              GoRouterState state,
              StatefulNavigationShell navigationShell,
            ) => LayoutDispatcher(navigationShell: navigationShell),
      ),
    ],
  );
}
