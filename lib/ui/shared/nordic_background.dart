import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Premium Scandinavian/Nordic background:
/// - Cool deep-night to midnight-blue gradient base
/// - Two soft indigo/teal glass orbs
/// - Subtle geometric grid lines giving a clean structured feel
/// - Sparse noise grain for depth
class NordicBackground extends StatelessWidget {
  const NordicBackground({super.key, this.scrollOffset = 0.0});

  final double scrollOffset;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final bgGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: isDark
          ? [const Color(0xFF0B0E14), const Color(0xFF0F1724)]
          : [const Color(0xFFF9FAFB), const Color(0xFFEEF2FF)],
    );

    return Stack(
      children: [
        // ── 1. Gradient base ───────────────────────────────────────
        Container(decoration: BoxDecoration(gradient: bgGradient)),

        // ── 2. Geometric grid overlay ──────────────────────────────
        Positioned.fill(child: _GeometricGridPainter(isDark: isDark)),

        // ── 3. Top-left indigo orb ─────────────────────────────────
        _Orb(
          top: -screenHeight * 0.1 + (scrollOffset * 0.08),
          left: -screenWidth * 0.2,
          size: screenWidth * 0.85,
          color: isDark
              ? const Color(0xFF6366F1).withValues(alpha: 0.12)
              : const Color(0xFF4F46E5).withValues(alpha: 0.06),
          blur: 90,
        ),

        // ── 4. Bottom-right teal orb ───────────────────────────────
        _Orb(
          bottom: screenHeight * 0.05 - (scrollOffset * 0.15),
          right: -screenWidth * 0.3,
          size: screenWidth * 0.9,
          color: isDark
              ? const Color(0xFF2DD4BF).withValues(alpha: 0.07)
              : const Color(0xFF2DD4BF).withValues(alpha: 0.05),
          blur: 110,
        ),

        // ── 5. Stronger top-right accent orb for dark mode ─────────
        if (isDark)
          _Orb(
            top: screenHeight * 0.35,
            right: -screenWidth * 0.1,
            size: screenWidth * 0.5,
            color: const Color(0xFF818CF8).withValues(alpha: 0.05),
            blur: 80,
          ),

        // ── 6. Sparse noise grain ──────────────────────────────────
        Opacity(
          opacity: isDark ? 0.04 : 0.025,
          child: CustomPaint(painter: _NoisePainter(), size: Size.infinite),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Geometric grid — fine horizontal + vertical lines for structural feel
// ─────────────────────────────────────────────────────────────────────────────
class _GeometricGridPainter extends StatelessWidget {
  const _GeometricGridPainter({required this.isDark});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _GridPainter(isDark: isDark),
      size: Size.infinite,
    );
  }
}

class _GridPainter extends CustomPainter {
  const _GridPainter({required this.isDark});
  final bool isDark;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isDark
          ? Colors.white.withValues(alpha: 0.025)
          : Colors.black.withValues(alpha: 0.03)
      ..strokeWidth = 0.6;

    const gridSize = 48.0;

    // Vertical lines
    var x = gridSize;
    while (x < size.width) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
      x += gridSize;
    }

    // Horizontal lines
    var y = gridSize;
    while (y < size.height) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
      y += gridSize;
    }

    // Intersection dots for premium feel
    final dotPaint = Paint()
      ..color = isDark
          ? Colors.white.withValues(alpha: 0.04)
          : Colors.black.withValues(alpha: 0.05);
    var dx = gridSize;
    while (dx < size.width) {
      var dy = gridSize;
      while (dy < size.height) {
        canvas.drawCircle(Offset(dx, dy), 1.5, dotPaint);
        dy += gridSize;
      }
      dx += gridSize;
    }
  }

  @override
  bool shouldRepaint(_GridPainter old) => old.isDark != isDark;
}

// ─────────────────────────────────────────────────────────────────────────────
// Soft blurred orb — no BackdropFilter (avoids Impeller issues)
// ─────────────────────────────────────────────────────────────────────────────
class _Orb extends StatelessWidget {
  const _Orb({
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
          // Simulate blur with a radial gradient fade
          gradient: RadialGradient(
            colors: [color, Colors.transparent],
            stops: const [0.0, 1.0],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Sparse noise grain
// ─────────────────────────────────────────────────────────────────────────────
class _NoisePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final random = math.Random(42);
    final paint = Paint();
    for (var i = 0; i < 800; i++) {
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
