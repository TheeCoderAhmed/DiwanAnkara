import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/app.dart';
import 'firebase_options.dart';
import 'services/notification_service.dart';
import 'settings/theme_controller.dart';
import 'package:flutter/foundation.dart';

void main() {
  runZonedGuarded(
    () {
      WidgetsFlutterBinding.ensureInitialized();
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.transparent,
        ),
      );

      // Catch synchronous Flutter framework errors (widget build errors, etc.)
      FlutterError.onError = (FlutterErrorDetails details) {
        FlutterError.presentError(details);
        debugPrint('FlutterError caught: ${details.exception}');
        debugPrint(details.stack.toString());
        // TODO: Send to crash reporting service (e.g., Firebase Crashlytics)
      };

      runApp(const AppBootstrapper());
    },
    (error, stack) {
      // Catch asynchronous errors that escape the Flutter framework
      debugPrint('runZonedGuarded caught error: $error');
      debugPrint(stack.toString());
      // TODO: Send to crash reporting service (e.g., Firebase Crashlytics)
    },
  );
}

class AppBootstrapper extends StatefulWidget {
  const AppBootstrapper({super.key});

  @override
  State<AppBootstrapper> createState() => _AppBootstrapperState();
}

class _AppBootstrapperState extends State<AppBootstrapper> {
  String? _error;
  bool _initialized = false;
  SharedPreferences? _prefs;

  @override
  void initState() {
    super.initState();
    _initServices();
  }

  Future<void> _initServices() async {
    try {
      // Initialize Hive
      await Hive.initFlutter();
      await Hive.openBox('app_cache');

      // Initialize Firebase
      try {
        if (Firebase.apps.isEmpty) {
          await Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          );
        }
      } catch (e) {
        if (e.toString().contains('duplicate-app')) {
          debugPrint('Firebase already initialized (duplicate-app caught)');
        } else {
          rethrow;
        }
      }

      // Initialize notification service
      try {
        await NotificationService().initialize();
      } catch (e) {
        debugPrint('Notification service initialization failed: $e');
      }

      // Initialize Firebase In-App Messaging
      if (!kIsWeb) {
        try {
          FirebaseInAppMessaging.instance.setMessagesSuppressed(false);
          FirebaseInAppMessaging.instance.setAutomaticDataCollectionEnabled(
            true,
          );
          debugPrint('Firebase In-App Messaging initialized');
        } catch (e) {
          debugPrint('Firebase In-App Messaging initialization failed: $e');
        }
      }

      // Load SharedPreferences
      _prefs = await SharedPreferences.getInstance();

      if (mounted) {
        setState(() {
          _initialized = true;
        });
      }
    } catch (e) {
      debugPrint('Bootstrap initialization failed: $e');
      if (mounted) {
        setState(() {
          _error = e.toString();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: const Color(0xFF0F172A),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 48),
                  const SizedBox(height: 16),
                  const Text(
                    'Initialization Error',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _error!,
                    style: const TextStyle(color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    if (!_initialized || _prefs == null) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: const Color(0xFF0F172A),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF0D9488)),
                ),
                const SizedBox(height: 24),
                Text(
                  'ديوان أنقرة...',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return ProviderScope(
      overrides: [sharedPrefsProvider.overrideWithValue(_prefs!)],
      child: const YCAnkaraApp(),
    );
  }
}
