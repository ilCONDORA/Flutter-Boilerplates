import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/active/tasks_screen.dart';
import '../screens/active/task_details_screen.dart';
import '../screens/home/home_screen.dart';

/// This class holds the names of all the routes that will be used in [GoRouter].
/// This class is used to navigate between the routes using the [GoRouter.goNamed] method.
///
class DeclaredRoutesNames {
  static const home = "Home";
  static const tasks = "Tasks";
  static const taskDetails = "Details of Task";
}

/// This list holds the specification of all the routes that will be build inside a [StatefulShellBranch].
/// This list will be used to create routes and buttons for the navigation.
///
final List<RoutesDeclaration> routesDeclarationList = [
  RoutesDeclaration(
    name: DeclaredRoutesNames.home,
    path: '/',
    navigationItemModel: NavigationItemModel(icon: Icons.home, text: 'Home'),
    pageBuilder:
        (context, state) =>
            NoTransitionPage(child: HomeScreen(), key: state.pageKey),
  ),
  RoutesDeclaration(
    name: DeclaredRoutesNames.tasks,
    path: "/tasks",
    pageBuilder:
        (context, state) =>
            NoTransitionPage(child: TasksScreen(), key: state.pageKey),
    navigationItemModel: NavigationItemModel(icon: Icons.list, text: 'Tasks'),
    routes: [
      RoutesDeclaration(
        name: DeclaredRoutesNames.taskDetails,
        path: ':id/details',
        pageBuilder: (context, state) {
          final id = state.pathParameters['id']!;
          return NoTransitionPage(
            child: TaskDetailsScreen(id: id),
            key: state.pageKey,
          );
        },
      ),
    ],
  ),
];

/// The [RoutesDeclaration] class is used to define all the data related to a route and navigation button.
/// The only parameter that is NOT required is the [navigationItemModel], this is because the children routes of a main one
/// do not need to have a navigation button.
///
class RoutesDeclaration {
  final String name;
  final String path;
  final Page<dynamic> Function(BuildContext, GoRouterState) pageBuilder;
  final List<RoutesDeclaration> routes;
  final NavigationItemModel? navigationItemModel;

  RoutesDeclaration({
    required this.name,
    required this.path,
    required this.pageBuilder,
    this.routes = const <RoutesDeclaration>[],
    this.navigationItemModel,
  });

  @override
  String toString() {
    return 'RoutesDeclaration(name: $name, path: $path, pageBuilder: $pageBuilder, routes: $routes, navigationItemModel: $navigationItemModel)';
  }
}

/// The [NavigationItemModel] class is used to define the data related to a navigation button.
/// It contains the icon and text that will be displayed on the button.
///
class NavigationItemModel {
  final IconData icon;
  final String text;

  NavigationItemModel({required this.icon, required this.text});

  @override
  String toString() => 'NavigationItemModel(icon: $icon, text: $text)';
}
