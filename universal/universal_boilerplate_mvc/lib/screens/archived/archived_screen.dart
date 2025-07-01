import 'package:flutter/material.dart';

class ArchivedScreen extends StatelessWidget {
  const ArchivedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < 20; i++)
          ListTile(
            title: Text('Archived Item $i'),
            subtitle: Text('Subtitle $i'),
            leading: Icon(Icons.archive),
            trailing: Icon(Icons.arrow_forward),
          ),
      ],
    );
  }
}
