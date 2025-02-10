import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pie_menu/pie_menu.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'web_navigation/navigation_web.dart';
import 'web_navigation/web_navigation_destination.dart';
import 'widgets/app_settings_menu_dialogs/pie_menu_app_settings.dart';

// #region Declaration of enum (NavigationLayout) and class (NavigationInformations) for navigation

/// [NavigationLayout] is an enum that represents all the different layouts of the navigation.
///
/// The values are:
/// - [bottomNavigation] that represents the bottom navigation layout.
/// - [navigationRail] that represents the navigation rail layout.
/// - [drawer] that represents the end drawer layout.
/// - [webNavigation] that represents the web navigation layout.
///
/// Flutter doesn't have a default navigation for the web, so [webNavigation] is custom made.
///
enum NavigationLayout {
  bottomNavigation,
  navigationRail,
  navigationDrawer,
  webNavigation,
}

/// [NavigationInformations] is the class that contains all the vital informations for the navigation.
///
/// The properties are:
/// - [path] is the path of the route.
/// - [name] is the name of the route.
/// - [label] is the label of the navigation item and it's a method that takes a [BuildContext] and returns a [Text] widget.
/// To use just pass 'AppLocalizations.of(context)!.localized_text'. It's going to be used by the [AppBar] to display the title.
/// - [screen] is the screen to display when the route is selected. Pass [Placeholder] if you don't have a screen yet.
/// - [isVisible] is a boolean that determines if the [destinationWidget] should be visible or not.
/// - [destinationWidget] it stores the destination widget based on the [NavigationLayout], it's a method because it needs use a [BuildContext]
/// and it returns the correct destination widget by using a switch statement. Even if you are not planning to use all the layouts, just populate it, it's like 10 lines of code for each layout.
/// - [subRoutes] is the list of sub routes.
///
class NavigationInformations {
  final GlobalKey<NavigatorState> shellNavigatorKey;
  final String path;
  final String name;
  final Object Function(BuildContext) label;
  final Widget screen;
  final bool isVisible;
  final Object Function(BuildContext)? destinationWidget;
  final List<RouteBase> subRoutes;

  const NavigationInformations({
    required this.shellNavigatorKey,
    required this.path,
    required this.name,
    required this.label,
    required this.screen,
    required this.isVisible,
    required this.destinationWidget,
    required this.subRoutes,
  });

  @override
  String toString() {
    return '''
    /!/!/!/!/!/!/!
    NavigationInformations(
    shellNavigatorKey: $shellNavigatorKey,
    path: $path,
    name: $name,
    label: $label,
    screen: $screen,
    isVisible: $isVisible,
    navigationWidget: $destinationWidget,
    subRoutes: $subRoutes
    )
    /!/!/!/!/!/!/!
    ''';
  }
}

// #endregion

// #region Declaration of global keys

// In this section we are gonna define all the global keys. This is youseful to determine which branch is doing some action in debug mode.
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorHomeKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellHome');
final _shellNavigatorInfoKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellInfo');

// #endregion

