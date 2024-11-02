import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../config/navigation/custom_navigation_destination.dart';
import 'navigation/builder_navigation_text_buttons.dart';
import 'navigation/logo_navbar_home_navigation.dart';

/// [WebNavBar] is responsible for the creation of the navbar in the web version.
/// It takes the following parameters:
/// - [navigationShell]: The navigation shell of the app.
/// - [destinations]: The list of destinations of the app.
/// - [brakePoint]: A boolean value used to show different widgets.
///
/// Based on the value of [brakePoint], if it's true then it will show a burger button to open the [Drawer] and will hide the [BuilderNavigationTextButtons].
class WebNavBar extends StatelessWidget {
  const WebNavBar({
    super.key,
    required this.navigationShell,
    required this.destinations,
    required this.brakePoint,
  });

  final StatefulNavigationShell navigationShell;
  final List<CustomNavigationDestination> destinations;
  final bool brakePoint;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            if (brakePoint)
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Tooltip(
                  waitDuration: const Duration(seconds: 2),
                  message: AppLocalizations.of(context)!.tooltip_open_side_menu,
                  child: IconButton(
                    onPressed: () => Scaffold.of(context).openDrawer(),
                    icon: const Icon(Icons.menu),
                  ),
                ),
              ),
            LogoNavBarHomeNavigation(
              width: 150,
              navigationShell: navigationShell,
              destinationIndex: destinations.indexWhere(
                (d) => d.name.contains('home'),
              ),
            ),
            brakePoint
                ? const Spacer()
                : BuilderNavigationTextButtons(
                    navigationShell: navigationShell,
                    destinations: destinations,
                    buttonsToTheLeft: false,
                  ),
          ],
        ),
      ),
    );
  }
}
