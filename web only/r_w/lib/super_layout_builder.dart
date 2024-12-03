import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'widgets/app_settings/app_settings_builder.dart';
import 'widgets/footer.dart';
import 'widgets/logo_navigation.dart';
import 'widgets/web_navigation/navigation_web.dart';
import 'widgets/web_navigation/web_navigation_destination.dart';
import 'config/routes.dart';

/// [NavigationLayouts] is an enum that represents the layout of the navigation.
///
/// It can be either [onlyBottomAndRail] or [onlyEndDrawer] or [everythingTogether].
///
/// [onlyBottomAndRail] will create only a bottom navigation bar and a navigation rail.
///
/// [onlyEndDrawer] will create only an end drawer.
///
/// [everythingTogether] will create a bottom navigation bar, a navigation rail and an end drawer.
enum NavigationLayouts { onlyBottomAndRail, onlyEndDrawer, everythingTogether }

/// [SuperLayoutBuilder] is the widget responsible for building the layout of the app.
///
/// It's named like this because it creates different layouts depending on the value
/// of [navigationLayout], the orientation of the device and also if it's web.
///
/// The properties are:
/// - [navigationShell] is the navigation shell that is used to navigate between the different routes.
/// - [navigationLayout] is the layout of the navigation.
///
/// This widget is used in [routes.dart].
class SuperLayoutBuilder extends StatelessWidget {
  const SuperLayoutBuilder({
    Key? key,
    required this.navigationShell,
    required this.navigationLayout,
  }) : super(key: key ?? const ValueKey('SuperLayoutBuilder'));

  final StatefulNavigationShell navigationShell;
  final NavigationLayouts navigationLayout;

  /// This method is used to navigate to the different branches of the navigation shell.
  ///
  /// It accepts an [index] which is the index of the branch to navigate to.
  void _goToBranch(int index) {
    navigationShell.goBranch(
      index,
      // A common pattern when using navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This is how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  /// This method is used to build the app bar.
  ///
  /// The properties are:
  /// - [context] is the context of the widget.
  /// - [orientation] is the orientation of the device.
  /// - [scaffoldKey] is the key of the scaffold.
  ///
  /// It returns a different app bar depending if it's web or not and depending on the value of [navigationLayout].
  /// Ther's also a funny error [AppBar].
  ///
  /// Inside there's also a hack to hide the native endDrawer icon.
  AppBar? _buildAppBar({
    required BuildContext context,
    required Orientation orientation,
    required GlobalKey<ScaffoldState> scaffoldKey,
  }) {
    if (kIsWeb) {
      return AppBar(
        elevation: 1,
        toolbarHeight: orientation == Orientation.landscape
            ? 100
            : 56, // 56 is the default value
        automaticallyImplyLeading: false,
        actions: const [
          SizedBox.shrink()
        ], // !! To hide the native endDrawer icon we must use populate actions, I will put just a SizedBox.shrink()
        flexibleSpace: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            orientation == Orientation.landscape
                ? Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    color: Colors.grey.shade900,
                    height: 35,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AppSettingsBuilder(
                          direction: Axis.horizontal,
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
            Row(
              children: [
                const SizedBox(width: 8),
                const LogoNavigation(
                  namedRoute: 'home',
                  height: 50,
                ),
                if (orientation == Orientation.landscape)
                  NavigationWeb(
                    items: getDestinations(navigationType: NavigationType.web)
                        .where((destination) => destination.isVisible)
                        .map((destination) =>
                            destination.navigationWidget(context))
                        .toList()
                        .cast<WebNavigationDestination>(),
                    currentIndex: navigationShell.currentIndex,
                    onTap: _goToBranch,
                    spacingStyle: SpacingStyle.centered,
                  ),
                if (orientation == Orientation.portrait) const Spacer(),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        print('Andiamo all\' account');
                      },
                      icon: const Icon(Icons.account_circle),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    orientation == Orientation.portrait
                        ? IconButton(
                            onPressed: () =>
                                scaffoldKey.currentState!.openEndDrawer(),
                            icon: const Icon(Icons.menu),
                          )
                        : const SizedBox.shrink(),
                    const SizedBox(
                      width: 8,
                    ),
                  ],
                )
              ],
            ),
            const SizedBox
                .shrink(), // !! This is important because with the use of MainAxisAlignment.spaceBetween of the Column and SizedBox.shrink() the position of the NavigationBar will be always centered
          ],
        ),
      );
    } else {
      return null;
    }
  }

  /// This method is used to build the body of the app.
  ///
  /// The properties are:
  /// - [context] is the context of the widget.
  /// - [orientation] is the orientation of the device.
  ///
  /// It returns a different body depending if it's web or not and depending on the value of [navigationLayout].
  Widget _buildBody({
    required BuildContext context,
    required Orientation orientation,
  }) {
    // !! It's important to use Row and Expanded here because with them it occupies all the space available
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                navigationShell,
                const Footer(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// This method is used to build the bottom navigation bar.
  ///
  /// The properties are:
  /// - [context] is the context of the widget.
  /// - [orientation] is the orientation of the device.
  ///
  /// [BottomNavigationBar] will be built only if [orientation] is [Orientation.portrait]
  /// and [navigationLayout] is not [NavigationLayouts.onlyEndDrawer] and [kIsWeb] is false.
  BottomNavigationBar? _buildBottomNavigationBar({
    required BuildContext context,
    required Orientation orientation,
  }) {
    return null;
  }

  /// This method is used to build the end drawer.
  ///
  /// The properties are:
  /// - [context] is the context of the widget.
  /// - [scaffoldKey] is the key of the scaffold.
  ///
  /// [NavigationDrawer] will be built only if [navigationLayout] is not [NavigationLayouts.onlyBottomAndRail] or [kIsWeb] is true.
  NavigationDrawer? _buildEndDrawer({
    required BuildContext context,
    required GlobalKey<ScaffoldState> scaffoldKey,
  }) {
    if (kIsWeb) {
      return NavigationDrawer(
        tilePadding: const EdgeInsets.symmetric(vertical: 3, horizontal: 12),
        onDestinationSelected: _goToBranch,
        selectedIndex: navigationShell.currentIndex,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () => scaffoldKey.currentState!.closeEndDrawer(),
                  icon: const Icon(Icons.close),
                ),
              ),
            ],
          ),
          ...getDestinations(navigationType: NavigationType.drawer)
              .where((destination) => destination.isVisible)
              .map((destination) => destination.navigationWidget(context))
              .cast<NavigationDrawerDestination>(),
          const Divider(
            height: 30,
          ),
          const Text('Settings'),
          const AppSettingsBuilder(
            direction: Axis.vertical,
          ),
        ],
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return OrientationBuilder(
      builder: (context, orientation) {
        return Scaffold(
          key: scaffoldKey,
          appBar: _buildAppBar(
            context: context,
            orientation: orientation,
            scaffoldKey: scaffoldKey,
          ),
          body: _buildBody(
            context: context,
            orientation: orientation,
          ),
          bottomNavigationBar: _buildBottomNavigationBar(
            context: context,
            orientation: orientation,
          ),
          endDrawer: _buildEndDrawer(
            context: context,
            scaffoldKey: scaffoldKey,
          ),
        );
      },
    );
  }
}
