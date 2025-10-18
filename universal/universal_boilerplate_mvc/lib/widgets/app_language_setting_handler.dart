import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/language/language_cubit.dart';
import '../bloc/language/language_search_cubit.dart';
import '../l10n/app_localizations.dart';

class AppLanguageSettingHandler extends StatelessWidget {
  const AppLanguageSettingHandler({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (BuildContext context, LanguageState state) {
        final Locale selected = state.activeLanguage;
        final String currentName =
            AppLocalizations.of(context)?.languageName ??
            lookupAppLocalizations(selected).languageName;

        return Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: <Widget>[
            Text(AppLocalizations.of(context)!.setting_language),
            OutlinedButton(
              onPressed: () async {
                final Locale? picked = await showGeneralDialog<Locale>(
                  context: context,
                  barrierDismissible: true,
                  barrierLabel:
                      MaterialLocalizations.of(
                        context,
                      ).modalBarrierDismissLabel,
                  pageBuilder:
                      (
                        BuildContext dialogContext,
                        Animation<double> animation,
                        Animation<double> secondaryAnimation,
                      ) => _AppLanguagePickerDialog(
                        initial: selected,
                      ),
                );

                if (picked != null && picked != selected) {
                  if (context.mounted) {
                    context.read<LanguageCubit>().changeLanguage(picked);
                  }
                }
              },
              child: Row(
                children: <Widget>[
                  Text(currentName),
                  const SizedBox(width: 16),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _AppLanguagePickerDialog extends StatelessWidget {
  final Locale initial;

  const _AppLanguagePickerDialog({
    required this.initial,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LanguageSearchCubit>(
      create: (_) => LanguageSearchCubit(),
      child: _AppLanguagePickerContent(initial: initial),
    );
  }
}

class _AppLanguagePickerContent extends StatelessWidget {
  final Locale initial;

  const _AppLanguagePickerContent({required this.initial});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AlertDialog(
        title: Text(AppLocalizations.of(context)!.languageName),
        content: Container(
          width: 600,
          constraints: const BoxConstraints(
            maxHeight: 400,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  hintText:
                      AppLocalizations.of(
                        context,
                      )!.setting_language_dialog_input_hint,
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged:
                    (String value) =>
                        context.read<LanguageSearchCubit>().search(value),
              ),
              const SizedBox(height: 12),
              Flexible(
                child: BlocBuilder<LanguageSearchCubit, List<Locale>>(
                  builder: (BuildContext context, List<Locale> filtered) {
                    return ListView.separated(
                      shrinkWrap: true,
                      itemCount: filtered.length,
                      separatorBuilder: (_, _) => const Divider(height: 1),
                      itemBuilder: (BuildContext context, int index) {
                        final Locale locale = filtered[index];
                        final String languageName =
                            lookupAppLocalizations(
                              locale,
                            ).languageName;
                        final bool selected =
                            locale.languageCode == initial.languageCode;

                        return ListTile(
                          title: Text(languageName),
                          trailing: selected ? const Icon(Icons.check) : null,
                          onTap: () => Navigator.of(context).pop(locale),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              AppLocalizations.of(
                context,
              )!.setting_language_dialog_close_button,
            ),
          ),
        ],
      ),
    );
  }
}
