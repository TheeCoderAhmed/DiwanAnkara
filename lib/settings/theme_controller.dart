import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _prefKeyThemeMode = 'theme_mode'; // 'system' | 'light' | 'dark'
const _prefKeyThemeStyle = 'theme_style'; // 'classic' | 'paper' | 'nordic'

enum AppStyle { classic, paper, nordic }

class ThemeState {
  final ThemeMode mode;
  final AppStyle style;

  ThemeState({required this.mode, required this.style});

  ThemeState copyWith({ThemeMode? mode, AppStyle? style}) {
    return ThemeState(mode: mode ?? this.mode, style: style ?? this.style);
  }
}

final sharedPrefsProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('sharedPrefsProvider must be overridden');
});

final themeControllerProvider =
    StateNotifierProvider<ThemeController, ThemeState>((ref) {
      final prefs = ref.watch(sharedPrefsProvider);
      return ThemeController(prefs);
    });

class ThemeController extends StateNotifier<ThemeState> {
  ThemeController(this._prefs) : super(_load(_prefs));

  final SharedPreferences _prefs;

  static ThemeState _load(SharedPreferences prefs) {
    final modeStr = prefs.getString(_prefKeyThemeMode);
    final styleStr = prefs.getString(_prefKeyThemeStyle);

    final mode = switch (modeStr) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };

    final style = switch (styleStr) {
      'paper' => AppStyle.paper,
      'nordic' => AppStyle.nordic,
      _ => AppStyle.classic,
    };

    return ThemeState(mode: mode, style: style);
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = state.copyWith(mode: mode);
    final v = switch (mode) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
    };
    await _prefs.setString(_prefKeyThemeMode, v);
  }

  Future<void> setStyle(AppStyle style) async {
    state = state.copyWith(style: style);
    final v = style.name;
    await _prefs.setString(_prefKeyThemeStyle, v);
  }
}
