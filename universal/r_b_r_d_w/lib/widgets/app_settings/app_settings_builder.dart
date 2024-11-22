import 'package:flutter/material.dart';

import 'menu_language_selector.dart';
import 'theme_segmented_button.dart';

/// [AppSettingsBuilder] is responsible for the creation of the app settings.
///
/// The propertie is [direction] which is used to determine what widget to use.
/// [direction] can be [Axis.horizontal] or [Axis.vertical] and this is used 
/// to determine what widget to use, either a [Row] or a [Column].
class AppSettingsBuilder extends StatelessWidget {
  const AppSettingsBuilder({
    super.key,
    required this.direction,
  });

  final Axis direction;

  static final List<Widget> _settingWidgets = [
    const ThemeSegmentedButton(),
    const MenuLanguageSelector(),
  ];

  @override
  Widget build(BuildContext context) {
    final settingWidgets =
        _settingWidgets.map((settings) => FittedBox(child: settings)).toList();

    // !! don't change it to a Wrap widget because the dimensions of the childrens are slightly smaller
    return switch (direction) {
      Axis.horizontal => Row(
          mainAxisSize: MainAxisSize.min,
          children: settingWidgets,
        ),
      Axis.vertical => Column(
          mainAxisSize: MainAxisSize.min,
          children: settingWidgets,
        ),
    };
  }
}
