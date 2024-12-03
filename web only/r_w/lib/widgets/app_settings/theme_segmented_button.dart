import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../blocs/app_settings/app_settings_bloc.dart';

/// [ThemeSegmentedButton] is responsible for the creation of the segmented button used to change the theme in the header.
class ThemeSegmentedButton extends StatelessWidget {
  const ThemeSegmentedButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppSettingsBloc, AppSettingsState>(
      builder: (context, state) {
        return Tooltip(
          waitDuration: const Duration(seconds: 2),
          message: AppLocalizations.of(context)!.tooltip_change_theme_button,
          preferBelow: false,
          child: SegmentedButton(
            segments: [
              ButtonSegment(
                value: ThemeMode.light,
                icon: Icon(Icons.light_mode, color: Colors.orange.shade700),
              ),
              const ButtonSegment(
                value: ThemeMode.dark,
                icon: Icon(
                  Icons.dark_mode,
                  color: Colors.grey,
                ),
              ),
            ],
            selected: <ThemeMode>{state.appSettingsModel.themeMode},
            onSelectionChanged: (newSelectedValue) {
              context.read<AppSettingsBloc>().add(
                    ChangeAppSettings(
                      appSettingsModel: state.appSettingsModel.copyWith(
                        themeMode: newSelectedValue.first,
                      ),
                    ),
                  );
            },
          ),
        );
      },
    );
  }
}
