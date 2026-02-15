import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Premium smooth background with deep radial gradient, subtle fluid movement,
/// and parallax scrolling shapes.
/// 
/// NO lines, NO patterns, NO grid - just pure seamless gradients with soft 3D shapes.
/// Center: Dark Slate Blue (#1e2f42) → Edges: Pure Black (#000000)
class FluidShaderBackground extends StatefulWidget {
  const FluidShaderBackground({
    super.key,
    this.scrollOffset = 0.0,
  });

  /// Scroll offset for parallax effect (0.0 = top of page)
  final double scrollOffset;

  @override
  State<FluidShaderBackground> createState() => _FluidShaderBackgroundState();
}

class _FluidShaderBackgroundState extends State<FluidShaderBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 25), // Very slow, barely perceptible
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Calculate parallax offsets (different speeds for depth)
    final parallax1 = widget.scrollOffset * 0.15; // Slowest (farthest)
    final parallax2 = widget.scrollOffset * 0.25;
    final parallax3 = widget.scrollOffset * 0.35;
    final parallax4 = widget.scrollOffset * 0.20; // Medium speed

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          children: [
            // Base gradient background
            CustomPaint(
              painter: _SmoothGradientPainter(time: _controller.value),
              size: Size.infinite,
            ),
            
            // Parallax shapes layer
            // Shape 1 - Top Left (Large Circle)
            Positioned(
              top: -screenHeight * 0.15 + parallax1,
              left: -screenWidth * 0.2,
              child: Transform.rotate(
                angle: 0.3,
                child: _buildDarkNeumorphicShape(
                  width: screenWidth * 0.6,
                  height: screenWidth * 0.6,
                  borderRadius: 80,
                ),
              ),
            ),

            // Shape 2 - Top Right (Rounded Rectangle)
            Positioned(
              top: screenHeight * 0.1 + parallax2,
              right: -screenWidth * 0.25,
              child: Transform.rotate(
                angle: -0.5,
                child: _buildDarkNeumorphicShape(
                  width: screenWidth * 0.55,
                  height: screenHeight * 0.35,
                  borderRadius: 60,
                ),
              ),
            ),

            // Shape 3 - Bottom Left (Rounded Square)
            Positioned(
              bottom: -screenHeight * 0.1 - parallax3,
              left: -screenWidth * 0.15,
              child: Transform.rotate(
                angle: 0.7,
                child: _buildDarkNeumorphicShape(
                  width: screenWidth * 0.5,
                  height: screenWidth * 0.5,
                  borderRadius: 70,
                ),
              ),
            ),

            // Shape 4 - Bottom Right (Elongated Rounded Rectangle)
            Positioned(
              bottom: screenHeight * 0.15 - parallax4,
              right: -screenWidth * 0.3,
              child: Transform.rotate(
                angle: -0.4,
                child: _buildDarkNeumorphicShape(
                  width: screenWidth * 0.65,
                  height: screenHeight * 0.25,
                  borderRadius: 75,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  /// Builds a single dark neumorphic shape with subtle shadows.
  Widget _buildDarkNeumorphicShape({
    required double width,
    required double height,
    required double borderRadius,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFF1A2332), // Slightly lighter than background
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          // Highlight shadow - very subtle light from top-left
          BoxShadow(
            color: const Color(0xFF2A3A4F).withValues(alpha: 0.3),
            offset: const Offset(-20, -20),
            blurRadius: 60,
            spreadRadius: 0,
          ),
          // Dark shadow - creates depth from bottom-right
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.6),
            offset: const Offset(20, 20),
            blurRadius: 60,
            spreadRadius: 0,
          ),
        ],
      ),
    );
  }
}

class _SmoothGradientPainter extends CustomPainter {
  final double time;

  // Pure smooth colors - no noise, no lines
  static const Color _centerColor = Color(0xFF1E2F42);  // Dark Slate Blue
  static const Color _edgeColor = Color(0xFF000000);    // Pure Black
  static const Color _accentTeal = Color(0xFF0D3D3D);   // Subtle teal accent
  static const Color _accentWarm = Color(0xFF2A1A1A);   // Subtle warm accent

  _SmoothGradientPainter({required this.time});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final t = time * 2 * math.pi;

    // Layer 1: Base deep radial gradient (center slate blue → edge black)
    final baseGradient = RadialGradient(
      center: Alignment.center,
      radius: 1.2,
      colors: const [_centerColor, _edgeColor],
      stops: const [0.0, 1.0],
    );
    canvas.drawRect(rect, Paint()..shader = baseGradient.createShader(rect));

    // Layer 2: Subtle animated teal glow (top-left area)
    _drawSmoothGlow(
      canvas, size,
      centerX: size.width * (0.2 + 0.1 * math.sin(t * 0.3)),
      centerY: size.height * (0.25 + 0.08 * math.cos(t * 0.4)),
      radius: size.width * 0.7,
      color: _accentTeal.withValues(alpha: 0.25),
    );

    // Layer 3: Subtle animated warm glow (bottom-right area)
    _drawSmoothGlow(
      canvas, size,
      centerX: size.width * (0.75 + 0.08 * math.cos(t * 0.35)),
      centerY: size.height * (0.7 + 0.1 * math.sin(t * 0.45)),
      radius: size.width * 0.6,
      color: _accentWarm.withValues(alpha: 0.2),
    );

    // Layer 4: Central highlight (breathing effect)
    final breathe = 0.5 + 0.5 * math.sin(t * 0.5);
    _drawSmoothGlow(
      canvas, size,
      centerX: size.width * 0.5,
      centerY: size.height * 0.4,
      radius: size.width * (0.5 + breathe * 0.1),
      color: _centerColor.withValues(alpha: 0.15 + breathe * 0.1),
    );
  }

  void _drawSmoothGlow(
    Canvas canvas,
    Size size, {
    required double centerX,
    required double centerY,
    required double radius,
    required Color color,
  }) {
    final gradient = RadialGradient(
      center: Alignment(
        (centerX / size.width) * 2 - 1,
        (centerY / size.height) * 2 - 1,
      ),
      radius: radius / size.width,
      colors: [
        color,
        color.withValues(alpha: color.a * 0.4),
        color.withValues(alpha: 0),
      ],
      stops: const [0.0, 0.5, 1.0],
    );

    canvas.drawRect(
      Offset.zero & size,
      Paint()
        ..shader = gradient.createShader(Offset.zero & size)
        ..blendMode = BlendMode.plus,
    );
  }

  @override
  bool shouldRepaint(_SmoothGradientPainter oldDelegate) => time != oldDelegate.time;
}
