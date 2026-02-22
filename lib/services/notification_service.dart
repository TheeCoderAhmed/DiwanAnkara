import 'dart:async';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'deep_link_service.dart';

/// Top-level function to handle background messages
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('Handling background message: ${message.messageId}');
  WidgetsFlutterBinding.ensureInitialized();

  try {
    final prefs = await SharedPreferences.getInstance();
    final jsonStringList = prefs.getStringList('app_notifications') ?? [];

    final title =
        message.notification?.title ?? message.data['title'] ?? 'إشعار جديد';
    final body = message.notification?.body ?? message.data['body'] ?? '';

    final newNotification = {
      'id':
          message.messageId ?? DateTime.now().millisecondsSinceEpoch.toString(),
      'title': title,
      'body': body,
      'timestamp': (message.sentTime ?? DateTime.now()).toIso8601String(),
      'isRead': false,
      'data': message.data,
    };

    bool isDuplicate = false;
    for (var s in jsonStringList) {
      try {
        final decoded = jsonDecode(s) as Map<String, dynamic>;
        if (decoded['id'] == newNotification['id']) {
          isDuplicate = true;
          break;
        }
      } catch (_) {}
    }

    if (!isDuplicate) {
      jsonStringList.insert(0, jsonEncode(newNotification));
      await prefs.setStringList('app_notifications', jsonStringList);
      debugPrint('Saved background notification: ${newNotification['id']}');
    }
  } catch (e) {
    debugPrint('Error handling background notification: $e');
  }
}

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // Stream to expose received messages to the UI/Controllers
  final _messageStreamController = StreamController<RemoteMessage>.broadcast();
  Stream<RemoteMessage> get messageStream => _messageStreamController.stream;

  bool _initialized = false;
  AuthorizationStatus? authorizationStatus; // To track permission status

  /// Initialize notification service
  Future<void> initialize() async {
    if (_initialized) return;

    try {
      // Request FCM permission (required for both Android 13+ and iOS)
      final settings = await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      authorizationStatus = settings.authorizationStatus;
      debugPrint('FCM permission status: ${settings.authorizationStatus}');

      if (settings.authorizationStatus == AuthorizationStatus.denied) {
        debugPrint('⚠️ Notification permission DENIED by user');
      }

      // Also request local notification permission on Android 13+
      if (defaultTargetPlatform == TargetPlatform.android) {
        final androidPlugin = _localNotifications
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >();
        final granted = await androidPlugin?.requestNotificationsPermission();
        debugPrint('Android local notification permission granted: $granted');
      }

      // Initialize local notifications plugin
      const androidSettings = AndroidInitializationSettings(
        '@drawable/ic_notification',
      );
      const iosSettings = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );

      const initSettings = InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      );

      await _localNotifications.initialize(
        initSettings,
        onDidReceiveNotificationResponse: _onNotificationTapped,
      );

      // Create Android notification channel (High Importance)
      await _createAndroidChannel();

      // Set up Firebase message handlers
      await _setupFirebaseHandlers();

      // Subscribe to default topic for all users
      await subscribeToTopic('all_users');

      // Log FCM token for debugging
      final token = await getToken();
      debugPrint('=== FCM TOKEN ===');
      debugPrint(token);
      debugPrint('=================');

      _initialized = true;
      debugPrint('✅ NotificationService initialized successfully');
      debugPrint('   Permission: ${settings.authorizationStatus}');
      debugPrint('   Topic: all_users (subscribed)');
    } catch (e, stack) {
      debugPrint('❌ Error initializing NotificationService: $e');
      debugPrint(stack.toString());
    }
  }

  /// Create Android notification channel with high importance
  Future<void> _createAndroidChannel() async {
    const androidChannel = AndroidNotificationChannel(
      'high_importance_channel', // Must match AndroidManifest.xml
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
      enableVibration: true,
      playSound: true,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(androidChannel);
  }

  /// Set up Firebase Cloud Messaging handlers
  Future<void> _setupFirebaseHandlers() async {
    // Set foreground notification presentation options
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('=== FOREGROUND MESSAGE RECEIVED ===');
      debugPrint('Message ID: ${message.messageId}');
      debugPrint('Title: ${message.notification?.title}');
      debugPrint('Body: ${message.notification?.body}');
      debugPrint('Data: ${message.data}');
      debugPrint('===================================');

      // Add to internal stream for history (across all platforms)
      _messageStreamController.add(message);

      // Show local notification only on Android
      // (iOS handles foreground notifications natively via PresentationOptions)
      if (defaultTargetPlatform == TargetPlatform.android) {
        _showLocalNotification(message);
      }
    });

    // Handle notification taps when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('Notification opened app: ${message.messageId}');
      _handleNotificationTap(message);
    });

    // Handle notification tap when app is terminated
    final initialMessage = await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      debugPrint(
        'App opened from terminated state: ${initialMessage.messageId}',
      );
      _handleNotificationTap(initialMessage);
    }

    // Set background message handler
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  /// Show local notification for foreground messages
  Future<void> _showLocalNotification(RemoteMessage message) async {
    try {
      debugPrint('Attempting to show local notification...');

      final androidDetails = AndroidNotificationDetails(
        'high_importance_channel', // Must match channel ID
        'High Importance Notifications',
        channelDescription: 'This channel is used for important notifications.',
        importance: Importance.high,
        priority: Priority.high,
        icon: '@drawable/ic_notification', // Use the drawable resource
        enableVibration: true,
        playSound: true,
      );

      const iosDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      final notificationDetails = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      final title =
          message.notification?.title ?? message.data['title'] ?? 'إشعار جديد';
      final body = message.notification?.body ?? message.data['body'] ?? '';

      debugPrint('Showing notification - Title: $title, Body: $body');

      await _localNotifications.show(
        message.hashCode,
        title,
        body,
        notificationDetails,
        payload: jsonEncode(message.data),
      );

      debugPrint('Local notification shown successfully');
    } catch (e, stackTrace) {
      debugPrint('Error showing local notification: $e');
      debugPrint('Stack trace: $stackTrace');
    }
  }

  /// Handle notification tap - extract deep link and navigate
  void _handleNotificationTap(RemoteMessage message) {
    debugPrint('Notification tapped: ${message.messageId}');
    debugPrint('Notification data: ${message.data}');

    // Add to stream (history) - handle deduplication in controller
    _messageStreamController.add(message);

    // Extract the 'link' field from the notification data payload
    final String? deepLink = message.data['link'];

    if (deepLink != null && deepLink.isNotEmpty) {
      debugPrint('Deep link found: $deepLink');
      DeepLinkService().handleDeepLink(deepLink);
    } else {
      debugPrint('No deep link in notification data');
      // You can add default navigation behavior here if needed
    }
  }

  /// Callback for local notification tap
  void _onNotificationTapped(NotificationResponse response) {
    debugPrint('Local notification tapped: ${response.id}');

    final payload = response.payload;
    if (payload != null && payload.isNotEmpty) {
      try {
        final data = jsonDecode(payload) as Map<String, dynamic>;
        final String? deepLink = data['link'];
        if (deepLink != null && deepLink.toString().isNotEmpty) {
          debugPrint(
            'Deep link found in local notification payload: $deepLink',
          );
          DeepLinkService().handleDeepLink(deepLink.toString());
        }
      } catch (e) {
        debugPrint('Error decoding local notification payload: $e');
      }
    }
  }

  /// Get FCM token
  Future<String?> getToken() async {
    try {
      return await _firebaseMessaging.getToken();
    } catch (e) {
      debugPrint('Error getting FCM token: $e');
      return null;
    }
  }

  /// Subscribe to topic
  Future<void> subscribeToTopic(String topic) async {
    if (kIsWeb) return;
    await _firebaseMessaging.subscribeToTopic(topic);
    debugPrint('Subscribed to topic: $topic');
  }

  /// Unsubscribe from topic
  Future<void> unsubscribeFromTopic(String topic) async {
    if (kIsWeb) return;
    await _firebaseMessaging.unsubscribeFromTopic(topic);
    debugPrint('Unsubscribed from topic: $topic');
  }
}
