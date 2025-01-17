import 'package:currency_formatter/currency_formatter.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../blocs/app_settings/app_settings_bloc.dart';
import '../../l10n/l10n.dart';

enum DialogType { language, currency }
//TODO: aggiungere la documentazione

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

  // Costruisce un singolo elemento della griglia
  Widget _buildLocaleItem(
      BuildContext context, AppSettingsState state, Locale locale) {
    final isSelected = dialogType == DialogType.language
        ? state.appSettingsModel.localeLanguage == locale
        : state.appSettingsModel.localeCurrency == locale;

    // flagSize è principalmente l'height e lo metto anche per la width ma questa ha anche il ratio
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

  Widget _buildTitle({required BuildContext context, required AppSettingsState state}) {
    if (dialogType == DialogType.language) {
      //return Text('Select Language - ${state.appSettingsModel.localeLanguage}');
      return  Text(AppLocalizations.of(context)!.title_language_settings);
    }
    return  Text(AppLocalizations.of(context)!.title_currency_settings);
    /* final currencyFormat = CurrencyFormat.fromLocale(
      state.appSettingsModel.localeCurrency.toString(),
    )!;
    return Text(
      'Select Currency - ${currencyFormat.symbol} - ${state.appSettingsModel.localeCurrency}',
    ); */
  }
}
