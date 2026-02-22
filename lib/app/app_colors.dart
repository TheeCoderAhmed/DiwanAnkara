import 'package:flutter/material.dart';

/// Centralized color utilities for the YC Ankara app.
///
/// Always prefer [AppColors.primary] (context-aware) inside widget build
/// methods and [AppColors.primaryFallback] only where BuildContext is
/// unavailable (e.g. theme definitions).
abstract final class AppColors {
  /// Static fallback — use ONLY in theme files where BuildContext is unavailable.
  static const Color primaryFallback = Color(0xFF0D9488);

  // ── Context-aware accessors ──────────────────────────────────────────────

  /// The app-wide primary color derived from the current theme.
  /// In Classic it resolves to teal, Paper to sepia, Nordic to indigo.
  static Color primary(BuildContext context) =>
      Theme.of(context).colorScheme.primary;

  static Color onPrimary(BuildContext context) =>
      Theme.of(context).colorScheme.onPrimary;

  static Color surface(BuildContext context) =>
      Theme.of(context).colorScheme.surface;

  static Color onSurface(BuildContext context) =>
      Theme.of(context).colorScheme.onSurface;

  static Color secondary(BuildContext context) =>
      Theme.of(context).colorScheme.secondary;

  // ── Semantic named colors (context-aware) ────────────────────────────────

  /// Subtle tinted fill for icon containers / chips using primary color.
  static Color primaryContainer(
    BuildContext context, {
    double opacity = 0.12,
  }) => primary(context).withValues(alpha: opacity);

  /// Muted text color (body secondary).
  static Color mutedText(BuildContext context) =>
      onSurface(context).withValues(alpha: 0.5);

  /// Border color appropriate for the current brightness.
  static Color border(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark
        ? Colors.white.withValues(alpha: 0.10)
        : Colors.black.withValues(alpha: 0.10);
  }

  // ── Category semantic colors (independent of theme) ──────────────────────

  static const Color categoryUniversity = Color(0xFF6366F1);
  static const Color categoryHospital = Color(0xFFEF4444);
  static const Color categoryRestaurant = Color(0xFFF59E0B);
  static const Color categoryMall = Color(0xFF8B5CF6);
  static const Color categoryMarket = Color(0xFF10B981);
  static const Color categoryHistoric = Color(0xFF92400E);
  static const Color categoryLibrary = Color(0xFF2563EB);
  static const Color categoryTransport = Color(0xFFF97316);
  static const Color categoryGovOffice = Color(0xFF64748B);
  static const Color categoryParks = Color(0xFF22C55E);
  static const Color categoryActivities = Color(0xFFEC4899);
  static const Color categoryHousing = Color(0xFF14B8A6);
  static const Color categoryResidency = Color(0xFFDC2626);

  // ── Status colors ─────────────────────────────────────────────────────────

  static const Color statusSuccess = Color(0xFF22C55E);
  static const Color statusWarning = Color(0xFFF59E0B);
  static const Color statusDanger = Color(0xFFEF4444);
  static const Color statusNeutral = Color(0xFF64748B);
}
