import 'package:flutter/material.dart';

/// [CustomNavigationDestination] is responsible for the creation of the destination in the app.
///
/// It takes the following parameters:
/// - [path]: The path of the destination.
/// - [name]: The name of the destination.
/// - [labelBuilder]: A function that returns the label of the destination, used with context and AppLocalizations, like this: (context) => AppLocalizations.of(context)!.localizedString.
/// - [screen]: The screen of the destination.
/// - [showAsTab]: A boolean value used to determine whether the destination should be shown as a tab in the navbar.
class CustomNavigationDestination {
  final String path;
  final String name;
  final String Function(BuildContext)?
      labelBuilder; // Nuovo campo per la localizzazione
  final Widget screen;
  final bool showAsTab;

  const CustomNavigationDestination({
    required this.path,
    required this.name,
    this.labelBuilder,
    this.screen = const Placeholder(),
    required this.showAsTab,
  });
}
