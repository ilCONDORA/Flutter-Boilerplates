import 'package:flutter/material.dart';

class PaddingWrapper extends StatelessWidget {
  const PaddingWrapper({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
      sliver: child,
    );
  }
}
