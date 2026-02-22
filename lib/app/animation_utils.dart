import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Animation helpers that respect the user's `prefers-reduced-motion`
/// accessibility preference via [MediaQuery.disableAnimations].
///
/// Usage:
/// ```dart
/// child.fadeSlideIn(context)
/// child.animateIfAllowed(context, animate: (w) => w.animate().fadeIn())
/// ```
extension ReducedMotionWidget on Widget {
  /// Runs [animate] only when the user has not requested reduced motion.
  /// Falls back to returning [this] unchanged.
  Widget animateIfAllowed(
    BuildContext context, {
    required Widget Function(Widget child) animate,
  }) {
    if (MediaQuery.of(context).disableAnimations) return this;
    return animate(this);
  }

  /// Standard fade + slide-up entrance animation.
  Widget fadeSlideIn(
    BuildContext context, {
    Duration duration = const Duration(milliseconds: 300),
    double slideBegin = 0.08,
  }) {
    return animateIfAllowed(
      context,
      animate: (w) => w
          .animate()
          .fadeIn(duration: duration)
          .slideY(begin: slideBegin, end: 0, duration: duration),
    );
  }

  /// Standard fade + slide-from-start (RTL-aware) entrance animation.
  Widget fadeSlideInFromStart(
    BuildContext context, {
    Duration duration = const Duration(milliseconds: 300),
    double slideBegin = 0.08,
  }) {
    final rtl = Directionality.of(context) == TextDirection.rtl;
    return animateIfAllowed(
      context,
      animate: (w) => w
          .animate()
          .fadeIn(duration: duration)
          .slideX(
            begin: rtl ? slideBegin : -slideBegin,
            end: 0,
            duration: duration,
          ),
    );
  }

  /// Simple fade-in animation.
  Widget fadeIn(
    BuildContext context, {
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return animateIfAllowed(
      context,
      animate: (w) => w.animate().fadeIn(duration: duration),
    );
  }
}
