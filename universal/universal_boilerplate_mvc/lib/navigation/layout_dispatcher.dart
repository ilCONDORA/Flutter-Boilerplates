import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../components/navigation_buttons.dart';

/// Class used just to create the navigation items
///
class NavigationItemModel {
  final IconData icon;
  final String text;

  NavigationItemModel({required this.icon, required this.text});
}

/// [LayoutDispatcher] is the 'big guy', this widget is responsible for:
/// - Dynamically rendering the arrow back button in the app bar
/// - Rendering the bottom navigation bar
/// - Rendering the side navigation bar
/// - Rendering the app bar
/// - Rendering the pages
/// I also have to mantion that we use [navigationShell] and [GoRouter] to
/// navigate between the pages.
///
class LayoutDispatcher extends StatelessWidget {
  const LayoutDispatcher({
    super.key,
    required this.navigationShell,
    required this.child,
  });

  final StatefulNavigationShell navigationShell;
  final Widget child;

  static const webAppBarHeight = 60.0;

  @override
  Widget build(BuildContext context) {
    // This is one way to determine if the current route can be popped.
    // It checks if the current URI has more than one '/'.
    // It's used to conditionally show the back button in the app bar.
    final bool canPop =
        '/'.allMatches(GoRouterState.of(context).uri.toString()).length != 1;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(webAppBarHeight),
        child: Container(
          color: Colors.blue,
          padding: EdgeInsets.all(4),
          height: webAppBarHeight,
          child: Row(
            children: [
              Visibility(
                visible: canPop,
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => GoRouter.of(context).pop(),
                ),
              ),
              Expanded(
                child: NavigationButtons(navigationShell: navigationShell),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: NavigationButtons(navigationShell: navigationShell),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            IntrinsicHeight(
              // By using this the height of the side navigation is determined by the child.
              child: Row(
                children: [
                  Container(
                    width: 200,
                    color: Colors.amber,
                    child: Column(children: [Text('Side Navigation')]),
                  ),
                  VerticalDivider(width: 1, thickness: 1),
                  Expanded(child: child),
                ],
              ),
            ),
            Container(
              height: 200,
              color: Colors.teal,
              child: Center(child: const Text("Footer")),
            ),
          ],
        ),
      ),
    );
  }
}
