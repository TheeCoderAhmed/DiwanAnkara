import 'package:flutter/material.dart';

/// A premium editorial/paper background with texture, subtle page-fold
/// gradients, and an "ink-on-paper" feel.
class PaperBackground extends StatelessWidget {
  const PaperBackground({super.key, this.scrollOffset = 0.0});

  final double scrollOffset;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Paper Palette
    // Cream: #FAF9F6, Ivory: #FFFBF2, Newsprint: #F4F1EA
    // Ink/Dark: #1A1A1A, Charcoal: #2D2D2D
    final bgColor = isDark ? const Color(0xFF121212) : const Color(0xFFFAF9F6);

    return Stack(
      children: [
        // Base Color
        Container(color: bgColor),

        // Paper Texture Overlay
        Positioned.fill(
          child: Opacity(
            opacity: isDark ? 0.05 : 0.08,
            child: Image.asset(
              'assets/images/recycled-paper.png',
              repeat: ImageRepeat.repeat,
              fit: BoxFit.none,
              // Add a slight tint to the texture to make it feel more "aged" or "deep"
              color: isDark ? Colors.white : const Color(0xFFD4C9B0),
              colorBlendMode: BlendMode.multiply,
            ),
          ),
        ),

        // Subtle Page Fold / Reading Light Glow
        Positioned(
          top: -100,
          right: -100,
          child: Container(
            width: 400,
            height: 400,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  isDark
                      ? Colors.white.withValues(alpha: 0.03)
                      : const Color(0xFFFFFAE0).withValues(alpha: 0.4),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),

        // Border/Margin Line (Editorial Feel)
        if (!isDark)
          Positioned(
            left: 40,
            top: 0,
            bottom: 0,
            child: Container(width: 1, color: const Color(0xFFE8E2D0)),
          ),
      ],
    );
  }
}
