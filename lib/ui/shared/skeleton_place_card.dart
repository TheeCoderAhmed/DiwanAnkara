import 'package:flutter/material.dart';
import '../shared/shimmer_wrapper.dart';

/// 6.3 — Skeleton using the shared ShimmerWrapper (no duplicated color logic).
class SkeletonPlaceCard extends StatelessWidget {
  const SkeletonPlaceCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark ? const Color(0xFF2A2A2A) : Colors.grey.shade300;

    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image skeleton
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            child: ShimmerWrapper(
              child: Container(
                height: 120,
                width: double.infinity,
                color: baseColor,
              ),
            ),
          ),
          // Content skeleton
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerWrapper(
                  child: Container(
                    height: 20,
                    width: 200,
                    decoration: BoxDecoration(
                      color: baseColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                ShimmerWrapper(
                  child: Container(
                    height: 16,
                    width: 120,
                    decoration: BoxDecoration(
                      color: baseColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
