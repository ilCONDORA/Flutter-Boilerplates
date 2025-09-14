import 'package:flutter/material.dart';

/// Custom page transitions builder che implementa una transizione fade sequenziale pulita.
///
/// La transizione funziona in questo modo:
/// 1. Il contenuto corrente svanisce completamente (0.0 → 0.8 dell'animazione secondaria)
/// 2. Breve pausa con sfondo pulito (0.4 → 0.5 dell'animazione principale)
/// 3. Il nuovo contenuto appare gradualmente (0.5 → 1.0 dell'animazione principale)
class CustomFadePageTransitionsBuilder extends PageTransitionsBuilder {
  const CustomFadePageTransitionsBuilder();

  @override
  Widget buildTransitions<T extends Object?>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return _CustomFadeTransition(
      animation: animation,
      secondaryAnimation: secondaryAnimation,
      child: child,
    );
  }
}

class _CustomFadeTransition extends StatelessWidget {
  const _CustomFadeTransition({
    required this.animation,
    required this.secondaryAnimation,
    required this.child,
  });

  final Animation<double> animation;
  final Animation<double> secondaryAnimation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // Animazione per far svanire il contenuto precedente (più lenta)
    final fadeOutAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: secondaryAnimation,
        curve: const Interval(0.0, 0.5, curve: Curves.easeInCubic),
      ),
    );

    // Animazione per far apparire il nuovo contenuto (più lenta)
    final fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animation,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    return AnimatedBuilder(
      animation: Listenable.merge([animation, secondaryAnimation]),
      builder: (context, _) {
        return Stack(
          children: [
            // Sfondo pulito durante la transizione
            Container(color: Theme.of(context).scaffoldBackgroundColor),

            // Il contenuto precedente che svanisce (solo durante le transizioni push)
            if (secondaryAnimation.status != AnimationStatus.dismissed)
              FadeTransition(
                opacity: fadeOutAnimation,
                child:
                    Container(), // Il contenuto precedente viene gestito automaticamente da Flutter
              ),

            // Il nuovo contenuto che appare
            FadeTransition(opacity: fadeInAnimation, child: child),
          ],
        );
      },
    );
  }
}
