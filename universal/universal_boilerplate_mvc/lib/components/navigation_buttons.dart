import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../navigation/layout_dispatcher.dart';

class NavigationButtons extends StatelessWidget {
  const NavigationButtons({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  static final List<NavigationItemModel> navigationItems = [
    NavigationItemModel(icon: Icons.home, text: 'Home'),
    NavigationItemModel(icon: Icons.list, text: 'Active'),
    NavigationItemModel(icon: Icons.archive, text: 'Archive'),
  ];

  @override
  Widget build(BuildContext context) {
    return GNav(
      tabBorderRadius: 16,
      padding: EdgeInsets.all(12),
      tabActiveBorder: Border.all(color: Colors.black),
      tabBorder: Border.all(color: Colors.grey),
      tabs:
          navigationItems
              .map((item) => GButton(icon: item.icon, text: item.text))
              .toList(),
      selectedIndex: navigationShell.currentIndex,
      onTabChange: navigationShell.goBranch,
    );
  }
}
