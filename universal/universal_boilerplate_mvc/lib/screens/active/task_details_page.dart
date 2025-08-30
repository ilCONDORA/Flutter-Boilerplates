import 'package:flutter/material.dart';


class TaskDetailsPage extends StatelessWidget {
  const TaskDetailsPage({super.key, required this.id});
  final int? id;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
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
