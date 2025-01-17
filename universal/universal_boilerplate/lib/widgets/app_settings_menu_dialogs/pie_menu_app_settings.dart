import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pie_menu/pie_menu.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../blocs/app_settings/app_settings_bloc.dart';
import 'language_currency_selector_dialog.dart';

/// [PieMenuAppSettings] is the widget responsible for the display of the circular menu
/// which show buttons to open the respective settings dialog.
///
/// It uses the pie_menu package and in the [PieMenu] we pass iconsto be displayed by using [PieAction],
/// [PieAction] represent an [Icon] as a button with a [tooltip] and an [onSelect] function to be called when the button is pressed.
///
/// The theme changer button is the only one that changes it's icon based on the current theme,
/// that's why [PieMenu] is wrapped in a [BlocBuilder] to listen to changes in the [AppSettingsBloc].
/// 
class PieMenuAppSettings extends StatelessWidget {
  const PieMenuAppSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppSettingsBloc, AppSettingsState>(
      builder: (context, state) {
        return PieMenu(
          actions: [
            PieAction(
              tooltip:
                  Text(AppLocalizations.of(context)!.tooltip_language_settings),
              onSelect: () => showDialog(
                context: context,
                builder: (context) => const LanguageCurrencySelectorDialog(
                  dialogType: DialogType.language,
                ),
              ),
              child: Icon(Icons.translate_rounded),
            ),
            PieAction(
              tooltip:
                  Text(AppLocalizations.of(context)!.tooltip_currency_settings),
              onSelect: () => showDialog<void>(
                context: context,
                builder: (context) => const LanguageCurrencySelectorDialog(
                  dialogType: DialogType.currency,
                ),
              ),
              child: Icon(Icons.currency_exchange_rounded),
            ),
            PieAction(
              tooltip: Text(AppLocalizations.of(context)!.tooltip_change_theme),
              onSelect: () => context.read<AppSettingsBloc>().add(
                    ChangeAppSettings(
                      appSettingsModel: state.appSettingsModel.copyWith(
                        themeMode:
                            state.appSettingsModel.themeMode == ThemeMode.light
                                ? ThemeMode.dark
                                : ThemeMode.light,
                      ),
                    ),
                  ),
              child: Icon(
                state.appSettingsModel.themeMode == ThemeMode.light
                    ? Icons.light_mode_rounded
                    : Icons.dark_mode_rounded,
                color: state.appSettingsModel.themeMode == ThemeMode.light
                    ? Colors.amber
                    : Colors.grey.shade300,
              ),
            ),
          ],
          child: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.settings,
            ),
          ),
        );
      },
    );
  }
}
