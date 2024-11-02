import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// [LogoNavBarHomeNavigation] is responsible for the creation of the logo in the navbar.
/// It takes the following parameters:
/// - [navigationShell]: The navigation shell of the app.
/// - [destinationIndex]: The index of the destination in the [navigationShell].
/// - [width]: The width of the logo.
/// - [burger]: A boolean value used to show different widgets.
class LogoNavBarHomeNavigation extends StatelessWidget {
  const LogoNavBarHomeNavigation({
    super.key,
    required this.navigationShell,
    required this.destinationIndex,
    required this.width,
    this.burger = false,
  });

  final StatefulNavigationShell navigationShell;
  final int destinationIndex;
  final double width;
  final bool burger;

  @override
  Widget build(BuildContext context) {
    bool isSelected = navigationShell.currentIndex == destinationIndex;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          if (!isSelected) {
            navigationShell.goBranch(destinationIndex);
          }
          if (burger) {
            Navigator.of(context).pop();
          }
        },
        child: Tooltip(
          waitDuration: const Duration(seconds: 2),
          message: AppLocalizations.of(context)!.tooltip_logo_navigation,
          child: CachedNetworkImage(
            width: width,
            imageUrl:
                'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c6/Twitch_logo_%28wordmark_only%29.svg/2560px-Twitch_logo_%28wordmark_only%29.svg.png',
          ),
        ),
      ),
    );
  }
}
