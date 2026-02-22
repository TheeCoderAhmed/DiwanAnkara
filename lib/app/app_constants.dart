import 'package:flutter/material.dart';

/// Global layout constants for the YC Ankara app.
///
/// Use [AppSpacing.of(context)] for responsive, screen-adaptive versions
/// of these values. The constants here are the baseline (phone-sized) values.
abstract final class AppConstants {
  // ── Horizontal screen padding (used by all screens) ──────────────────────
  static const double screenPadding = 20.0;

  // ── Card / item spacing ───────────────────────────────────────────────────
  static const double cardSpacing = 12.0;

  // ── Vertical section gap ─────────────────────────────────────────────────
  static const double sectionSpacing = 24.0;

  // ── Icon container sizes ─────────────────────────────────────────────────
  static const double iconContainerSm = 36.0;
  static const double iconContainerMd = 44.0;
  static const double iconContainerLg = 56.0;

  // ── Border radii ──────────────────────────────────────────────────────────
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 24.0;
  static const double radiusFull = 999.0;

  // ── Animation durations ───────────────────────────────────────────────────
  static const Duration durationFast = Duration(milliseconds: 150);
  static const Duration durationNormal = Duration(milliseconds: 300);
  static const Duration durationSlow = Duration(milliseconds: 500);

  // ── Responsive breakpoints ────────────────────────────────────────────────
  /// Compact phone (< 360px — e.g., Galaxy A03)
  static const double breakpointCompact = 360.0;

  /// Standard phone (360–599px — most Android phones, iPhone)
  static const double breakpointPhone = 600.0;

  /// Tablet / large phone (>= 600px — iPad, Android tablet, Fold outer)
  static const double breakpointTablet = 900.0;
}

/// Adaptive spacing that scales with the device's logical screen width.
///
/// Usage:
/// ```dart
/// final sp = AppSpacing.of(context);
/// Padding(padding: EdgeInsets.symmetric(horizontal: sp.screenPadding))
/// ```
///
/// All values clamp between a minimum (compact phone) and maximum (tablet)
/// to ensure content never becomes too narrow or too wide.
class AppSpacing {
  const AppSpacing._({
    required this.screenPadding,
    required this.cardSpacing,
    required this.sectionSpacing,
    required this.itemSpacing,
    required this.iconContainerSm,
    required this.iconContainerMd,
    required this.iconContainerLg,
    required this.screenWidth,
    required this.isCompact,
    required this.isTablet,
    required this.contentMaxWidth,
  });

  /// Creates an [AppSpacing] instance from the current [BuildContext].
  factory AppSpacing.of(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    final isCompact = width < AppConstants.breakpointCompact;
    final isTablet = width >= AppConstants.breakpointPhone;

    // Scale factor: 0.85 on tiny phones → 1.0 on standard → 1.25 on tablets
    final scale = isCompact
        ? 0.85
        : isTablet
        ? 1.2
        : 1.0;

    return AppSpacing._(
      screenWidth: width,
      isCompact: isCompact,
      isTablet: isTablet,
      // Horizontal screen padding: 16 on tiny, 20 on phone, 32 on tablet
      screenPadding: (AppConstants.screenPadding * scale).clamp(16.0, 40.0),
      // Card-to-card gap
      cardSpacing: (AppConstants.cardSpacing * scale).clamp(8.0, 20.0),
      // Between sections
      sectionSpacing: (AppConstants.sectionSpacing * scale).clamp(16.0, 40.0),
      // Between list items
      itemSpacing: (8.0 * scale).clamp(6.0, 14.0),
      // Icon containers
      iconContainerSm: (AppConstants.iconContainerSm * scale).clamp(32.0, 48.0),
      iconContainerMd: (AppConstants.iconContainerMd * scale).clamp(40.0, 56.0),
      iconContainerLg: (AppConstants.iconContainerLg * scale).clamp(48.0, 72.0),
      // On tablets, constrain content to a readable column width
      contentMaxWidth: isTablet ? width * 0.75 : double.infinity,
    );
  }

  final double screenWidth;
  final bool isCompact;
  final bool isTablet;

  final double screenPadding;
  final double cardSpacing;
  final double sectionSpacing;
  final double itemSpacing;
  final double iconContainerSm;
  final double iconContainerMd;
  final double iconContainerLg;

  /// On tablets, content is centred within this max width.
  /// On phones it's [double.infinity] (full width).
  final double contentMaxWidth;

  // ── Convenience EdgeInsets ────────────────────────────────────────────────

  /// Left/right screen-edge padding (most screens & lists)
  EdgeInsets get hScreen => EdgeInsets.symmetric(horizontal: screenPadding);

  /// Standard card interior padding
  EdgeInsets get cardInner => EdgeInsets.all(screenPadding * 0.8);

  /// Section padding (top + horizontal)
  EdgeInsets get section =>
      EdgeInsets.fromLTRB(screenPadding, sectionSpacing, screenPadding, 0);
}

/// Extension for quick access anywhere you have a [BuildContext].
extension AppSpacingContext on BuildContext {
  AppSpacing get spacing => AppSpacing.of(this);
}
