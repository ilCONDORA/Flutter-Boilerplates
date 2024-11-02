import 'package:flutter/material.dart';

import 'header/menu_currency_selector.dart';
import 'header/menu_language_selector.dart';
import 'header/theme_segmented_button.dart';

/// [SettingsButtons] is responsible for the creation of the settings buttons.
/// It takes the following parameters:
/// - [burger]: A boolean value used to show different widgets.
///
/// Based on the value of [burger], if it's true then it will show the [ThemeSegmentedButton], [MenuCurrencySelector] and [MenuLanguageSelector] in a column, otherwise it will show them in a row.
class SettingsButtons extends StatelessWidget {
  const SettingsButtons({
    super.key,
    required this.burger,
  });

  final bool burger;

  @override
  Widget build(BuildContext context) {
    const List<Widget> children = [
      ThemeSegmentedButton(),
      SizedBox(width: 8),
      MenuCurrencySelector(),
      SizedBox(width: 8),
      MenuLanguageSelector(),
    ];

    if (burger) {
      return const Column(
        mainAxisSize: MainAxisSize.min,
        children: children,
      );
    } else {
      return const Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: children,
      );
    }
  }
}
