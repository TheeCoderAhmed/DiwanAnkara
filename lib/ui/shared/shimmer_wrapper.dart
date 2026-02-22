import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// A wrapper that applies a shimmer effect appropriate for the current theme.
///
/// Wrap any skeleton/placeholder widget to give it a live shimmer loading feel.
///
/// Example:
/// ```dart
/// ShimmerWrapper(
///   child: Container(
///     height: 120,
///     decoration: BoxDecoration(
///       color: Colors.white,
///       borderRadius: BorderRadius.circular(16),
///     ),
///   ),
/// )
/// ```
class ShimmerWrapper extends StatelessWidget {
  const ShimmerWrapper({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Shimmer.fromColors(
      baseColor: isDark ? const Color(0xFF2A2A2A) : Colors.grey.shade300,
      highlightColor: isDark ? const Color(0xFF3A3A3A) : Colors.grey.shade100,
      child: child,
    );
  }
}
