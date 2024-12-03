import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

/// This class is used to build the footer.
class Footer extends StatelessWidget {
  const Footer({super.key});

  /// This method is used to build a [TextButton].
  /// 
  /// The properties are:
  /// - [context] is the context of the widget.
  /// - [label] is the label of the button.
  /// - [goRouterName] is the name of the route to navigate to, can be null.
  /// - [uri] is the uri to navigate to, can be null.
  TextButton _buildLink({
    required BuildContext context,
    required String label,
    required String? goRouterName,
    required Uri? uri,
  }) =>
      TextButton(
        onPressed: () {
          if (goRouterName != null || goRouterName != '') {
            GoRouter.of(context).goNamed(goRouterName!);
          } else if (uri != null) {
          } else {
            print('No link defined');
          }
        },
        child: Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
      );

  /// This method is used to get the map of the sections.
  /// 
  /// The propertie is [context] which is the context of the widget.
  /// The [context] is used [AppLocalizations.of(context)] to get the proper localization of the labels and links labels.
  Map<String, List<TextButton>> sectionsMap(BuildContext context) => {
        'AppLocalizations.of(context)!.company_label': [
          _buildLink(
            context: context,
            label: 'AppLocalizations.of(context)!.about_us_label',
            goRouterName: 'about_us',
            uri: null,
          ),
          _buildLink(
            context: context,
            label: 'AppLocalizations.of(context)!.careers_label',
            goRouterName: null,
            uri: null,
          ),
          _buildLink(
            context: context,
            label: 'AppLocalizations.of(context)!.privacy_policy_label',
            goRouterName: null,
            uri: null,
          ),
          _buildLink(
            context: context,
            label: 'AppLocalizations.of(context)!.terms&conditions_label',
            goRouterName: null,
            uri: null,
          ),
        ],
        'CUSTOMER SERVICE': [
          _buildLink(
            context: context,
            label: 'AppLocalizations.of(context)!.helpcenter_label',
            goRouterName: null,
            uri: null,
          ),
          _buildLink(
            context: context,
            label: 'AppLocalizations.of(context)!.faqs_label',
            goRouterName: null,
            uri: null,
          ),
          _buildLink(
            context: context,
            label: 'AppLocalizations.of(context)!.do_not_sell_my_info_label',
            goRouterName: null,
            uri: null,
          ),
        ]
      };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
      color: Colors.grey.shade900,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Wrap(
              spacing: 100,
              runSpacing: 30,
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              children: [
                ...sectionsMap(context).entries.map(
                      (entry) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            entry.key,
                            style: const TextStyle(color: Colors.white),
                          ),
                          ...entry.value,
                        ],
                      ),
                    ),
              ],
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          const Text(
            '© 2024 Your Company. All rights reserved.',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