/// [almightyGetDestinations] returns a list of [NavigationInformations], go see the [NavigationInformations] class to know more.
///
/// It accepts a [NavigationLayout] because when this method is called it's going to return the destinations based on the value of [navigationLayout].
/// The methods inside [LayoutMaster], that will build the [AppBar], [Drawer], [BottomNavigationBar] and [NavigationRail] are going to call this method to get the respective destinations.
///
/// It's really cool how we can use the switch statement to return different destinations based on the value of [navigationLayout], this was suggested by Claude Sonnet 3.5.
///
List<NavigationInformations> almightyGetDestinations(
        {required NavigationLayout navigationLayout}) =>
    [
      NavigationInformations(
        shellNavigatorKey: _shellNavigatorHomeKey,
        path: '/',
        name: 'home',
        label: (context) => AppLocalizations.of(context)!.home_label,
        screen: const Placeholder(),
        isVisible: true,
        destinationWidget: (context) => switch (navigationLayout) {
          NavigationLayout.bottomNavigation => BottomNavigationBarItem(
              icon: const Icon(Icons.home_outlined),
              activeIcon: const Icon(Icons.home),
              label: AppLocalizations.of(context)!.home_label,
            ),
          NavigationLayout.navigationRail => NavigationRailDestination(
              icon: const Icon(Icons.home_outlined),
              selectedIcon: const Icon(Icons.home),
              label: Text(AppLocalizations.of(context)!.home_label),
            ),
          NavigationLayout.navigationDrawer => NavigationDrawerDestination(
              icon: const Icon(Icons.home_outlined),
              selectedIcon: const Icon(Icons.home),
              label: Text(AppLocalizations.of(context)!.home_label),
            ),
          NavigationLayout.webNavigation => WebNavigationDestination(
              label: AppLocalizations.of(context)!.home_label,
              isVisible: true,
            )
        },
        subRoutes: [],
      ),
      NavigationInformations(
        shellNavigatorKey: _shellNavigatorInfoKey,
        path: '/info',
        name: 'info',
        label: (context) => AppLocalizations.of(context)!.info_label,
        screen: const Placeholder(),
        isVisible: true,
        destinationWidget: (context) => switch (navigationLayout) {
          NavigationLayout.bottomNavigation => BottomNavigationBarItem(
              icon: const Icon(Icons.info_outlined),
              activeIcon: const Icon(Icons.info),
              label: AppLocalizations.of(context)!.info_label,
            ),
          NavigationLayout.navigationRail => NavigationRailDestination(
              icon: const Icon(Icons.info_outlined),
              selectedIcon: const Icon(Icons.info),
              label: Text(AppLocalizations.of(context)!.info_label),
            ),
          NavigationLayout.navigationDrawer => NavigationDrawerDestination(
              icon: const Icon(Icons.info_outlined),
              selectedIcon: const Icon(Icons.info),
              label: Text(AppLocalizations.of(context)!.info_label),
            ),
          NavigationLayout.webNavigation => WebNavigationDestination(
              label: AppLocalizations.of(context)!.info_label,
              isVisible: true,
            )
        },
        subRoutes: [],
      ),
    ];

/// [getRouterConfiguration] returns a [GoRouter] with the necessary configurations.
///
/// In the routes, it uses [StatefulShellRoute.indexedStack]. This will create stateful screens and we can
/// use the indexes of the branches to navigated to the desired screen, we will use the names because it's more secure.
///
/// In the branches, it uses [almightyGetDestinations] to create all the different branches.
/// Now it uses [NavigationLayout.bottomNavigation] because we suppouse and suggest that all the types of the enum are populated.
///
GoRouter getRouterConfiguration() {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return LayoutMaster(
            navigationShell: navigationShell,
          );
        },
        branches: almightyGetDestinations(
          /// navigationLayout can be any value of the enum, because all the types are populated.
          navigationLayout: NavigationLayout.bottomNavigation,
        ).map((destination) {
          return StatefulShellBranch(
            navigatorKey: destination.shellNavigatorKey,
            routes: [
              GoRoute(
                path: destination.path,
                name: destination.name,
                builder: (context, state) => destination.screen,
                routes: destination.subRoutes,
              ),
            ],
          );
        }).toList(),
      ),
    ],
  );
}

