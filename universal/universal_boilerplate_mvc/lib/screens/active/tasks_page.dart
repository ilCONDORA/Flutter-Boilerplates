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
      spacing: 12,
      children: [
        Center(
          child: Text('Active Tasks Screen', style: TextStyle(fontSize: 24)),
        ),

        for (int i = 1; i <= 20; i++)
          SizedBox(
            width: 400,
            child: ListTile(
              title: Text('Task $i'),
              subtitle: Text('Description of task with id $i'),
              trailing: IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed:
                    () => GoRouter.of(context).goNamed(
                      DefinedRoutesNames.taskDetails,
                      pathParameters: {'id': i.toString()},
                    ),
              ),
            ),
          ),
      ],
    );
  }
}
