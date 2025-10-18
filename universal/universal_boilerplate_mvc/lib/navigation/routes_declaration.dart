import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../pages/tasks/tasks_page.dart';
import '../pages/tasks/task_details_page.dart';
import '../pages/home/home_page.dart';
import 'route_declaration_model.dart';

/// This is an enhanced enum. The difference with a regular enum is that we can define an enum with some properties and create some methods for it.
///
/// Here we define an enum to hold the route names and their paths.
/// When defining an enum we need to associate a path to it and to access the path we can use the [path] property by calling it on the enum value.
///
/// We also define a method [getLocalizedName] to get the localized name of the route based on the context it receives.
///
/// For example:
/// ```dart
/// DefinedRoutes.home.name // returns 'home'
/// DefinedRoutes.home.path // returns '/home'
/// DefinedRoutes.tasks.getLocalizedName(context) // returns the localized name for the tasks route
/// ```
///
enum DefinedRoutes {
  home(path: '/home'),
  tasks(path: '/tasks'),
  taskDetails(path: ':id/details');

  const DefinedRoutes({
    required this.path,
  });

  final String path;

  String getLocalizedName(BuildContext context) {
    final AppLocalizations al = AppLocalizations.of(context)!;
    final String nln = 'No Localization needed';

    switch (this) {
      case DefinedRoutes.home:
        return al.home_route_name;
      case DefinedRoutes.tasks:
        return al.tasks_route_name;
      case DefinedRoutes.taskDetails:
        return al.task_details_route_name;
    }
  }
}

/// This list holds the specification of all the routes that will be build and rendered by the primary navigation.
///
final List<RouteDeclarationModel> routesDeclarationList = [
  ...bottomNavigationRoutes,
];

/// This list holds the specification of all the routes that will be shown in the bottom navigation bar.
///
///! THE ORDER MATTERS because it's the order in which they will be shown.
///
final List<RouteDeclarationModel> bottomNavigationRoutes = [
  RouteDeclarationModel(
    definedRoute: DefinedRoutes.home,
    pageBuilder: (context, state) => HomePage(key: state.pageKey),
    icon: Icons.home_outlined,
    selectedIcon: Icons.home,
  ),
  RouteDeclarationModel(
    definedRoute: DefinedRoutes.tasks,
    pageBuilder: (context, state) => TasksPage(key: state.pageKey),
    icon: Icons.all_inbox_outlined,
    selectedIcon: Icons.all_inbox,
    routes: [
      RouteDeclarationModel(
        definedRoute: DefinedRoutes.taskDetails,
        pageBuilder: (context, state) {
          final String? id = state.pathParameters['id'];
          final int? idInt = int.tryParse(id ?? '');

          return TaskDetailsPage(id: idInt, key: state.pageKey);
        },
      ),
    ],
  ),
];
