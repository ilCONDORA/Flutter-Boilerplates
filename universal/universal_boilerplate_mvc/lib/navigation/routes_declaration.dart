import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../pages/tasks/tasks_page.dart';
import '../pages/tasks/task_details_page.dart';
import '../pages/home/home_page.dart';

/// This class holds the names of all the routes that will be assigned
/// to the routes in all [GoRoute]s.
/// This will also be used when using the [GoRouter.goNamed] method
/// to navigate to the routes.
///
class DefinedRoutesNames {
  static const home = 'Home';
  static const tasks = 'Tasks';
  static const taskDetails = 'Task Details';
}

/// This list holds the specification of all the routes that will be build.
///
final List<RoutesDeclaration> routesDeclarationList = [
  ...bottomNavigationRoutes,
];

/// This list holds the specification of all the routes that will be shown
/// in the bottom navigation bar.
///
/// The order matters because it's the order in which they will be shown.
///
final List<RoutesDeclaration> bottomNavigationRoutes = [
  RoutesDeclaration(
    name: DefinedRoutesNames.home,
    path: '/home',
    pageBuilder: (context, state) => HomePage(key: state.pageKey),
    icon: Icons.home_outlined,
    selectedIcon: Icons.home,
  ),
  RoutesDeclaration(
    name: DefinedRoutesNames.tasks,
    path: '/tasks',
    pageBuilder: (context, state) => TasksPage(key: state.pageKey),
    icon: Icons.all_inbox_outlined,
    selectedIcon: Icons.all_inbox,
    routes: [
      RoutesDeclaration(
        name: DefinedRoutesNames.taskDetails,
        path: ':id/details',
        pageBuilder: (context, state) {
          final String? id = state.pathParameters['id'];
          final int? idInt = int.tryParse(id ?? '');

          return TaskDetailsPage(id: idInt, key: state.pageKey);
        },
      ),
    ],
  ),
];

/// [RoutesDeclaration] is used to define all the data related to a route.
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
class RoutesDeclaration {
  final String name;
  final String path;
  final Widget Function(BuildContext context, GoRouterState state) pageBuilder;
  final List<RoutesDeclaration> routes;
  final IconData? icon;
  final IconData? selectedIcon;

  RoutesDeclaration({
    required this.name,
    required this.path,
    required this.pageBuilder,
    this.routes = const <RoutesDeclaration>[],
    this.icon,
    this.selectedIcon,
  });

  /// Convert this declaration and its children into a [GoRoute].
  ///
  /// This makes conversion logic owned by the declaration itself.
  ///
  GoRoute toGoRoute() {
    return GoRoute(
      name: name,
      path: path,
      builder: (context, state) => pageBuilder(context, state),
      routes:
          routes.isNotEmpty ? routes.map((r) => r.toGoRoute()).toList() : [],
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
