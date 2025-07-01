import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'router.gr.dart';

const maintainState = false;

@AutoRouterConfig()
// This annotation changes the name of the class, the default is 'Page|Screen,Route'.
// So something like 'HomeRoute' will be used instead of 'HomePage' or 'HomeScreen'.
class NewAppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/',
          page: LayoutNavigationWrapper.page,
          children: listOfNavigationRoutesAndChildren
              .map(
                (individualRoute) => AutoRoute(
                  path: individualRoute.path,
                  page: individualRoute.page,
                  initial: individualRoute.initial,
                  maintainState: maintainState,
                  children: _generateChildren(individualRoute.children),
                ),
              )
              .toList(),
        ),
      ];

  @override
  List<AutoRouteGuard> get guards => [
        // optionally add root guards here
      ];
}

List<AutoRoute>? _generateChildren(
    List<RouteProperties>? individualRouteChildren) {
  if (individualRouteChildren == null) return null;
  return individualRouteChildren
      .map(
        (child) => AutoRoute(
          path: child.path,
          page: child.page,
          maintainState: maintainState,
          children: _generateChildren(child.children),
        ),
      )
      .toList();
}

List<RouteProperties> listOfNavigationRoutesAndChildren = [
  RouteProperties(
    initial: true,
    path: '',
    route: HomeRoute(),
    page: HomeRoute.page,
    navigationProperties: NavigationProperties(
      label: (context) => 'Home',
      icon: Icons.home_outlined,
    ),
  ),
  RouteProperties(
    path: 'info',
    route: InfoRoute(),
    page: InfoRoute.page,
    navigationProperties: NavigationProperties(
      label: (context) => 'Info',
      icon: Icons.info_outline,
    ),
  ),
  RouteProperties(
    path: 'devices',
    route: DevicesChildrenNavigationRouter(),
    page: DevicesChildrenNavigationRouter.page,
    navigationProperties: NavigationProperties(
      label: (context) => 'Devices',
      icon: Icons.devices_other_outlined,
    ),
    children: [
      RouteProperties(
        path: '',
        page: DevicesRoute.page,
      ),
      RouteProperties(
        path: ':deviceId',
        page: SingleDeviceRoute.page,
      ),
    ],
  ),
  RouteProperties(
    path: 'cpus',
    route: CpusChildrenNavigationRouter(),
    page: CpusChildrenNavigationRouter.page,
    navigationProperties: NavigationProperties(
      label: (context) => 'Cpus',
      icon: Icons.diamond_outlined,
    ),
    children: [
      RouteProperties(
        path: '',
        page: CpusRoute
            .page, // Lista di tutti i tipi di CPU (desktop, laptop, mobile)
      ),
      RouteProperties(
        path: ':cpuType', // Il tipo di CPU scelto (desktop, laptop, mobile)
        page: CpuTypeChildrenNavigationRouter
            .page, // Pagina che mostra le CPU di questo tipo
        children: [
          RouteProperties(
            path: '',
            page: CpuTypeListRoute.page, // Lista delle CPU del tipo specifico
          ),
          RouteProperties(
            path: ':cpuName', // L'ID della CPU specifica
            page: SingleCpuRoute.page, // Dettagli della singola CPU
          ),
        ],
      ),
    ],
  ),
];

class RouteProperties {
  final bool initial;
  final String path;
  final dynamic route;
  final PageInfo page;
  final NavigationProperties? navigationProperties;
  final List<RouteProperties>? children;

  RouteProperties({
    this.initial = false,
    required this.path,
    this.route,
    required this.page,
    this.navigationProperties,
    this.children,
  });
}

class NavigationProperties {
  final String Function(BuildContext context) label;
  final bool showLabel;
  final IconData icon;
  final bool showIcon;
  final Widget? otherThingInsteadOfIcon;
  final bool showOtherThingInsteadOfIcon;

  NavigationProperties({
    required this.label,
    this.showLabel = true,
    required this.icon,
    this.showIcon = true,
    this.otherThingInsteadOfIcon,
    this.showOtherThingInsteadOfIcon = false,
  });
}
