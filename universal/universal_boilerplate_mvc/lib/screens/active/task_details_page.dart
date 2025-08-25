import 'package:flutter/material.dart';

import '../../scrollable_page_widget.dart';

class TaskDetailsPage extends ScrollablePageWidget {
  const TaskDetailsPage({super.key, required this.id});
  final int? id;

  @override
  Widget buildPageContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            id != null
                ? 'Task Details Screen with ID: $id'
                : 'Error retrieving ID',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ],
    );
  }
}
