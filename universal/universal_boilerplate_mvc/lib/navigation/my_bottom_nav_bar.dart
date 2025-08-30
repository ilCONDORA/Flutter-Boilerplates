import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'routes_declaration.dart';

class MyBottomNavBar extends StatelessWidget {
  const MyBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    // Get current location, will be updated when navigating.
    String currentLocation = GoRouter.of(context).state.matchedLocation;

    // Get locations from name of routes.
    String homeLocation = GoRouter.of(
      context,
    ).configuration.namedLocation(DefinedRoutesNames.home);
    String tasksLocation = GoRouter.of(
      context,
    ).configuration.namedLocation(DefinedRoutesNames.tasks);

    /// Method used to check and return a boolean value that represents
    /// if we are in the base route or not based on the current route location and base route.
    ///
    bool isRouteActive(String routeLocation, String currentLocation) {
      // For the home route, check if the current route location is the same, because home is only '/'.
      if (routeLocation == homeLocation) {
        return currentLocation == routeLocation;
      }
      // For every other route, check if the current route location starts with the base route.
      return currentLocation.startsWith(routeLocation);
    }

    return Container(
      color: Colors.green,
      child: Row(
        children: [
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(
                isRouteActive(homeLocation, currentLocation)
                    ? Colors.red
                    : null,
              ),
            ),
            onPressed:
                () => GoRouter.of(context).goNamed(DefinedRoutesNames.home),
            child: const Text(DefinedRoutesNames.home),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(
                isRouteActive(tasksLocation, currentLocation)
                    ? Colors.red
                    : null,
              ),
            ),
            onPressed:
                () => GoRouter.of(context).goNamed(DefinedRoutesNames.tasks),
            child: const Text(DefinedRoutesNames.tasks),
          ),
        ],
      ),
    );
  }
}
