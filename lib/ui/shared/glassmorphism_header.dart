import 'package:flutter/material.dart';
import 'dart:ui';

class GlassmorphismHeader extends StatelessWidget {
  const GlassmorphismHeader({
    super.key,
    required this.child,
    this.height,
    this.bottomRadius = 24.0,
  });

  final Widget child;
  final double? height;

  /// Radius applied to the two bottom corners, giving the header a soft
  /// pill-shaped bottom edge that blends into content below.
  final double bottomRadius;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.vertical(bottom: Radius.circular(bottomRadius));
    return ClipRRect(
      borderRadius: radius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: height,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor.withValues(alpha: 0.3),
            borderRadius: radius,
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
