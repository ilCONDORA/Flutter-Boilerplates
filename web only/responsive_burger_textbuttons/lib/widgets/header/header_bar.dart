import 'package:flutter/material.dart';

import '../settings_buttons.dart';

/// [HeaderBar] is responsible for the creation of the header in the app.
///
/// It returns a [Container] widget with a [SettingsButtons] widget as a child.
class HeaderBar extends StatelessWidget {
  const HeaderBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      color: Colors.black87,
      child: const SettingsButtons(burger: false),
    );
  }
}
