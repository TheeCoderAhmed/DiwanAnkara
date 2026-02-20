import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/translation_service.dart';
import 'theme_controller.dart';

const _prefKeyLocale = 'app_locale'; // 'ar' | 'en' | 'tr'

final localeControllerProvider =
    StateNotifierProvider<LocaleController, Locale?>((ref) {
      final prefs = ref.watch(sharedPrefsProvider);
      return LocaleController(prefs);
    });

class LocaleController extends StateNotifier<Locale?> {
  LocaleController(this._prefs) : super(_load(_prefs));

  final SharedPreferences _prefs;

  static Locale? _load(SharedPreferences prefs) {
    final v = prefs.getString(_prefKeyLocale);
    if (v == null) return null; // Default to null (follows system)
    return Locale(v);
  }

  Future<void> setLocale(Locale? locale) async {
    state = locale;
    if (locale == null) {
      await _prefs.remove(_prefKeyLocale);
    } else {
      await _prefs.setString(_prefKeyLocale, locale.languageCode);

      // Trigger model download for the new locale
      TranslationService().downloadModel(locale.languageCode).then((success) {
        if (success) {
          debugPrint(
            'Translation model for ${locale.languageCode} ensures to be available.',
          );
        }
      });
    }
  }
}
