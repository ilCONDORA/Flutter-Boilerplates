import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/theme/theme_cubit.dart';
import '../l10n/app_localizations.dart';
import '../utils/app_colors.dart';

class ThemeSettingHandler extends StatelessWidget {
  const ThemeSettingHandler({super.key});

  // Helper to build a consistent ButtonStyle for the theme selector buttons
  ButtonStyle _buttonStyle({
    required BuildContext context,
    required ThemeMode themeFromState,
    required ThemeMode buttonMode,
    Color? selectedForeground,
  }) {
    final brightness = Theme.of(context).brightness;

    return ButtonStyle(
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      backgroundColor: WidgetStateProperty.all(
        themeFromState == buttonMode
            ? AppColors.airForceBlue
            : Colors.transparent,
      ),
      foregroundColor: WidgetStateProperty.all(
        themeFromState == buttonMode
            ? (selectedForeground ?? Colors.white)
            : (brightness == Brightness.light ? Colors.black : Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 16,
      children: [
        Text(AppLocalizations.of(context)!.setting_theme),
        Container(
          padding:
              kIsWeb
                  ? const EdgeInsets.all(6)
                  : Platform.isAndroid || Platform.isIOS
                  ? const EdgeInsets.symmetric(horizontal: 6, vertical: 2)
                  : const EdgeInsets.all(6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(22.5)),
            border: Border.all(
              width: 1.5,
              color: AppColors.tiffanyBlue,
            ),
          ),
          child: BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              final themeFromState = state.themeMode;
              return Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 6,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(minWidth: 80, minHeight: 40),
                    child: TextButton(
                      onPressed:
                          () => context.read<ThemeCubit>().changeTheme(
                            ThemeMode.system,
                          ),
                      style: _buttonStyle(
                        context: context,
                        themeFromState: themeFromState,
                        buttonMode: ThemeMode.system,
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.setting_theme_system,
                      ),
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(minWidth: 80, minHeight: 40),
                    child: IconButton(
                      onPressed:
                          () => context.read<ThemeCubit>().changeTheme(
                            ThemeMode.light,
                          ),
                      style: _buttonStyle(
                        context: context,
                        themeFromState: themeFromState,
                        buttonMode: ThemeMode.light,
                        selectedForeground: Colors.orangeAccent,
                      ),
                      icon: const Icon(Icons.wb_sunny_outlined),
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(minWidth: 80, minHeight: 40),
                    child: IconButton(
                      onPressed:
                          () => context.read<ThemeCubit>().changeTheme(
                            ThemeMode.dark,
                          ),
                      style: _buttonStyle(
                        context: context,
                        themeFromState: themeFromState,
                        buttonMode: ThemeMode.dark,
                      ),
                      icon: Transform.rotate(
                        angle: -0.6,
                        child: const Icon(Icons.nightlight_outlined),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
