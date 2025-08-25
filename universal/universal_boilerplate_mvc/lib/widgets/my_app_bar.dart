import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/pop_route/pop_route_cubit.dart';
import '../navigation/routes_declaration.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

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
      color: Colors.blue,
      child: BlocBuilder<PopRouteCubit, bool>(
        builder:
            (context, state) => Row(
              spacing: 8,
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  iconAlignment: IconAlignment.start,
                  label: const Text('Menu'),
                  icon: const Icon(Icons.menu),
                ),
                if (state)
                  BackButton(
                    onPressed: () {
                      context.read<PopRouteCubit>().updateCanPop(false);
                      GoRouter.of(context).pop();
                    },
                  ),
                Text('${GoRouter.of(context).state.name}'),
                SizedBox(width: 16),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      isRouteActive(homeLocation, currentLocation)
                          ? Colors.red
                          : null,
                    ),
                  ),
                  onPressed:
                      () =>
                          GoRouter.of(context).goNamed(DefinedRoutesNames.home),
                  child: const Text('Home'),
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
                      () => GoRouter.of(
                        context,
                      ).goNamed(DefinedRoutesNames.tasks),
                  child: const Text('Tasks'),
                ),
              ],
            ),
      ),
    );
  }
}
