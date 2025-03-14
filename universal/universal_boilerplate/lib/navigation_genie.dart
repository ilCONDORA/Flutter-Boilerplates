import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pie_menu/pie_menu.dart';

class NavigationProperties {
  final String path;
  final String nameOfRoute;
  final Widget screen;
  final IconData unselectedIcon;
  final IconData? selectedIcon;
  final bool showIcons;
  final String Function(BuildContext) label;
  final bool showLabel;
  final bool showNavigationWidget;
  final List<RouteBase> subRoutes;

  NavigationProperties({
    required this.path,
    required this.nameOfRoute,
    required this.screen,
    required this.unselectedIcon,
    required this.selectedIcon,
    required this.showIcons,
    required this.label,
    required this.showLabel,
    required this.showNavigationWidget,
    required this.subRoutes,
  });
}

enum NavigationTypes {
  bottom,
  rail,
  drawer,
}

List<NavigationProperties> listOfNavigationProperties = [
  NavigationProperties(
    path: '/',
    nameOfRoute: 'home',
    screen: Center(
      child: Text('Home'),
    ),
    unselectedIcon: Icons.home_outlined,
    selectedIcon: Icons.home,
    showIcons: true,
    label: (context) => AppLocalizations.of(context)!.home_label,
    showLabel: true,
    showNavigationWidget: true,
    subRoutes: [],
  ),
  NavigationProperties(
    path: '/info',
    nameOfRoute: 'info',
    screen: Center(
      child: Text('Info'),
    ),
    unselectedIcon: Icons.info_outline,
    selectedIcon: Icons.info,
    showIcons: true,
    label: (context) => AppLocalizations.of(context)!.info_label,
    showLabel: true,
    showNavigationWidget: false,
    subRoutes: [],
  ),
  NavigationProperties(
    path: '/devices',
    nameOfRoute: 'devices',
    screen: Center(
      child: Text('Devices'),
    ),
    unselectedIcon: Icons.devices_other_outlined,
    selectedIcon: Icons.devices_other,
    showIcons: true,
    label: (context) => 'Devices!! Trans',
    showLabel: true,
    showNavigationWidget: true,
    subRoutes: [],
  ),
];

/* List navigationItemsGenerator({
  required NavigationTypes navigationType,
  required BuildContext context,
}) {
  switch (navigationType) {
    case NavigationTypes.bottom:
      List<BottomNavigationBarItem> navigationItems = [];
      for (NavigationProperties singleNavProps in listOfNavigationProperties) {
        if (singleNavProps.showNavigationWidget) {
          navigationItems.add(
            BottomNavigationBarItem(
              icon: singleNavProps.unselectedIcon,
              activeIcon:
                  singleNavProps.showIcons ? singleNavProps.selectedIcon : null,
              label: singleNavProps.showLabel
                  ? singleNavProps.label(context)
                  : null,
            ),
          );
        }
      }
      return navigationItems;
    case NavigationTypes.rail:
      List<NavigationRailDestination> navigationItems = [];
      for (NavigationProperties singleNavProps in listOfNavigationProperties) {
        if (singleNavProps.showNavigationWidget) {
          navigationItems.add(
            NavigationRailDestination(
              icon: singleNavProps.unselectedIcon,
              selectedIcon:
                  singleNavProps.showIcons ? singleNavProps.selectedIcon : null,
              label: Text(singleNavProps.label(context)),
            ),
          );
        }
      }
      return navigationItems;
    case NavigationTypes.drawer:
      List<NavigationDrawerDestination> navigationItems = [];
      for (NavigationProperties singleNavProps in listOfNavigationProperties) {
        if (singleNavProps.showNavigationWidget) {
          navigationItems.add(
            NavigationDrawerDestination(
              icon: singleNavProps.unselectedIcon,
              selectedIcon:
                  singleNavProps.showIcons ? singleNavProps.selectedIcon : null,
              label: Text(singleNavProps.label(context)),
            ),
          );
        }
      }
      return navigationItems;
  }
} */

