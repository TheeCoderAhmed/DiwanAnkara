import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Premium Scandinavian/Nordic background with soft frosted glass orbs,
/// subtle grain/noise texture, and elegant minimalist gradients.
class NordicBackground extends StatelessWidget {
  const NordicBackground({
    super.key,
    this.scrollOffset = 0.0,
  });

  final double scrollOffset;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Nordic Palette
    // Light: Snow White (#F9FAFB), Ice Blue (#E5E7EB), Slate Frost (#D1D5DB)
    // Dark: Deep Night (#0B0E14), Midnight Blue (#111827), Arctic Grey (#1F2937)
    final bgGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: isDark
          ? [const Color(0xFF0B0E14), const Color(0xFF111827)]
          : [const Color(0xFFF9FAFB), const Color(0xFFE5E7EB)],
    );

    return Stack(
      children: [
        // Base Gradient
        Container(decoration: BoxDecoration(gradient: bgGradient)),

        // Glass Orbs
        _PositionedOrb(
          top: -screenHeight * 0.1 + (scrollOffset * 0.1),
          left: -screenWidth * 0.2,
          size: screenWidth * 0.8,
          color: isDark ? const Color(0xFF6366F1).withValues(alpha: 0.1) : const Color(0xFF4F46E5).withValues(alpha: 0.05),
          blur: 80,
        ),
        _PositionedOrb(
          bottom: screenHeight * 0.1 - (scrollOffset * 0.2),
          right: -screenWidth * 0.3,
          size: screenWidth * 0.9,
          color: isDark ? const Color(0xFF0D9488).withValues(alpha: 0.08) : const Color(0xFF2DD4BF).withValues(alpha: 0.05),
          blur: 100,
        ),

        // Noise Texture (Optional but adds high-end feel)
        Opacity(
          opacity: isDark ? 0.03 : 0.02,
          child: _NoiseTexture(),
        ),
      ],
    );
  }
}

class _PositionedOrb extends StatelessWidget {
  const _PositionedOrb({
    this.top,
    this.left,
    this.right,
    this.bottom,
    required this.size,
    required this.color,
    required this.blur,
  });

  final double? top, left, right, bottom;
  final double size;
  final Color color;
  final double blur;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        child: BackdropFilter(
          filter: ColorFilter.mode(Colors.transparent, BlendMode.srcOver),
          child: Container(),
        ),
      ),
    );
  }
}

class _NoiseTexture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _NoisePainter(),
      size: Size.infinite,
    );
  }
}

class _NoisePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final random = math.Random(42); // Seeded for consistency
    final paint = Paint();
    
    for (var i = 0; i < 1000; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final opacity = random.nextDouble() * 0.5;
      paint.color = Colors.grey.withValues(alpha: opacity);
      canvas.drawCircle(Offset(x, y), 0.5, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
