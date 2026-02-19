import 'package:flutter/material.dart';
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

  static ThemeData _buildClassicTheme(bool isDark) {
    final baseTextTheme = GoogleFonts.tajawalTextTheme(
      isDark ? ThemeData.dark().textTheme : ThemeData.light().textTheme,
    );
    
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF0D9488),
      brightness: isDark ? Brightness.dark : Brightness.light,
      surface: isDark ? const Color(0xFF1E293B) : const Color(0xFFFFFFFF),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: isDark ? Brightness.dark : Brightness.light,
      textTheme: _applyArabicMetrics(baseTextTheme, isDark),
      scaffoldBackgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC),
      colorScheme: colorScheme,
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
    );
  }

  static ThemeData _buildPaperTheme(bool isDark) {
    // Amiri for headlines, Tajawal for body
    final baseLightTextTheme = ThemeData.light().textTheme;
    final baseDarkTextTheme = ThemeData.dark().textTheme;
    final baseTheme = isDark ? baseDarkTextTheme : baseLightTextTheme;

    final textTheme = baseTheme.copyWith(
      displayLarge: GoogleFonts.amiri(textStyle: baseTheme.displayLarge),
      displayMedium: GoogleFonts.amiri(textStyle: baseTheme.displayMedium),
      displaySmall: GoogleFonts.amiri(textStyle: baseTheme.displaySmall),
      headlineLarge: GoogleFonts.amiri(textStyle: baseTheme.headlineLarge, fontWeight: FontWeight.bold),
      headlineMedium: GoogleFonts.amiri(textStyle: baseTheme.headlineMedium, fontWeight: FontWeight.bold),
      headlineSmall: GoogleFonts.amiri(textStyle: baseTheme.headlineSmall, fontWeight: FontWeight.bold),
      titleLarge: GoogleFonts.amiri(textStyle: baseTheme.titleLarge, fontWeight: FontWeight.bold),
      titleMedium: GoogleFonts.amiri(textStyle: baseTheme.titleMedium, fontWeight: FontWeight.bold),
      titleSmall: GoogleFonts.amiri(textStyle: baseTheme.titleSmall, fontWeight: FontWeight.bold),
      bodyLarge: GoogleFonts.tajawal(textStyle: baseTheme.bodyLarge),
      bodyMedium: GoogleFonts.tajawal(textStyle: baseTheme.bodyMedium),
      bodySmall: GoogleFonts.tajawal(textStyle: baseTheme.bodySmall),
    );

    final bgColor = isDark ? const Color(0xFF121212) : const Color(0xFFFAF9F6);
    final cardColor = isDark ? const Color(0xFF1E1E1E) : const Color(0xFFFFFFFF);
    final accentInk = isDark ? const Color(0xFFD4A373) : const Color(0xFF8B4513); // Saddle Brown/Sepia Ink

    return ThemeData(
      useMaterial3: true,
      brightness: isDark ? Brightness.dark : Brightness.light,
      textTheme: _applyArabicMetrics(textTheme, isDark),
      scaffoldBackgroundColor: bgColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: accentInk,
        brightness: isDark ? Brightness.dark : Brightness.light,
        surface: cardColor,
        primary: isDark ? const Color(0xFFE2E2E2) : const Color(0xFF1A1A1A),
        secondary: accentInk,
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        shadowColor: isDark ? Colors.black45 : const Color(0xFFD4C9B0).withValues(alpha: 0.3),
        color: cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2), // Very sharp, paper-cut edges
          side: BorderSide(
            color: isDark ? Colors.white10 : const Color(0xFFE8E2D0),
            width: 0.5,
          ),
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
          color: isDark ? Colors.white : const Color(0xFF1A1A1A),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: isDark ? Colors.white10 : const Color(0xFFE8E2D0),
        thickness: 1,
        space: 24,
      ),
    );
  }

  static ThemeData _buildNordicTheme(bool isDark) {
    // Inter-like feel with IBM Plex Sans Arabic for better readability
    final baseTextTheme = GoogleFonts.ibmPlexSansArabicTextTheme(
      isDark ? ThemeData.dark().textTheme : ThemeData.light().textTheme,
    );

    final bgColor = isDark ? const Color(0xFF0B0E14) : const Color(0xFFF9FAFB);
    final primary = isDark ? const Color(0xFF818CF8) : const Color(0xFF4F46E5);
    final surface = isDark ? const Color(0xFF1F2937) : Colors.white;

    return ThemeData(
      useMaterial3: true,
      brightness: isDark ? Brightness.dark : Brightness.light,
      textTheme: _applyArabicMetrics(baseTextTheme, isDark),
      scaffoldBackgroundColor: bgColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        brightness: isDark ? Brightness.dark : Brightness.light,
        surface: surface,
        primary: primary,
        onSurface: isDark ? Colors.white.withValues(alpha: 0.9) : const Color(0xFF1F2937),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: surface.withValues(alpha: isDark ? 0.7 : 0.8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(
            color: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.05),
            width: 1,
          ),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.ibmPlexSansArabic(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: isDark ? Colors.white : const Color(0xFF1F2937),
        ),
      ),
    );
  }

  static TextTheme _applyArabicMetrics(TextTheme base, bool isDark) {
    // Arabic needs more line height to breathe
    final color = isDark ? Colors.white.withValues(alpha: 0.9) : Colors.black.withValues(alpha: 0.8);
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
      bodyLarge: base.bodyLarge?.copyWith(height: 1.6, color: color.withValues(alpha: 0.8)),
      bodyMedium: base.bodyMedium?.copyWith(height: 1.6, color: color.withValues(alpha: 0.7)),
      bodySmall: base.bodySmall?.copyWith(height: 1.6, color: color.withValues(alpha: 0.6)),
    );
  }
}
