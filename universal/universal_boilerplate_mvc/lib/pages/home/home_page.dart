import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../widgets/app_language_setting_handler.dart';
import '../../widgets/padding_wrapper.dart';
import '../../widgets/theme_setting_handler.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        PaddingWrapper(
          child: SliverToBoxAdapter(child: AppLanguageSettingHandler()),
        ),
        PaddingWrapper(child: SliverToBoxAdapter(child: ThemeSettingHandler())),
        PaddingWrapper(
          child: SliverToBoxAdapter(
            child: // Display example text from localization
            // This text will change based on the selected language
            Text(AppLocalizations.of(context)!.example_text),
          ),
        ),
      ],
    );
  }
}
