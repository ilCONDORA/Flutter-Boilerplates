import 'package:flutter/material.dart';

import 'go_back_button.dart';

/// This class is used to build the app bar without a scaffold.
///
/// The properties are:
/// - [title] is the title of the app bar.
/// - [showBackButton] is a boolean that determines if the back button should be shown.
class AppBarWithoutScaffold extends StatelessWidget {
  const AppBarWithoutScaffold({
    super.key,
    required this.title,
    required this.showBackButton,
  });

  final Widget? title;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56, // 56 is the default height of the AppBar
      child: Row(
        children: [
          if (showBackButton) const GoBackButton(),
          if (title != null) title!,
        ],
      ),
    );
  }
}
