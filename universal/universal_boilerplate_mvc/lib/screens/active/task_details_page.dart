import 'package:flutter/material.dart';

class TaskDetailsPage extends StatelessWidget {
  const TaskDetailsPage({super.key, required this.id});
  final int? id;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
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
                  ? 'Task Details Screen with ID: $id'
                  : 'Error retrieving ID',
              style: TextStyle(fontSize: 24),
            ),
          ),
        ),
      ],
    );
  }
}
