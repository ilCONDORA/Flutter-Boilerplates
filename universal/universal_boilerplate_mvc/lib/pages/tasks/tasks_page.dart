import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../l10n/app_localizations.dart';
import '../../widgets/padding_wrapper.dart';

import '../../navigation/routes_declaration.dart';

class TasksPage extends StatelessWidget {
  TasksPage({super.key});

  final List<String> _tasks = List<String>.generate(
    1000,
    (int index) => '${index + 1}',
  );

  List<Widget> _buildList(List<String> data, BuildContext context) {
    return data
        .map(
          (String i) => Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            height: 150,
            child: Card(
              child: ListTile(
                title: Text(AppLocalizations.of(context)!.task_with_id(i)),
                subtitle: Text(
                  AppLocalizations.of(context)!.task_description_with_id(i),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed:
                      () => GoRouter.of(context).goNamed(
                        DefinedRoutes.taskDetails.name,
                        pathParameters: <String, String>{'id': i.toString()},
                      ),
                ),
              ),
            ),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          pinned: false,
          floating: true,
          snap:
              true, // Whitout this the app bar will remain half open if during a scroll we stop scrolling.
          backgroundColor: Theme.of(context).colorScheme.surface,
          foregroundColor: Theme.of(context).colorScheme.onSurface,
          elevation: 1,
          title: Text(AppLocalizations.of(context)!.tasks_page_title),
        ),
        PaddingWrapper(
          child: SliverList(
            delegate: SliverChildListDelegate(_buildList(_tasks, context)),
          ),
        ),
      ],
    );
  }
}