/// [LayoutMaster] is the most important widget of the app, it's the one that creates the layout of the app.
///
/// Inside there are methods to create the body, [AppBar], [Drawer], [BottomNavigationBar], [NavigationRail].
/// I will explain them more in detail.
///
/// The [build] method returns a [SelectionArea] wich child is a [PieCanvas] wich child is the [Scaffold].
/// What is [SelectionArea]? It's the widget that allows you to select all the text in the app. So instead of using [SelectableText] for every text we use that widget.
/// What is [PieCanvas]? It's the widget that we must put here so that we can use a [PieMenu] (circular menu) later on for the settings of the app. It's from the pie_menu package.
///
/// To chose to display either [Drawer] or endDrawer we use the [useDrawerInsteadOfEndDrawer] variable. I prefer endDrawer because it's more user friendly, so the value is false,
/// this value will be passet to [AppBar] to display the icon and also to [Scaffold] to display the drawer or endDrawer.
///
class LayoutMaster extends StatelessWidget {
  const LayoutMaster({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  static const bool useDrawerInsteadOfEndDrawer = false;

  /// This method is responsible for navigating to the different branches of the navigation shell.
  /// It uses the indexes of the branches to navigate to the desired screen,
  /// also it supports navigating to the initial location when tapping the item that is already active.
  ///
  void _goToBranch(int index) {
    navigationShell.goBranch(
      index,
      // A common pattern when using navigation is to support
      // navigating to the initial location when tapping the item that is
      // already active. This is how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return SelectionArea(
      child: PieCanvas(
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
          appBar: kIsWeb
              ? _buildDynamicAppBar(
                  context: context,
                  scaffoldKey: scaffoldKey,
                )
              : null,
          body: _buildBodyAndNavigationRail(
            context: context,
          ),
          bottomNavigationBar: kIsWeb
              ? null
              : _buildBottomNavigationBar(
                  context: context,
                ),
          drawer: useDrawerInsteadOfEndDrawer
              ? _buildDrawerOrEndDrawer(
                  context: context,
                  scaffoldKey: scaffoldKey,
                )
              : null,
          endDrawer: useDrawerInsteadOfEndDrawer
              ? null
              : _buildDrawerOrEndDrawer(
                  context: context,
                  scaffoldKey: scaffoldKey,
                ),
        ),
      ),
    );
  }

  // #region Methods that build the UI of the app, appBar, body, drawer, endDrawer, bottomNavigationBar, navigationRail.

  /// So [_buildDynamicAppBar] as the name says, it builds the app bar depending on the value of [useDrawerInsteadOfEndDrawer]
  /// and the width of the screen. For now it uses a maximum width specified by the developer but in the future it will be automatic.
  ///
  /// As you can see in the [Scaffold], where we use this method, the [AppBar] is not always build, this will build only if the platform is web.
  ///
  /// Here we can see the custom made navigation for the web [NavigationWeb], this class has [spacingStyle], this option places the navigation items
  /// in the centerish (slightly to the left) of the app bar, this can be changed to left, but I thing it's prettier to center it.
  ///
  /// We also have the cool [PieMenuAppSettings], this widget was made by using the pie_menu package, and allows us to have a single [IconButton]
  /// that when pressed opens a circual menu that contains other [IconButton] that allow us to open the relative setting of the app.
  ///
  AppBar _buildDynamicAppBar({
    required BuildContext context,
    required GlobalKey<ScaffoldState> scaffoldKey,
  }) {
    return AppBar(
      automaticallyImplyLeading:
          false, // This disable the back button in the app bar when we are in subRoutes.
      actions: [
        // To hide the native endDrawer icon we must populate actions, I will just use a SizedBox.shrink() to minimize the space used.
        SizedBox.shrink(),
      ],
      titleSpacing: 0, // This remove the horizontal padding of the title.
      title: LayoutBuilder(
        builder: (context, constraints) {
          // TODO: make this automatic, I didn't succed. I tried to do it in 2 different ways, using the overflow of SingleChildScrollView, using MultiChildLayoutDelegate.
          final bool isLandscape = constraints.maxWidth > 1200;
          return Row(
            children: [
              if (!isLandscape && useDrawerInsteadOfEndDrawer)
                IconButton(
                  onPressed: () => scaffoldKey.currentState!.openDrawer(),
                  icon: const Icon(Icons.menu),
                ),
              SizedBox(
                // This represents the logo.
                height: 30,
                width: 70,
                child: Placeholder(),
              ),
              isLandscape
                  ? NavigationWeb(
                      items: almightyGetDestinations(
                              navigationLayout: NavigationLayout.webNavigation)
                          .where((destination) => destination.isVisible)
                          .map((destination) =>
                              destination.destinationWidget!(context))
                          .toList()
                          .cast<WebNavigationDestination>(),
                      currentIndex: navigationShell.currentIndex,
                      onTap: _goToBranch,
                      spacingStyle: SpacingStyle.centered,
                    )
                  : const Spacer(),
              if (isLandscape) PieMenuAppSettings(),
              if (!isLandscape && !useDrawerInsteadOfEndDrawer)
                IconButton(
                  onPressed: () => scaffoldKey.currentState!.openEndDrawer(),
                  icon: const Icon(Icons.menu),
                ),
            ],
          );
        },
      ),
    );
  }

  /// So [_buildBodyAndNavigationRail] builds the body of the app. In Flutter, for now, we don't have a proper way to integrate [NavigationRail] so we need to do it like this.
  /// The method either returns only the body or a [Row] were the [NavigationRail] is on the left and the body on the right and these two are separated by a [VerticalDivider].
  ///
  /// When it returns only the body there's an if statement that checks if it's being executed on the web because for desktop and mobile (execpt the [NavigationRail] thing) the body is the same,
  /// only in the web version there's a [Footer] widget at the bottom of the screen.
  ///
  Widget _buildBodyAndNavigationRail({
    required BuildContext context,
  }) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return isLandscape && !kIsWeb
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NavigationRail(
                destinations: almightyGetDestinations(
                        navigationLayout: NavigationLayout.navigationRail)
                    .where((destination) => destination.isVisible)
                    .map((destination) =>
                        destination.destinationWidget!(context))
                    .toList()
                    .cast<NavigationRailDestination>(),
                selectedIndex: navigationShell.currentIndex,
                labelType: NavigationRailLabelType.all,
                onDestinationSelected: _goToBranch,
              ),
              const VerticalDivider(
                width: 1,
              ),
              Expanded(
                child: SingleChildScrollView(child: navigationShell),
              ),
            ],
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      navigationShell,
                      if (kIsWeb)
                        SizedBox(
                          // This is where the footer is supposed to go.
                          width: double.infinity,
                          height: 50,
                          child: const Placeholder(),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
  }

