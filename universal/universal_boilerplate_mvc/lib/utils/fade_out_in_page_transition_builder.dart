
import 'package:flutter/material.dart';

/// A custom PageTransitionBuilder that implements a "fade-through" transition:
/// it first fades out the old page, then fades in the new page.
///
/// This builder is applied to *both* pages (old and new) during navigation.
///
class FadeOutInPageTransitionBuilder extends PageTransitionsBuilder {
  const FadeOutInPageTransitionBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation, // Primary animation (enter: 0.0 -> 1.0)
    Animation<double> secondaryAnimation, // Secondary animation (exit: 0.0 -> 1.0)
    Widget child,
  ) {
    // --- ENTER (Fade In) logic ---
    // The new page should appear only in the second half (0.5 -> 1.0).
    // We use a CurvedAnimation with an Interval to map the primary
    // animation to this sub-interval.
    final Animation<double> fadeIn = CurvedAnimation(
      parent: animation,
      curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
    );

    // --- EXIT (Fade Out) logic ---
    // The old page should disappear during the first half (0.0 -> 0.5).
    // 'secondaryAnimation' runs from 0.0 to 1.0, so we invert it
    // (1.0 -> 0.0) using a Tween.
    final Animation<double> fadeOut = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: secondaryAnimation,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    // We combine the two transitions.
    //
    // When the page is ENTERING:
    // the primary 'animation' is active (0.0 -> 1.0).
    // the 'secondaryAnimation' is 0.0, so 'fadeOut.value' stays at 1.0 (fully visible).
    // 'fadeIn.value' animates from 0.0 to 1.0.
    // Result: the child appears (Fade In).
    //
    // When the page is EXITING:
    // the primary 'animation' is 1.0, so 'fadeIn.value' is 1.0 (fully visible).
    // the 'secondaryAnimation' becomes active (0.0 -> 1.0).
    // 'fadeOut.value' animates from 1.0 to 0.0.
    // Result: the child disappears (Fade Out).
    //
    // Nesting `FadeTransition`s multiplies their opacities.
    return FadeTransition(
      opacity: fadeOut, // Manages the exit
      child: FadeTransition(
        opacity: fadeIn, // Manages the entry
        child: child,
      ),
    );
  }
}