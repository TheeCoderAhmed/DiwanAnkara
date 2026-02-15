import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yc_ankara_app/settings/theme_controller.dart';

void main() {
  group('ThemeController', () {
    test('initializes with system default when no pref set', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final controller = ThemeController(prefs);
      expect(controller.state, ThemeMode.system);
    });

    test('loads light mode from prefs', () async {
      SharedPreferences.setMockInitialValues({'theme_mode': 'light'});
      final prefs = await SharedPreferences.getInstance();
      final controller = ThemeController(prefs);
      expect(controller.state, ThemeMode.light);
    });

    test('loads dark mode from prefs', () async {
      SharedPreferences.setMockInitialValues({'theme_mode': 'dark'});
      final prefs = await SharedPreferences.getInstance();
      final controller = ThemeController(prefs);
      expect(controller.state, ThemeMode.dark);
    });

    test('saves theme mode', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final controller = ThemeController(prefs);
      
      await controller.setThemeMode(ThemeMode.dark);
      expect(controller.state, ThemeMode.dark);
      expect(prefs.getString('theme_mode'), 'dark');
    });
  });
}
