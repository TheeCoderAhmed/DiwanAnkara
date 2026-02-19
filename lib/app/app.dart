import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../routing/app_router.dart';
import '../settings/theme_controller.dart';
import '../settings/locale_controller.dart';
import '../l10n/app_localizations.dart';

import 'theme_styles.dart';

class YCAnkaraApp extends ConsumerWidget {
  const YCAnkaraApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeControllerProvider);
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
      themeMode: themeState.mode,
      theme: AppThemeStyles.buildTheme(themeState, isDark: false),
      darkTheme: AppThemeStyles.buildTheme(themeState, isDark: true),
      routerConfig: router,
    );
  }
}
