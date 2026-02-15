import 'package:flutter/material.dart';

/// A Neumorphic/Soft UI background widget with floating 3D shapes.
/// 
/// Creates a monochromatic, ultra-clean background with large, soft shapes
/// that look like extruded plastic or soft clay. Uses dual box shadows to
/// create the signature neumorphic "soft 3D" effect.
/// 
/// Supports parallax scrolling effect when [scrollOffset] is provided.
class NeumorphicBackground extends StatelessWidget {
  const NeumorphicBackground({
    super.key,
    this.scrollOffset = 0.0,
  });

  /// Scroll offset for parallax effect (0.0 = top of page)
  final double scrollOffset;

  // Base background color - Darker Cool Grey for better contrast
  static const Color _baseColor = Color(0xFFE8E8E8);
  
  // Shadow colors for the neumorphic effect
  static const Color _highlightColor = Colors.white;
  static const Color _shadowColor = Color(0xFFC5CAD3); // Darker shadow for more contrast

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Calculate parallax offsets (different speeds for depth)
    final parallax1 = scrollOffset * 0.15; // Slowest (farthest)
    final parallax2 = scrollOffset * 0.25; 
    final parallax3 = scrollOffset * 0.35;
    final parallax4 = scrollOffset * 0.20; // Medium speed

    return Container(
      color: _baseColor,
      child: Stack(
        children: [
          // Shape 1 - Top Left (Large Circle) - Slowest movement
          Positioned(
            top: -screenHeight * 0.15 + parallax1,
            left: -screenWidth * 0.2,
            child: Transform.rotate(
              angle: 0.3,
              child: _buildNeumorphicShape(
                width: screenWidth * 0.6,
                height: screenWidth * 0.6,
                borderRadius: 80,
              ),
            ),
          ),

          // Shape 2 - Top Right (Rounded Rectangle) - Medium-fast movement
          Positioned(
            top: screenHeight * 0.1 + parallax2,
            right: -screenWidth * 0.25,
            child: Transform.rotate(
              angle: -0.5,
              child: _buildNeumorphicShape(
                width: screenWidth * 0.55,
                height: screenHeight * 0.35,
                borderRadius: 60,
              ),
            ),
          ),

          // Shape 3 - Bottom Left (Rounded Square) - Fastest movement
          Positioned(
            bottom: -screenHeight * 0.1 - parallax3,
            left: -screenWidth * 0.15,
            child: Transform.rotate(
              angle: 0.7,
              child: _buildNeumorphicShape(
                width: screenWidth * 0.5,
                height: screenWidth * 0.5,
                borderRadius: 70,
              ),
            ),
          ),

          // Shape 4 - Bottom Right (Elongated Rounded Rectangle) - Medium movement
          Positioned(
            bottom: screenHeight * 0.15 - parallax4,
            right: -screenWidth * 0.3,
            child: Transform.rotate(
              angle: -0.4,
              child: _buildNeumorphicShape(
                width: screenWidth * 0.65,
                height: screenHeight * 0.25,
                borderRadius: 75,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds a single neumorphic shape with the signature dual shadow effect.
  /// 
  /// The shape uses:
  /// - Same color as background for monochromatic look
  /// - Large border radius for soft, rounded appearance
  /// - Highlight shadow (top-left) for light source simulation
  /// - Dark shadow (bottom-right) for depth perception
  Widget _buildNeumorphicShape({
    required double width,
    required double height,
    required double borderRadius,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: _baseColor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          // Highlight shadow - simulates light from top-left
          BoxShadow(
            color: _highlightColor,
            offset: const Offset(-20, -20),
            blurRadius: 20,
            spreadRadius: 0,
          ),
          // Dark shadow - creates depth from bottom-right
          BoxShadow(
            color: _shadowColor,
            offset: const Offset(20, 20),
            blurRadius: 60,
            spreadRadius: 0,
          ),
        ],
      ),
    );
  }
}
