import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/header/header_bar.dart';
import '../../widgets/navigation/builder_navigation_text_buttons.dart';
import '../../widgets/navigation/logo_navbar_home_navigation.dart';
import '../../widgets/settings_buttons.dart';
import '../../widgets/web_nav_bar.dart';
import 'custom_navigation_destination.dart';

/// [ScaffoldWithHeaderNavbarAndDrawer] is responsible for the creation of the scaffold.
///
/// In the appbar a custom [AppBar] is created and it will contain a [HeaderBar] and a [WebNavBar].
/// It will also contain a [Drawer].
///
/// It's responsive to the size of the screen. By using the boolean [brakePoint] it will show different widgets.
///
/// It takes the following parameters:
/// - [navigationShell]: The navigation shell of the app.
/// - [destinations]: The list of destinations of the app.
class ScaffoldWithHeaderNavbarAndDrawer extends StatelessWidget {
  const ScaffoldWithHeaderNavbarAndDrawer({
    super.key,
    required this.navigationShell,
    required this.destinations,
  });

  final StatefulNavigationShell navigationShell;
  final List<CustomNavigationDestination> destinations;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool brakePoint = constraints.maxWidth < 900;
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: brakePoint ? 80 : 125,
            excludeHeaderSemantics: true,
            titleSpacing: 0.0,
            flexibleSpace: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!brakePoint) const HeaderBar(),
                WebNavBar(
                  navigationShell: navigationShell,
                  destinations: destinations,
                  brakePoint: brakePoint,
                ),
              ],
            ),
          ),
          drawer: Drawer(
            child: ListView(
              children: [
                DrawerHeader(
                  child: Center(
                    child: LogoNavBarHomeNavigation(
                      width: 240,
                      navigationShell: navigationShell,
                      destinationIndex: destinations.indexWhere(
                        (d) => d.name.contains('home'),
                      ),
                      burger: true,
                    ),
                  ),
                ),
                const SettingsButtons(
                  burger: true,
                ),
                const Divider(),
                const SizedBox(
                  height: 8,
                ),
                BuilderNavigationTextButtons(
                  navigationShell: navigationShell,
                  destinations: destinations,
                  buttonsToTheLeft: false,
                  burger: true,
                ),
              ],
            ),
          ),
          body: navigationShell,
        );
      },
    );
  }
}
