import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class BentoCategoryCard extends StatelessWidget {
  const BentoCategoryCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
    this.isLarge = false,
  });

  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final bool isLarge;

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    final cardTheme = Theme.of(context).cardTheme;
    final shape =
        (cardTheme.shape as RoundedRectangleBorder?) ??
        RoundedRectangleBorder(
          borderRadius:
              ((Theme.of(context).cardTheme.shape as RoundedRectangleBorder?)
                  ?.borderRadius ??
              BorderRadius.circular(24)),
        );

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: cardTheme.color,
          borderRadius: shape.borderRadius,
          border: shape.side != BorderSide.none
              ? Border.fromBorderSide(shape.side)
              : (isLight
                    ? Border.all(
                        color: Colors.grey.withValues(alpha: 0.1),
                        width: 1,
                      )
                    : Border.all(
                        color: Colors.white.withValues(alpha: 0.1),
                        width: 1,
                      )),
          boxShadow: isLight
              ? cardTheme.shadowColor != null
                    ? [
                        BoxShadow(
                          color: cardTheme.shadowColor!,
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ]
              : null,
        ),
        child: Stack(
          children: [
            // Background gradient (only in dark mode)
            if (!isLight)
              Positioned(
                top: -20,
                right: -20,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        color.withValues(alpha: 0.2),
                        color.withValues(alpha: 0.0),
                      ],
                    ),
                  ),
                ),
              ),
            // Content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Icon
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isLight
                          ? color.withValues(
                              alpha: 0.1,
                            ) // Light mode: subtle background
                          : color.withValues(
                              alpha: 0.15,
                            ), // Dark mode: existing style
                      borderRadius:
                          ((Theme.of(context).cardTheme.shape
                                  as RoundedRectangleBorder?)
                              ?.borderRadius ??
                          BorderRadius.circular(16)),
                    ),
                    child: Icon(icon, color: color, size: isLarge ? 32 : 24),
                  ),
                  const Spacer(),
                  // Title
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 300.ms).slideX(begin: 0.1, end: 0);
  }
}
