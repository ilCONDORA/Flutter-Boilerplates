import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../config/navigation/custom_navigation_destination.dart';
import 'navigation_text_button.dart';

/// [BuilderNavigationTextButtons] is responsible for the creation of the buttons in the navbar.
/// It takes the following parameters:
/// - [navigationShell]: The navigation shell of the app.
/// - [destinations]: The list of destinations of the app.
/// - [buttonsToTheLeft]: A boolean value used to determine whether the buttons should be placed to the left or to the center of the navbar.
/// - [burger]: A boolean value used to show different widgets.
///
/// It builds [NavigationTextButton] for each destination in the [destinations] list.
class BuilderNavigationTextButtons extends StatelessWidget {
  const BuilderNavigationTextButtons({
    super.key,
    required this.navigationShell,
    required this.destinations,
    required this.buttonsToTheLeft,
    this.burger = false,
  });

  final StatefulNavigationShell navigationShell;
  final List<CustomNavigationDestination> destinations;
  final bool buttonsToTheLeft;
  final bool burger;

  @override
  Widget build(BuildContext context) {
    if (burger) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < destinations.length; i++)
            if (destinations[i].showAsTab)
              NavigationTextButton(
                navigationShell: navigationShell,
                destination: destinations[i],
                index: i,
                burger: true,
              ),
        ],
      );
    } else {
      return Expanded(
        child: Row(
          mainAxisAlignment: buttonsToTheLeft
              ? MainAxisAlignment.start
              : MainAxisAlignment.spaceEvenly,
          children: [
            for (int i = 0; i < destinations.length; i++)
              if (destinations[i].showAsTab)
                NavigationTextButton(
                  navigationShell: navigationShell,
                  destination: destinations[i],
                  index: i,
                ),
            if (!buttonsToTheLeft) const SizedBox.shrink(),
          ],
        ),
      );
    }
  }
}
