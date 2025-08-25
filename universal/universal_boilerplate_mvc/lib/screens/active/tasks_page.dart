import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../navigation/routes_declaration.dart';
import '../../scrollable_page_widget.dart';

class TasksPage extends ScrollablePageWidget {
  const TasksPage({super.key});

  @override
  Widget buildPageContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      spacing: 12,
      children: [
        Center(
          child: Text('Active Tasks Screen', style: TextStyle(fontSize: 24)),
        ),
        Flexible(
          child: ListView.builder(
            itemCount: 20,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final taskId = index + 1;
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Card(
                  child: ListTile(
                    title: Text('Task $taskId'),
                    subtitle: Text('Description of task with id $taskId'),
                    trailing: IconButton(
                      icon: Icon(Icons.arrow_forward),
                      onPressed:
                          () => GoRouter.of(context).goNamed(
                            DefinedRoutesNames.taskDetails,
                            pathParameters: {'id': taskId.toString()},
                          ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
