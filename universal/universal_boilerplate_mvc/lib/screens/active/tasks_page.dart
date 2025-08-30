import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../navigation/routes_declaration.dart';

class TasksPage extends StatelessWidget {
  TasksPage({super.key});

  final List<String> _tasks = List.generate(1000, (index) => '${index + 1}');

  List<Widget> _buildList(List<String> data, BuildContext context) {
    return data
        .map(
          (e) => Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            height: 150,
            child: Card(
              child: ListTile(
                title: Text('Task $e'),
                subtitle: Text('Description of task with id $e'),
                trailing: IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed:
                      () => GoRouter.of(context).goNamed(
                        DefinedRoutesNames.taskDetails,
                        pathParameters: {'id': e.toString()},
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
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Active Tasks Screen', style: TextStyle(fontSize: 24)),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(_buildList(_tasks, context)),
        ),
      ] ,
    );
  }
}