GoRouter branchesGenerator() => GoRouter(
      routes: [
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) =>
              LayoutDispatcher(navigationShell: navigationShell),
          branches: listOfNavigationProperties.map((singleNavProps) {
            return StatefulShellBranch(
              routes: [
                GoRoute(
                  path: singleNavProps.path,
                  name: singleNavProps.nameOfRoute,
                  builder: (context, state) => singleNavProps.screen,
                  routes: singleNavProps.subRoutes,
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );

class LayoutDispatcher extends StatelessWidget {
  const LayoutDispatcher({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  /// This method is responsible for navigating to the different branches of the navigation shell.
  /// It uses the indexes of the branches to navigate to the desired screen,
  /// also it supports navigating to the initial location when tapping the item that is already active.
  ///
  void _goToBranch(int branchIndex) {
    navigationShell.goBranch(
      branchIndex,
      // A common pattern when using navigation is to support
      // navigating to the initial location when tapping the item that is
      // already active. This is how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: branchIndex == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final arrangementOfIconAndLabel = Axis.horizontal;

    return PieCanvas(
      theme: PieTheme(
        delayDuration: Duration
            .zero, // delayDuration is how much time you need to press the button for the menu to appear. So 'zero' is a tap.
        pointerSize:
            0, // By setting this to 0, the circle that indicates where you clicked will not appear.
        buttonTheme: const PieButtonTheme(
          // These are the default values, quite ugly.
          backgroundColor: Colors.blue,
          iconColor: Colors.white,
        ),
        buttonThemeHovered: PieButtonTheme(
          // These are the default values, quite ugly.
          backgroundColor: Colors.green,
          iconColor: Colors.white,
        ),
      ),
      child: Scaffold(
        key: scaffoldKey,
        body: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SelectionArea(child: navigationShell),
              GNav(
                mainAxisAlignment: MainAxisAlignment
                    .spaceAround, //TODO: Ho modificato GButton, capire come funziona l'animazione e se è snappi anche su un'app vuota.
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.grey[100]!,
                gap: 8,
                activeColor: Colors.black,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: Duration(milliseconds: 400),
                tabBackgroundColor: Colors.grey[100]!,
                color: Colors.black,
                tabs: [
                  for (NavigationProperties singleNavProps
                      in listOfNavigationProperties)
                    GButton(
                      isVisible: singleNavProps.showNavigationWidget,
                      icon: singleNavProps.unselectedIcon,
                      text: singleNavProps.label(context),
                    )
                ],
                selectedIndex: navigationShell.currentIndex,
                onTabChange: (index) => _goToBranch(index),
              ),
              Container(
                height: 80,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:
                      listOfNavigationProperties.asMap().entries.map((entry) {
                    final index = entry.key;
                    final singleNavProps = entry.value;
                    final isSelected = navigationShell.currentIndex == index;

                    return Visibility(
                      visible: singleNavProps.showNavigationWidget,
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () => _goToBranch(index),
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeOutExpo,
                            decoration: BoxDecoration(
                              border: isSelected ? Border.all() : null,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            padding: EdgeInsets.all(10),
                            child: Wrap(
                              spacing: arrangementOfIconAndLabel == Axis.horizontal ? 5 : 0,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              direction: arrangementOfIconAndLabel,
                              children: [
                                Visibility(
                                  visible: singleNavProps.showIcons,
                                  child: Icon(
                                    isSelected &&
                                            singleNavProps.selectedIcon != null
                                        ? singleNavProps.selectedIcon
                                        : singleNavProps.unselectedIcon,
                                    color:
                                        isSelected ? Colors.black : Colors.grey,
                                  ),
                                ),
                                Visibility(
                                  visible:
                                      singleNavProps.showLabel && isSelected,
                                  child: Text(
                                    singleNavProps.label(context),
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.black
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
