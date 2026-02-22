import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../settings/theme_controller.dart';

class AppThemeStyles {
  static ThemeData buildTheme(ThemeState themeState, {bool isDark = false}) {
    return switch (themeState.style) {
      AppStyle.classic => _buildClassicTheme(isDark),
      AppStyle.paper => _buildPaperTheme(isDark),
      AppStyle.nordic => _buildNordicTheme(isDark),
    };
  }

  // ─────────────────────────────────────────────────────────────────────────
  // 🌊  CLASSIC — Dark Teal Glassmorphic
  //     Identity: fluid teal-cyan gradients, large border-radii, glassy cards
  // ─────────────────────────────────────────────────────────────────────────
  static ThemeData _buildClassicTheme(bool isDark) {
    final baseTextTheme = GoogleFonts.tajawalTextTheme(
      isDark ? ThemeData.dark().textTheme : ThemeData.light().textTheme,
    );

    const seedTeal = Color(0xFF0D9488);
    const seedCyan = Color(0xFF06B6D4);

    final colorScheme = ColorScheme.fromSeed(
      seedColor: seedTeal,
      brightness: isDark ? Brightness.dark : Brightness.light,
      surface: isDark ? const Color(0xFF1E293B) : const Color(0xFFFFFFFF),
      primary: seedTeal,
      secondary: seedCyan,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: isDark ? Brightness.dark : Brightness.light,
      textTheme: _applyArabicMetrics(baseTextTheme, isDark).copyWith(
        // Extra punch on headlines
        titleLarge: GoogleFonts.tajawal(
          fontWeight: FontWeight.w900,
          fontSize: 22,
          color: isDark
              ? Colors.white.withValues(alpha: 0.95)
              : const Color(0xFF0F172A),
        ),
      ),
      scaffoldBackgroundColor: isDark
          ? const Color(0xFF0F172A)
          : const Color(0xFFF0FDFA), // Light teal tint instead of plain white
      colorScheme: colorScheme,
      cardTheme: CardThemeData(
        elevation: 0,
        color: isDark
            ? Colors.white.withValues(alpha: 0.06)
            : Colors.white.withValues(alpha: 0.85),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(
            // Thin teal shimmer rim
            color: isDark
                ? seedTeal.withValues(alpha: 0.18)
                : seedTeal.withValues(alpha: 0.12),
            width: 1,
          ),
        ),
        shadowColor: seedTeal.withValues(alpha: 0.12),
      ),
      // FilledButton = teal→cyan gradient via ButtonStyle
      filledButtonTheme: FilledButtonThemeData(
        style:
            ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith(
                (_) => Colors.transparent,
              ),
              foregroundColor: WidgetStateProperty.all(Colors.white),
              overlayColor: WidgetStateProperty.all(
                Colors.white.withValues(alpha: 0.08),
              ),
              elevation: WidgetStateProperty.all(0),
              padding: WidgetStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              ),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ).copyWith(
              // Gradient trick via DecoratedBox — applied via surfaceTintColor workaround
              // Real gradient is applied in the CTA widgets via GradientFilledButton helper
              shadowColor: WidgetStateProperty.all(
                seedTeal.withValues(alpha: 0.4),
              ),
              elevation: WidgetStateProperty.resolveWith(
                (s) => s.contains(WidgetState.pressed) ? 0 : 4,
              ),
            ),
      ),
      dividerTheme: DividerThemeData(
        color: seedTeal.withValues(alpha: 0.15),
        thickness: 1,
        space: 24,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        // Thin teal accent bottom border rendered by the scaffold decor
        systemOverlayStyle: isDark
            ? SystemUiOverlayStyle.light.copyWith(
                statusBarColor: Colors.transparent,
                systemNavigationBarColor: Colors.transparent,
                systemNavigationBarIconBrightness: Brightness.light,
              )
            : SystemUiOverlayStyle.dark.copyWith(
                statusBarColor: Colors.transparent,
                systemNavigationBarColor: Colors.transparent,
                systemNavigationBarIconBrightness: Brightness.dark,
              ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: seedTeal.withValues(alpha: 0.08),
        selectedColor: seedTeal.withValues(alpha: 0.2),
        side: BorderSide(color: seedTeal.withValues(alpha: 0.25)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // 📰  PAPER — Editorial Ink
  //     Identity: ruled lines, sepia tones, sharp corners, ink accents,
  //               Amiri serif headlines, newspaper-style section headers
  // ─────────────────────────────────────────────────────────────────────────
  static ThemeData _buildPaperTheme(bool isDark) {
    final baseLightTextTheme = ThemeData.light().textTheme;
    final baseDarkTextTheme = ThemeData.dark().textTheme;
    final baseTheme = isDark ? baseDarkTextTheme : baseLightTextTheme;

    final textTheme = baseTheme.copyWith(
      displayLarge: GoogleFonts.amiri(textStyle: baseTheme.displayLarge),
      displayMedium: GoogleFonts.amiri(textStyle: baseTheme.displayMedium),
      displaySmall: GoogleFonts.amiri(textStyle: baseTheme.displaySmall),
      headlineLarge: GoogleFonts.amiri(
        textStyle: baseTheme.headlineLarge,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: GoogleFonts.amiri(
        textStyle: baseTheme.headlineMedium,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: GoogleFonts.amiri(
        textStyle: baseTheme.headlineSmall,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: GoogleFonts.amiri(
        textStyle: baseTheme.titleLarge,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: GoogleFonts.amiri(
        textStyle: baseTheme.titleMedium,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: GoogleFonts.amiri(
        textStyle: baseTheme.titleSmall,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: GoogleFonts.tajawal(
        textStyle: baseTheme.bodyLarge,
        color: isDark ? const Color(0xFFCDCDCD) : const Color(0xFF3D2B1F),
        height: 1.7,
      ),
      bodyMedium: GoogleFonts.tajawal(
        textStyle: baseTheme.bodyMedium,
        color: isDark ? const Color(0xFFAAAAAA) : const Color(0xFF5C4033),
        height: 1.7,
      ),
      bodySmall: GoogleFonts.tajawal(
        textStyle: baseTheme.bodySmall,
        color: isDark ? const Color(0xFF888888) : const Color(0xFF7A5C4A),
      ),
      labelLarge: GoogleFonts.tajawal(
        textStyle: baseTheme.labelLarge,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.4, // newspaper section label
      ),
      labelMedium: GoogleFonts.tajawal(
        textStyle: baseTheme.labelMedium,
        letterSpacing: 1.2,
      ),
      labelSmall: GoogleFonts.tajawal(
        textStyle: baseTheme.labelSmall,
        letterSpacing: 1.5,
      ),
    );

    // Dark Paper palette — clean near-black with light grey ink
    // Background: near-black graphite  (#0F0F0F)
    // Card:       dark grey surface    (#1A1A1A)
    // Primary:    light grey ink       (#E4E4E4)
    // Accent:     muted sepia highlight(#C49A6C) — only for interactive elements
    // Border:     subtle grey rule     (#2E2E2E)
    final bgColor =
        isDark ? const Color(0xFF0F0F0F) : const Color(0xFFFAF8F1);
    final cardColor =
        isDark ? const Color(0xFF1A1A1A) : const Color(0xFFFFFDF5);
    final inkPrimary =
        isDark ? const Color(0xFFE4E4E4) : const Color(0xFF1A1008);
    final accentInk =
        isDark ? const Color(0xFFC49A6C) : const Color(0xFF8B4513);
    final borderInk =
        isDark ? const Color(0xFF2E2E2E) : const Color(0xFFDDD8C4);

    return ThemeData(
      useMaterial3: true,
      brightness: isDark ? Brightness.dark : Brightness.light,
      textTheme: _applyArabicMetrics(textTheme, isDark),
      scaffoldBackgroundColor: bgColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: accentInk,
        brightness: isDark ? Brightness.dark : Brightness.light,
        surface: cardColor,
        primary: inkPrimary,
        secondary: accentInk,
        tertiary: const Color(0xFF6B4C35),
        outline: borderInk,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: cardColor,
        shape: RoundedRectangleBorder(
          // Ultra-sharp paper-cut corners
          borderRadius: BorderRadius.circular(2),
          side: BorderSide(color: borderInk, width: 0.75),
        ),
        // Left-side ink border applied per-card via decoration
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      ),
      // Flat, ink-style filled buttons
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: inkPrimary,
          foregroundColor: isDark ? const Color(0xFF111008) : Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ), // Fully square
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          elevation: 0,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: cardColor,
          foregroundColor: inkPrimary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2),
            side: BorderSide(color: borderInk),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: bgColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.amiri(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: inkPrimary,
        ),
        systemOverlayStyle: isDark
            ? SystemUiOverlayStyle.light.copyWith(
                statusBarColor: Colors.transparent,
                systemNavigationBarColor: Colors.transparent,
                systemNavigationBarIconBrightness: Brightness.light,
              )
            : SystemUiOverlayStyle.dark.copyWith(
                statusBarColor: Colors.transparent,
                systemNavigationBarColor: Colors.transparent,
                systemNavigationBarIconBrightness: Brightness.dark,
              ),
      ),
      dividerTheme: DividerThemeData(color: borderInk, thickness: 1, space: 24),
      chipTheme: ChipThemeData(
        backgroundColor: accentInk.withValues(alpha: 0.08),
        selectedColor: accentInk.withValues(alpha: 0.2),
        side: BorderSide(color: borderInk),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(2)),
        ),
        labelStyle: GoogleFonts.tajawal(
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? const Color(0xFF1C1A12) : const Color(0xFFFFFDF5),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: borderInk),
          borderRadius: BorderRadius.circular(2),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderInk),
          borderRadius: BorderRadius.circular(2),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: accentInk, width: 1.5),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // ❄️  NORDIC — Muted Indigo Minimal
  //     Identity: cool indigo, whitespace, structured grid, IBM Plex Sans,
  //               rectangular indicators, semi-transparent frosted cards
  // ─────────────────────────────────────────────────────────────────────────
  static ThemeData _buildNordicTheme(bool isDark) {
    final baseTextTheme = GoogleFonts.ibmPlexSansArabicTextTheme(
      isDark ? ThemeData.dark().textTheme : ThemeData.light().textTheme,
    );

    final bgColor = isDark ? const Color(0xFF0B0E14) : const Color(0xFFF9FAFB);
    final primary = isDark ? const Color(0xFF818CF8) : const Color(0xFF4F46E5);
    const accent = Color(0xFF6366F1);
    final surface = isDark ? const Color(0xFF1F2937) : Colors.white;
    final cardBorder = isDark
        ? Colors.white.withValues(alpha: 0.06)
        : Colors.black.withValues(alpha: 0.06);

    // Nordic uses w300 body, w700 display — maximum contrast of weights
    final nordicTextTheme = baseTextTheme.copyWith(
      headlineLarge: GoogleFonts.ibmPlexSansArabic(
        textStyle: baseTextTheme.headlineLarge,
        fontWeight: FontWeight.w700,
      ),
      headlineMedium: GoogleFonts.ibmPlexSansArabic(
        textStyle: baseTextTheme.headlineMedium,
        fontWeight: FontWeight.w700,
      ),
      headlineSmall: GoogleFonts.ibmPlexSansArabic(
        textStyle: baseTextTheme.headlineSmall,
        fontWeight: FontWeight.w700,
      ),
      titleLarge: GoogleFonts.ibmPlexSansArabic(
        textStyle: baseTextTheme.titleLarge,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: GoogleFonts.ibmPlexSansArabic(
        textStyle: baseTextTheme.titleMedium,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: GoogleFonts.ibmPlexSansArabic(
        textStyle: baseTextTheme.titleSmall,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: GoogleFonts.ibmPlexSansArabic(
        textStyle: baseTextTheme.bodyLarge,
        fontWeight: FontWeight.w300, // light body
        height: 1.65,
      ),
      bodyMedium: GoogleFonts.ibmPlexSansArabic(
        textStyle: baseTextTheme.bodyMedium,
        fontWeight: FontWeight.w300,
        height: 1.65,
      ),
      bodySmall: GoogleFonts.ibmPlexSansArabic(
        textStyle: baseTextTheme.bodySmall,
        fontWeight: FontWeight.w300,
      ),
      labelLarge: GoogleFonts.ibmPlexSansArabic(
        textStyle: baseTextTheme.labelLarge,
        fontWeight: FontWeight.w600,
        letterSpacing: 2.5,
      ), // tight structured labels
      labelMedium: GoogleFonts.ibmPlexSansArabic(
        textStyle: baseTextTheme.labelMedium,
        letterSpacing: 2.0,
      ),
      labelSmall: GoogleFonts.ibmPlexSansArabic(
        textStyle: baseTextTheme.labelSmall,
        letterSpacing: 2.5,
        fontWeight: FontWeight.w600,
      ),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: isDark ? Brightness.dark : Brightness.light,
      textTheme: _applyArabicMetrics(nordicTextTheme, isDark),
      scaffoldBackgroundColor: bgColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        brightness: isDark ? Brightness.dark : Brightness.light,
        surface: surface,
        primary: primary,
        secondary: accent,
        tertiary: const Color(0xFF2DD4BF),
        onSurface: isDark
            ? Colors.white.withValues(alpha: 0.9)
            : const Color(0xFF111827),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        // Structural radius — not as round as Classic, not as sharp as Paper
        color: isDark
            ? surface.withValues(alpha: 0.6)
            : surface.withValues(alpha: 0.9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: cardBorder, width: 1),
        ),
        margin: const EdgeInsets.symmetric(vertical: 4),
      ),
      // Outlined-first buttons for the minimal Nordic feel
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: isDark
              ? const Color(0xFF374151)
              : const Color(0xFF111827),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primary,
          side: BorderSide(color: primary),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: isDark
            ? Colors.white.withValues(alpha: 0.08)
            : Colors.black.withValues(alpha: 0.06),
        thickness: 1,
        space: 32,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: primary.withValues(alpha: 0.08),
        selectedColor: primary.withValues(alpha: 0.18),
        side: BorderSide(color: primary.withValues(alpha: 0.3)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        labelStyle: GoogleFonts.ibmPlexSansArabic(
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark
            ? Colors.white.withValues(alpha: 0.04)
            : Colors.black.withValues(alpha: 0.03),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: cardBorder),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: cardBorder),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primary, width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),
        labelStyle: GoogleFonts.ibmPlexSansArabic(letterSpacing: 0.5),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.ibmPlexSansArabic(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
          color: isDark ? Colors.white : const Color(0xFF111827),
        ),
        systemOverlayStyle: isDark
            ? SystemUiOverlayStyle.light.copyWith(
                statusBarColor: Colors.transparent,
                systemNavigationBarColor: Colors.transparent,
                systemNavigationBarIconBrightness: Brightness.light,
              )
            : SystemUiOverlayStyle.dark.copyWith(
                statusBarColor: Colors.transparent,
                systemNavigationBarColor: Colors.transparent,
                systemNavigationBarIconBrightness: Brightness.dark,
              ),
      ),
    );
  }

  // Helper to get base TextTheme without a full GoogleFonts call
  static TextTheme baseTheme(bool isDark) =>
      isDark ? ThemeData.dark().textTheme : ThemeData.light().textTheme;

  static TextTheme _applyArabicMetrics(TextTheme base, bool isDark) {
    final color = isDark
        ? Colors.white.withValues(alpha: 0.9)
        : Colors.black.withValues(alpha: 0.85);
    return base.copyWith(
      displayLarge: base.displayLarge?.copyWith(height: 1.3, color: color),
      displayMedium: base.displayMedium?.copyWith(height: 1.3, color: color),
      displaySmall: base.displaySmall?.copyWith(height: 1.3, color: color),
      headlineLarge: base.headlineLarge?.copyWith(height: 1.3, color: color),
      headlineMedium: base.headlineMedium?.copyWith(height: 1.3, color: color),
      headlineSmall: base.headlineSmall?.copyWith(height: 1.3, color: color),
      titleLarge: base.titleLarge?.copyWith(height: 1.4, color: color),
      titleMedium: base.titleMedium?.copyWith(height: 1.4, color: color),
      titleSmall: base.titleSmall?.copyWith(height: 1.4, color: color),
      bodyLarge: base.bodyLarge?.copyWith(
        height: 1.6,
        color: color.withValues(alpha: 0.85),
      ),
      bodyMedium: base.bodyMedium?.copyWith(
        height: 1.6,
        color: color.withValues(alpha: 0.75),
      ),
      bodySmall: base.bodySmall?.copyWith(
        height: 1.6,
        color: color.withValues(alpha: 0.65),
      ),
    );
  }
}
