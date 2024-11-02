import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../config/navigation/custom_navigation_destination.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// [NavigationTextButton] is responsible for the creation of the single button in the navbar.
/// It takes the following parameters:
/// - [navigationShell]: The navigation shell of the app.
/// - [destination]: The destination of the app.
/// - [index]: The index of the destination in the [navigationShell].
/// - [burger]: A boolean value used to show different widgets.
class NavigationTextButton extends StatefulWidget {
  const NavigationTextButton({
    super.key,
    required this.navigationShell,
    required this.destination,
    required this.index,
    this.burger = false,
  });

  final StatefulNavigationShell navigationShell;
  final CustomNavigationDestination destination;
  final int index;
  final bool burger;

  @override
  State<NavigationTextButton> createState() => _NavigationTextButtonState();
}

class _NavigationTextButtonState extends State<NavigationTextButton> {
  bool isHovering = false;

  bool get isSelected => widget.navigationShell.currentIndex == widget.index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Tooltip(
        waitDuration: const Duration(seconds: 2),
        message: AppLocalizations.of(context)!.tooltip_navigation_button(
            widget.destination.labelBuilder!(context)),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => isHovering = true),
          onExit: (_) => setState(() => isHovering = false),
          child: GestureDetector(
            onTap: () {
              if (!isSelected) {
                widget.navigationShell.goBranch(widget.index);
              }
              if (widget.burger) {
                Navigator.of(context).pop();
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected || isHovering
                    ? Colors.white.withOpacity(0.3)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                widget.destination.labelBuilder!(context),
                style: TextStyle(
                  fontSize: 18,
                  fontStyle: isSelected ? FontStyle.italic : FontStyle.normal,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