  /// So [_buildBottomNavigationBar] builds the bottom navigation bar, duh.
  /// Really, it just returns [BottomNavigationBar] if the orientation is portrait.
  /// Also this method is not used on the web.
  ///
  BottomNavigationBar? _buildBottomNavigationBar({
    required BuildContext context,
  }) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return isLandscape
        ? null
        : BottomNavigationBar(
            items: almightyGetDestinations(
                    navigationLayout: NavigationLayout.bottomNavigation)
                .where((destination) => destination.isVisible)
                .map((destination) => destination.destinationWidget!(context))
                .toList()
                .cast<BottomNavigationBarItem>(),
            currentIndex: navigationShell.currentIndex,
            onTap: _goToBranch,
          );
  }

  /// So [_buildDrawerOrEndDrawer] builds either a drawer or an endDrawer based on the value of [useDrawerInsteadOfEndDrawer].
  /// There's not much to explain here. Maybe just the fact that both of the drawers are built in the same way
  /// and we see again the cool [PieMenuAppSettings] widget.
  ///
  NavigationDrawer _buildDrawerOrEndDrawer({
    required BuildContext context,
    required GlobalKey<ScaffoldState> scaffoldKey,
  }) {
    return NavigationDrawer(
      tilePadding: const EdgeInsets.symmetric(vertical: 3, horizontal: 12),
      onDestinationSelected: _goToBranch,
      selectedIndex: navigationShell.currentIndex,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 3, right: 3, bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const PieMenuAppSettings(),
              IconButton(
                onPressed: () => useDrawerInsteadOfEndDrawer
                    ? scaffoldKey.currentState!.closeDrawer()
                    : scaffoldKey.currentState!.closeEndDrawer(),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
        ),
        ...almightyGetDestinations(
                navigationLayout: NavigationLayout.navigationDrawer)
            .where((destination) => destination.isVisible)
            .map((destination) => destination.destinationWidget!(context))
            .cast<NavigationDrawerDestination>(),
      ],
    );
  }

  // #endregion
}
