/* import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:universal_boilerplate/routing_layout/app_router.gr.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Run 'dart run build_runner build' or 'dart run build_runner watch' to generate the router code.
// This will generate the 'app_router.gr.dart' file with the routes and guards.

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: AppLayout.page,
          path: '/',
          children: listOfRouteProperties
              .map(
                (singleRouteProperties) => AutoRoute(
                  page: singleRouteProperties.pageInfo,
                  initial: singleRouteProperties.initial,
                  path: singleRouteProperties.path,
                  children: _generateChildren(singleRouteProperties.children),
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

class RouteProperties {
  final String path;
  final PageInfo pageInfo;
  final PageRouteInfo pageWidget;
  final bool showWidget;
  final IconData unselectedIcon;
  final IconData? selectedIcon;
  final bool showIcons;
  final Widget? otherWidgetInsteadOfIcon;
  final bool showOtherWidgetInsteadOfIcon;
  final String Function(BuildContext) label;
  final bool showLabel;
  final bool initial;
  final List<RouteProperties> children;

  RouteProperties({
    required this.path,
    required this.pageInfo,
    required this.pageWidget,
    required this.showWidget,
    required this.unselectedIcon,
    this.selectedIcon,
    required this.showIcons,
    this.otherWidgetInsteadOfIcon,
    this.showOtherWidgetInsteadOfIcon = false,
    required this.label,
    required this.showLabel,
    this.initial = false,
    required this.children,
  });
}

List<RouteProperties> listOfRouteProperties = [
  RouteProperties(
    path: '',
    pageInfo: HomeRoute.page,
    pageWidget: HomeRoute(),
    showWidget: true,
    unselectedIcon: Icons.home_outlined,
    selectedIcon: Icons.home,
    showIcons: true,
    label: (context) => AppLocalizations.of(context)!.home_label,
    showLabel: true,
    initial: true,
    children: [],
  ),
  RouteProperties(
    path: 'info',
    pageInfo: InfoRoute.page,
    pageWidget: InfoRoute(),
    showWidget: true,
    unselectedIcon: Icons.info_outline,
    selectedIcon: Icons.info,
    showIcons: true,
    label: (context) => AppLocalizations.of(context)!.info_label,
    showLabel: true,
    children: [],
  ),
  RouteProperties(
    path: 'devices',
    pageInfo: DevicesRoute.page,
    pageWidget: DevicesRoute(),
    showWidget: true,
    unselectedIcon: Icons.devices_other_outlined,
    selectedIcon: Icons.devices_other,
    showIcons: true,
    label: (context) => AppLocalizations.of(context)!.devices_label,
    showLabel: true,
    children: [
      RouteProperties(
        path: ':deviceId',
        pageInfo: SingleDeviceRoute.page,
        pageWidget: SingleDeviceRoute(deviceId: ''),
        showWidget: true,
        unselectedIcon: Icons.info_outline,
        selectedIcon: Icons.info,
        showIcons: true,
        label: (context) => AppLocalizations.of(context)!.info_label,
        showLabel: true,
        children: [],
      ),
    ],
  ),
];

List<AutoRoute> _generateChildren(List<RouteProperties> children) {
  return children
      .map(
        (child) => AutoRoute(
          page: child.pageInfo,
          path: child.path,
          children: _generateChildren(child.children),
        ),
      )
      .toList();
}
 */