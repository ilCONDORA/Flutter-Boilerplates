import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CleanSequentialFadeTransitionPage<T> extends CustomTransitionPage<T> {
  const CleanSequentialFadeTransitionPage({
    required super.child,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
    this.pauseDuration = const Duration(milliseconds: 100),
  }) : super(
         transitionDuration: const Duration(milliseconds: 500),
         reverseTransitionDuration: const Duration(milliseconds: 400),
         transitionsBuilder: _cleanSequentialFadeTransition,
       );

  final Duration pauseDuration;

  static Widget _cleanSequentialFadeTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // Approccio più semplice e pulito:
    // 1. Il vecchio contenuto svanisce completamente (0.0 → 0.4)
    // 2. Pausa con schermo vuoto (0.4 → 0.6)
    // 3. Il nuovo contenuto appare (0.6 → 1.0)

    final fadeOutAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: secondaryAnimation,
        curve: const Interval(0.0, 0.8, curve: Curves.easeInCubic),
      ),
    );

    final fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animation,
        curve: const Interval(0.5, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    return Stack(
      children: [
        // Sfondo pulito durante la pausa
        Container(color: Theme.of(context).scaffoldBackgroundColor),

        // Il vecchio contenuto che svanisce
        FadeTransition(
          opacity: fadeOutAnimation,
          child: Container(), // Placeholder per il contenuto precedente
        ),

        // Il nuovo contenuto che appare
        FadeTransition(opacity: fadeInAnimation, child: child),
      ],
    );
  }
}
