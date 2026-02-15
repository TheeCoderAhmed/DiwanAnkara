import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../routing/app_router.dart';
import '../settings/theme_controller.dart';
import '../settings/locale_controller.dart';
import '../l10n/app_localizations.dart';

class YCAnkaraApp extends ConsumerWidget {
  const YCAnkaraApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeControllerProvider);
    final locale = ref.watch(localeControllerProvider);
    final router = ref.watch(goRouterProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'ديوان أنقرة',
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      themeMode: themeMode,
      theme: _buildLightTheme(),
      darkTheme: _buildDarkTheme(),
      routerConfig: router,
    );
  }

  static ThemeData _buildLightTheme() {
    // Tajawal - Beautiful Arabic font with excellent Latin support
    final baseTextTheme = GoogleFonts.tajawalTextTheme();
    
    final textTheme = baseTextTheme.copyWith(
      // Display - Large titles
      displayLarge: baseTextTheme.displayLarge?.copyWith(
        fontWeight: FontWeight.w700,
        height: 1.2,
        color: Colors.black.withValues(alpha: 0.8),
      ),
      displayMedium: baseTextTheme.displayMedium?.copyWith(
        fontWeight: FontWeight.w700,
        height: 1.2,
        color: Colors.black.withValues(alpha: 0.8),
      ),
      displaySmall: baseTextTheme.displaySmall?.copyWith(
        fontWeight: FontWeight.w700,
        height: 1.2,
        color: Colors.black.withValues(alpha: 0.8),
      ),
      // Headlines - Section headers
      headlineLarge: baseTextTheme.headlineLarge?.copyWith(
        fontWeight: FontWeight.w700,
        height: 1.2,
        color: Colors.black.withValues(alpha: 0.8),
      ),
      headlineMedium: baseTextTheme.headlineMedium?.copyWith(
        fontWeight: FontWeight.w700,
        height: 1.2,
        color: Colors.black.withValues(alpha: 0.8),
      ),
      headlineSmall: baseTextTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.w700,
        height: 1.2,
        color: Colors.black.withValues(alpha: 0.8),
      ),
      // Titles - Card titles
      titleLarge: baseTextTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w700,
        height: 1.2,
        color: Colors.black.withValues(alpha: 0.8),
      ),
      titleMedium: baseTextTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
        height: 1.3,
        color: Colors.black.withValues(alpha: 0.8),
      ),
      titleSmall: baseTextTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.w600,
        height: 1.3,
        color: Colors.black.withValues(alpha: 0.8),
      ),
      // Body - Content text with breathing room for Arabic
      bodyLarge: baseTextTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.w400,
        height: 1.6,
        color: Colors.black.withValues(alpha: 0.8),
      ),
      bodyMedium: baseTextTheme.bodyMedium?.copyWith(
        fontWeight: FontWeight.w400,
        height: 1.6,
        color: Colors.black.withValues(alpha: 0.7),
      ),
      bodySmall: baseTextTheme.bodySmall?.copyWith(
        fontWeight: FontWeight.w400,
        height: 1.6,
        color: Colors.black.withValues(alpha: 0.6),
      ),
      // Labels
      labelLarge: baseTextTheme.labelLarge?.copyWith(
        fontWeight: FontWeight.w500,
        height: 1.4,
        color: Colors.black.withValues(alpha: 0.8),
      ),
      labelMedium: baseTextTheme.labelMedium?.copyWith(
        fontWeight: FontWeight.w500,
        height: 1.4,
        color: Colors.black.withValues(alpha: 0.7),
      ),
      labelSmall: baseTextTheme.labelSmall?.copyWith(
        fontWeight: FontWeight.w500,
        height: 1.4,
        color: Colors.black.withValues(alpha: 0.6),
      ),
    );

    return ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      textTheme: textTheme,
      scaffoldBackgroundColor: const Color(0xFFF8FAFC),
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF0D9488),
        brightness: Brightness.light,
        surface: const Color(0xFFFFFFFF),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        color: const Color(0xFFFFFFFF),
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: const Color(0xFFF8FAFC),
        surfaceTintColor: Colors.transparent,
        titleTextStyle: GoogleFonts.tajawal(
          fontWeight: FontWeight.w700,
          fontSize: 20,
          color: Colors.black.withValues(alpha: 0.8),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          textStyle: GoogleFonts.tajawal(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  static ThemeData _buildDarkTheme() {
    final baseTextTheme = GoogleFonts.tajawalTextTheme(ThemeData.dark().textTheme);
    
    final textTheme = baseTextTheme.copyWith(
      // Display
      displayLarge: baseTextTheme.displayLarge?.copyWith(
        fontWeight: FontWeight.w700,
        height: 1.2,
        color: Colors.white.withValues(alpha: 0.9),
      ),
      displayMedium: baseTextTheme.displayMedium?.copyWith(
        fontWeight: FontWeight.w700,
        height: 1.2,
        color: Colors.white.withValues(alpha: 0.9),
      ),
      displaySmall: baseTextTheme.displaySmall?.copyWith(
        fontWeight: FontWeight.w700,
        height: 1.2,
        color: Colors.white.withValues(alpha: 0.9),
      ),
      // Headlines
      headlineLarge: baseTextTheme.headlineLarge?.copyWith(
        fontWeight: FontWeight.w700,
        height: 1.2,
        color: Colors.white.withValues(alpha: 0.9),
      ),
      headlineMedium: baseTextTheme.headlineMedium?.copyWith(
        fontWeight: FontWeight.w700,
        height: 1.2,
        color: Colors.white.withValues(alpha: 0.9),
      ),
      headlineSmall: baseTextTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.w700,
        height: 1.2,
        color: Colors.white.withValues(alpha: 0.9),
      ),
      // Titles
      titleLarge: baseTextTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w700,
        height: 1.2,
        color: Colors.white.withValues(alpha: 0.9),
      ),
      titleMedium: baseTextTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
        height: 1.3,
        color: Colors.white.withValues(alpha: 0.9),
      ),
      titleSmall: baseTextTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.w600,
        height: 1.3,
        color: Colors.white.withValues(alpha: 0.9),
      ),
      // Body - Arabic needs height: 1.6 for readability
      bodyLarge: baseTextTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.w400,
        height: 1.6,
        color: Colors.white.withValues(alpha: 0.9),
      ),
      bodyMedium: baseTextTheme.bodyMedium?.copyWith(
        fontWeight: FontWeight.w400,
        height: 1.6,
        color: Colors.white.withValues(alpha: 0.8),
      ),
      bodySmall: baseTextTheme.bodySmall?.copyWith(
        fontWeight: FontWeight.w400,
        height: 1.6,
        color: Colors.white.withValues(alpha: 0.7),
      ),
      // Labels
      labelLarge: baseTextTheme.labelLarge?.copyWith(
        fontWeight: FontWeight.w500,
        height: 1.4,
        color: Colors.white.withValues(alpha: 0.9),
      ),
      labelMedium: baseTextTheme.labelMedium?.copyWith(
        fontWeight: FontWeight.w500,
        height: 1.4,
        color: Colors.white.withValues(alpha: 0.8),
      ),
      labelSmall: baseTextTheme.labelSmall?.copyWith(
        fontWeight: FontWeight.w500,
        height: 1.4,
        color: Colors.white.withValues(alpha: 0.7),
      ),
    );

    return ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      textTheme: textTheme,
      scaffoldBackgroundColor: const Color(0xFF0F172A),
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF0D9488),
        brightness: Brightness.dark,
        surface: const Color(0xFF1E293B),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        color: const Color(0xFF1E293B),
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: const Color(0xFF0F172A),
        surfaceTintColor: Colors.transparent,
        titleTextStyle: GoogleFonts.tajawal(
          fontWeight: FontWeight.w700,
          fontSize: 20,
          color: Colors.white.withValues(alpha: 0.9),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          textStyle: GoogleFonts.tajawal(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
