import 'package:flutter/material.dart';

import 'fluid_shader_background.dart';
import 'neumorphic_background.dart';

/// Clean ambient background - NO geometric patterns, NO lines.
/// Just smooth gradients.
class AmbientBackground extends StatelessWidget {
  const AmbientBackground({
    super.key,
    required this.child,
    this.scrollOffset = 0.0,
  });

  final Widget child;
  
  /// Scroll offset for parallax effect in light mode (0.0 = top of page)
  final double scrollOffset;

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    
    return Stack(
      children: [
        // Background layer
        if (isLight)
          // Light mode: Neumorphic soft 3D background with parallax
          NeumorphicBackground(scrollOffset: scrollOffset)
        else
          // Dark mode: Smooth fluid background with parallax shapes
          FluidShaderBackground(scrollOffset: scrollOffset),

        // NO GeometricPatternOverlay - removed!

        // Content
        child,
      ],
    );
  }
}
