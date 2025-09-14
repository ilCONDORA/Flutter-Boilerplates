import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/active/tasks_page.dart';
import '../screens/active/task_details_page.dart';
import '../screens/home/home_page.dart';

/// This class holds the names of all the routes that will be assigned
/// to the routes in all [GoRoute]s.
/// This will also be used when using the [GoRouter.goNamed] method
/// to navigate to the routes.
///
class DefinedRoutesNames {
  static const home = "Home";
  static const tasks = "Tasks";
  static const taskDetails = "Task Details";
}

/// This list holds the specification of all the routes that will be build.
///
final List<RoutesDeclaration> routesDeclarationList = [
  RoutesDeclaration(
    name: DefinedRoutesNames.home,
    path: '/',
    pageBuilder: (context, state) => HomePage(key: state.pageKey),
  ),
  RoutesDeclaration(
    name: DefinedRoutesNames.tasks,
    path: "/tasks",
    pageBuilder: (context, state) => TasksPage(key: state.pageKey),

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
class RoutesDeclaration {
  final String name;
  final String path;
  final Widget Function(BuildContext, GoRouterState) pageBuilder;
  final List<RoutesDeclaration> routes;

  RoutesDeclaration({
    required this.name,
    required this.path,
    required this.pageBuilder,
    this.routes = const <RoutesDeclaration>[],
  });
}
