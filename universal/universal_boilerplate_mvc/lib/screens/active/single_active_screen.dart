import 'package:flutter/material.dart';

class SingleActiveScreen extends StatelessWidget {
  const SingleActiveScreen({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Single Active Screen with ID: $id',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
