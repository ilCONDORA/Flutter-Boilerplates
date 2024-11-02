import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../blocs/app_settings/app_settings_bloc.dart';
import '../../l10n/l10n.dart';

/// [MenuCurrencySelector] is responsible for the creation of the currency selector in the header.
class MenuCurrencySelector extends StatelessWidget {
  const MenuCurrencySelector({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: FittedBox(
        child: BlocBuilder<AppSettingsBloc, AppSettingsState>(
          builder: (context, state) {
            return Tooltip(
              waitDuration: const Duration(seconds: 2),
              message:
                  AppLocalizations.of(context)!.tooltip_change_currency_menu,
              child: DropdownMenu(
                initialSelection: state.appSettingsModel.localeCurrency,
                textStyle: const TextStyle(fontSize: 24),
                inputDecorationTheme: const InputDecorationTheme(
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
                onSelected: (newValueSelected) {
                  context.read<AppSettingsBloc>().add(
                        ChangeAppSettings(
                          appSettingsModel: state.appSettingsModel.copyWith(
                            localeCurrency: newValueSelected,
                          ),
                        ),
                      );
                },
                leadingIcon: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 12.0,
                  ),
                  child: CountryFlag.fromCountryCode(
                    state.appSettingsModel.localeCurrency.countryCode ?? '',
                  ),
                ),
                dropdownMenuEntries: L10n.supportedLocalesCurrencies.map(
                  (locale) {
                    return DropdownMenuEntry(
                      value: locale,
                      leadingIcon: CountryFlag.fromCountryCode(
                        locale.countryCode ?? '',
                      ),
                      style: const ButtonStyle(
                        textStyle: WidgetStatePropertyAll(
                          TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      label:
                          NumberFormat.simpleCurrency(locale: locale.toString())
                              .format(0),
                    );
                  },
                ).toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}
