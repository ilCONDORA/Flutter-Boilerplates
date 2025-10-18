import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

class TaskDetailsPage extends StatelessWidget {
  const TaskDetailsPage({super.key, required this.id});
  final int? id;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          floating: false,
          snap: false,
          backgroundColor: Theme.of(context).colorScheme.surface,
          foregroundColor: Theme.of(context).colorScheme.onSurface,
          elevation: 1,
          automaticallyImplyLeading: false,
          leading: const BackButton(),
        ),
        SliverToBoxAdapter(
          child: Center(
            child: Text(
              id != null
                  ? AppLocalizations.of(
                    context,
                  )!.task_detail_page_with_id(id.toString())
                  : AppLocalizations.of(
                    context,
                  )!.task_detail_page_error_with_id(id.toString()),
              style: TextStyle(fontSize: 24),
            ),
          ),
        ),
      ],
    );
  }
}
