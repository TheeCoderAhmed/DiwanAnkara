import 'package:flutter/material.dart';

/// Premium editorial/paper background with:
/// - Ruled notebook lines for the "ink on paper" feel
/// - Sepia cream base
/// - Red margin rule (left edge) in light mode
/// - Soft corner-glow reading-light gradient
class PaperBackground extends StatelessWidget {
  const PaperBackground({super.key, this.scrollOffset = 0.0});

  final double scrollOffset;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bgColor = isDark ? const Color(0xFF0F0F0F) : const Color(0xFFFAF8F1);


    return Stack(
      children: [
        // ── 1. Cream/Charcoal base ─────────────────────────────────
        Container(color: bgColor),

        // ── 2. Ruled notebook lines ────────────────────────────────
        Positioned.fill(child: _RuledLinesPainter(isDark: isDark)),

        // ── 3. Paper texture overlay ───────────────────────────────
        Positioned.fill(
          child: Opacity(
            opacity: isDark ? 0.04 : 0.07,
            child: Image.asset(
              'assets/images/recycled-paper.png',
              repeat: ImageRepeat.repeat,
              fit: BoxFit.none,
              color: isDark ? Colors.white : const Color(0xFFD4C9B0),
              colorBlendMode: BlendMode.multiply,
            ),
          ),
        ),

        // ── 4. Top-right reading-lamp glow ─────────────────────────
        Positioned(
          top: -80,
          right: -80,
          child: Container(
            width: 360,
            height: 360,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  isDark
                      ? Colors.white.withValues(alpha: 0.02)
                      : const Color(0xFFFFF8DC).withValues(alpha: 0.45),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),

        // ── 5. Red margin rule (light mode only) ───────────────────
        if (!isDark)
          Positioned(
            left: 52,
            top: 0,
            bottom: 0,
            child: Container(
              width: 1,
              color: const Color(0xFFEAB5B5).withValues(alpha: 0.6),
            ),
          ),

        // ── 6. Left page-edge shadow ───────────────────────────────
        Positioned(
          left: 0,
          top: 0,
          bottom: 0,
          child: Container(
            width: 6,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withValues(alpha: isDark ? 0.15 : 0.05),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// CustomPaint widget that draws ruled horizontal lines across the entire screen
class _RuledLinesPainter extends StatelessWidget {
  const _RuledLinesPainter({required this.isDark});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _LinesPainter(isDark: isDark),
      size: Size.infinite,
    );
  }
}

class _LinesPainter extends CustomPainter {
  const _LinesPainter({required this.isDark});
  final bool isDark;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isDark
          ? const Color(0xFF252525).withValues(alpha: 0.95)
          : const Color(0xFFDDD8C4).withValues(alpha: 0.55)
      ..strokeWidth = 0.75;


    const lineSpacing = 26.0;
    var y = lineSpacing;
    while (y < size.height) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
      y += lineSpacing;
    }
  }

  @override
  bool shouldRepaint(_LinesPainter old) => old.isDark != isDark;
}
