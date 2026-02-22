import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:lucide_icons/lucide_icons.dart';

/// Reusable cached image widget with shimmer placeholder and error handling.
/// Supports both network URLs and asset paths.
class CachedImageWidget extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final IconData? errorIcon;

  const CachedImageWidget({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.errorIcon,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return _buildErrorWidget(context);
    }

    final isNetwork = imageUrl!.startsWith('http');

    Widget imageWidget;
    if (isNetwork) {
      imageWidget = CachedNetworkImage(
        imageUrl: imageUrl!,
        width: width,
        height: height,
        fit: fit,
        cacheKey: imageUrl,
        // Phase 4: Constrain in-memory decode to 2× display size.
        // Guard against double.infinity / NaN — only pass finite values.
        // When width/height is double.infinity (full-width cards), we skip the
        // hint so CachedNetworkImage uses its own default sizing instead of
        // crashing on .toInt().
        memCacheWidth: (width != null && width!.isFinite && width! > 0)
            ? (width! * 2).toInt()
            : null,
        memCacheHeight: (height != null && height!.isFinite && height! > 0)
            ? (height! * 2).toInt()
            : null,
        maxWidthDiskCache: 800, // was 1000 — still fine for high-DPI screens
        maxHeightDiskCache: 800, // was 1000
        fadeInDuration: const Duration(milliseconds: 200), // was 400
        placeholder: (context, url) => _buildShimmerPlaceholder(context),
        errorWidget: (context, url, error) => _buildErrorWidget(context),
      );
    } else {
      imageWidget = Image.asset(
        imageUrl!,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) =>
            _buildErrorWidget(context),
      );
    }

    if (borderRadius != null) {
      return ClipRRect(borderRadius: borderRadius!, child: imageWidget);
    }

    return imageWidget;
  }

  Widget _buildShimmerPlaceholder(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Shimmer.fromColors(
      baseColor: isDark ? Colors.white10 : Colors.grey[300]!,
      highlightColor: isDark ? Colors.white24 : Colors.grey[100]!,
      child: Container(width: width, height: height, color: Colors.white),
    );
  }

  Widget _buildErrorWidget(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: width,
      height: height,
      color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.grey[200],
      child: Center(
        child: Icon(
          errorIcon ?? LucideIcons.imageOff,
          color: isDark ? Colors.white24 : Colors.grey[400],
          size: (width != null && width! < 50) ? 20 : 32,
        ),
      ),
    );
  }
}
