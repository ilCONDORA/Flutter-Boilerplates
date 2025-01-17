import 'package:flutter/material.dart';

import 'web_navigation_destination.dart';

/// [SpacingStyle] is an enum that represents the spacing style for the navigation items.
///
/// It can be either [attachedToLeft] or [centered].
///
/// When [attachedToLeft] is used the navigation items are attached to the left of the screen, in case after the logo.
///
/// When [centered] is used the navigation items are centered.
enum SpacingStyle { attachedToLeft, centered }

/// [NavigationWeb] is a widget responsible for building the navigation items, which are represented by [WebNavigationDestination].
///
/// The properties are:
/// - [items] is the list of navigation items, represented by [WebNavigationDestination].
/// - [currentIndex] is the index of the current navigation item.
/// - [onTap] is the callback that is called when a navigation item is tapped.
/// - [spacingStyle] is the spacing style for the navigation items.
/// - [horizontalPadding] is the horizontal padding for the navigation items.
/// - [verticalPadding] is the vertical padding for the navigation items.
class NavigationWeb extends StatelessWidget {
  const NavigationWeb({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    required this.spacingStyle,
    this.horizontalPadding = 8.0,
    this.verticalPadding = 4.0,
  });

  final List<WebNavigationDestination> items;
  final int currentIndex;
  final Function(int) onTap;
  final SpacingStyle spacingStyle;
  final double horizontalPadding;
  final double verticalPadding;

  @override
  Widget build(BuildContext context) {
    // Filtriamo gli items e manteniamo gli indici originali
    final filteredItemsWithIndices =
        items.asMap().entries.where((entry) => entry.value.isVisible).toList();

    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        child: Row(
          mainAxisAlignment: spacingStyle == SpacingStyle.attachedToLeft
              ? MainAxisAlignment.start
              : MainAxisAlignment.spaceEvenly,
          children: [
            for (final entry in filteredItemsWithIndices)
              entry.value.build(
                context,
                isSelected: entry.key == currentIndex,
                onPressed: () => onTap(entry.key),
              ),
            if (spacingStyle == SpacingStyle.centered) const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
