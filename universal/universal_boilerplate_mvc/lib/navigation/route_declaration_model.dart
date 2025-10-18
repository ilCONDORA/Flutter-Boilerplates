import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'routes_declaration.dart';

/// [RouteDeclarationModel] is used to define all the data related to a route.
///
/// It holds the [DefinedRoutes] enum value to identify the route, which gives us access to the name and path.
///
/// [pageBuilder], as the name implies, is used to build the page and it's a
/// method because it needs the [BuildContext] and [GoRouterState];
/// We can use [GoRouterState] to get the pathParameters, queryParameters, etc.
///
/// The [icon] and [selectedIcon] are used by the navigation code, that's why it's optional.
///
/// This class also contains methods to convert itself into a [GoRoute] or a [StatefulShellBranch].
/// The conversion methods make the conversion logic owned by the declaration itself.
///
class RouteDeclarationModel {
  final DefinedRoutes definedRoute;
  final Widget Function(BuildContext context, GoRouterState state) pageBuilder;
  final List<RouteDeclarationModel> routes;
  final IconData? icon;
  final IconData? selectedIcon;

  RouteDeclarationModel({
    required this.definedRoute,
    required this.pageBuilder,
    this.routes = const <RouteDeclarationModel>[],
    this.icon,
    this.selectedIcon,
  });

  String get name => definedRoute.name;
  String get path => definedRoute.path;

  /// Convert this declaration and its children into a [GoRoute].
  ///
  /// This makes conversion logic owned by the declaration itself.
  ///
  GoRoute toGoRoute() {
    return GoRoute(
      name: name,
      path: path,
      builder: (context, state) => pageBuilder(context, state),
      routes: routes.isNotEmpty
          ? routes.map((r) => r.toGoRoute()).toList()
          : [],
    );
  }

  /// Convert this declaration into a [StatefulShellBranch].
  ///
  /// The branch contains a single top-level [GoRoute] (this declaration)
  ///
  StatefulShellBranch toStatefulShellBranch() {
    return StatefulShellBranch(routes: [toGoRoute()]);
  }
}

/// Extensions are a way to add functionality to existing data types.
/// Here we add a method to the [RouteDeclarationModel] list type to convert it to a list of [StatefulShellBranch].
///
extension ListRouteDeclarationModelExtension on List<RouteDeclarationModel> {
  /// Convert this list of [RouteDeclarationModel] into a list of [StatefulShellBranch].
  ///
  List<StatefulShellBranch> convertToStatefulShellBranches() {
    return map((route) => route.toStatefulShellBranch()).toList();
  }
}
