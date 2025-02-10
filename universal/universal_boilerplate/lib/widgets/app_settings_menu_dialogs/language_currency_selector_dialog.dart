import 'package:currency_formatter/currency_formatter.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../blocs/app_settings/app_settings_bloc.dart';
import '../../l10n/l10n.dart';

/// [DialogType] enum is used to distinguish between different types of dialogs,
/// for now it's only used to distinguish between language and currency selection dialogs.
enum DialogType { language, currency }

/// [LanguageCurrencySelectorDialog] as the name suggests is a dialog that allows the user to select a language or a currency.
/// This dialog is opened by clicking on the language or currency settings button inside [PieMenuAppSettings].
///
/// The [AlertDialog] is inside a [BlocBuilder] to listen to changes in the [AppSettingsBloc] and update the UI accordingly.
///
/// The first thing it does is to get the list of supported locales from the [L10n] class based on the [DialogType].
/// Then it builds a [Wrap] widget with the list of locales, each locale is represented by a [Container] with a [Flag] and the name of the language or currency.
/// Each item is built by the [_buildLocaleItem] method.
///
class LanguageCurrencySelectorDialog extends StatelessWidget {
  const LanguageCurrencySelectorDialog({super.key, required this.dialogType});
  final DialogType dialogType;

  @override
  Widget build(BuildContext context) {
    final locales = dialogType == DialogType.language
        ? L10n.supportedLocalesLanguages
        : L10n.supportedLocalesCurrencies;

    return BlocBuilder<AppSettingsBloc, AppSettingsState>(
      builder: (context, state) {
        return AlertDialog(
          title: _buildTitle(context: context, state: state),
          content: SizedBox(
            width: 1000,
            child: Wrap(
              spacing: 20,
              runSpacing: 20,
              alignment: WrapAlignment.center,
              children: locales
                  .map((locale) => _buildLocaleItem(
                        context,
                        state,
                        locale,
                      ))
                  .toList(),
            ),
          ),
          actions: [
            TextButton(
              child: Text(AppLocalizations.of(context)!.exit),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  /// [_buildLocaleItem] is a method that builds a [Container] with a [Flag] and the name of the language or currency.
  /// The [Container] is wrapped in a [GestureDetector] to make it clickable and also a [MouseRegion] to change the cursor.
  ///
  /// The [isSelected] variable is used to set the border color of the [Container] based on the current selected locale.
  /// The const [flagSize] is used to set the size of the flag, it's mainly the height and it's also used to calculate the width.
  ///
  /// In the case of an unsupported locale, the [Flag] widget will display a text with the message "Flag not found".
  ///
  Widget _buildLocaleItem(
      BuildContext context, AppSettingsState state, Locale locale) {
    final isSelected = dialogType == DialogType.language
        ? state.appSettingsModel.localeLanguage == locale
        : state.appSettingsModel.localeCurrency == locale;

    const double flagSize = 80;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => context.read<AppSettingsBloc>().add(
              ChangeAppSettings(
                appSettingsModel: state.appSettingsModel.copyWith(
                  localeLanguage:
                      dialogType == DialogType.language ? locale : null,
                  localeCurrency:
                      dialogType == DialogType.currency ? locale : null,
                ),
              ),
            ),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? Colors.amber : Colors.white,
              width: 2,
            ),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flag.fromString(
                locale.countryCode?.isNotEmpty == true
                    ? locale.countryCode!
                    : 'flag_not_found',
                height: flagSize,
                width: flagSize * 4 / 3,
                replacement: Text(AppLocalizations.of(context)!.flag_not_found),
              ),
              const SizedBox(height: 12),
              Text(
                dialogType == DialogType.language
                    ? lookupAppLocalizations(locale).language
                    : CurrencyFormatter.format(
                        9.99,
                        CurrencyFormat.fromLocale(locale.toString())!,
                      ),
                style: const TextStyle(fontSize: 18),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// [_buildTitle] is a method that builds the title of the [AlertDialog] based on the [DialogType].
  /// This method can be omitted and the title can be built directly in the [AlertDialog] widget,
  /// but I prefer to keep it in case I need to debug it, as shown in the commented code.
  ///
  Widget _buildTitle(
      {required BuildContext context, required AppSettingsState state}) {
    if (dialogType == DialogType.language) {
      //return Text('Select Language - ${state.appSettingsModel.localeLanguage}');
      return Text(AppLocalizations.of(context)!.title_language_settings);
    } else if (dialogType == DialogType.currency) {
      /* final currencyFormat = CurrencyFormat.fromLocale(
        state.appSettingsModel.localeCurrency.toString(),
      )!;
      return Text(
        'Select Currency - ${currencyFormat.symbol} - ${state.appSettingsModel.localeCurrency}',
      ); */
      return Text(AppLocalizations.of(context)!.title_currency_settings);
    } else {
      return Text('Error in the dialog type');
    }
  }
}
