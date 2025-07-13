import 'package:flutter/material.dart';

class TaskDetailsScreen extends StatelessWidget {
  const TaskDetailsScreen({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Task Details Screen with ID: $id',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
