import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/active/tasks_page.dart';
import '../screens/active/task_details_page.dart';
import '../screens/home/home_page.dart';
import '../navigation/router_configuration.dart';
import 'clean_sequential_fade_transition_page.dart';

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
    pageBuilder:
        (context, state) => CleanSequentialFadeTransitionPage(
          child: const HomePage(),
          key: state.pageKey,
        ),
  ),
  RoutesDeclaration(
    name: DefinedRoutesNames.tasks,
    path: "/tasks",
    pageBuilder:
        (context, state) => CleanSequentialFadeTransitionPage(
          child: TasksPage(),
          key: state.pageKey,
        ),
    routes: [
      RoutesDeclaration(
        name: DefinedRoutesNames.taskDetails,
        path: ':id/details',
        pageBuilder: (context, state) {
          final String? id = state.pathParameters['id'];
          final int? idInt = int.tryParse(id ?? '');

          return CleanSequentialFadeTransitionPage(
            child: TaskDetailsPage(id: idInt),
            key: state.pageKey,
          );
        },
      ),
    ],
  ),
];

//TODO: Rewrite.
/// [RoutesDeclaration] is used to define all the data related to a route.
///
/// The [buildPage] method is used in the [RouterConfiguration] by [GoRoute]
/// and basically instead of using the [pageBuilder] directly, it uses this method
/// because it also updates the [PopRouteCubit] with the [poppable] value and then
/// it calls the [pageBuilder] to build the page.
///
class RoutesDeclaration {
  final String name;
  final String path;
  final Page<dynamic> Function(BuildContext, GoRouterState) pageBuilder;
  final List<RoutesDeclaration> routes;

  RoutesDeclaration({
    required this.name,
    required this.path,
    required this.pageBuilder,
    this.routes = const <RoutesDeclaration>[],
  });
}
