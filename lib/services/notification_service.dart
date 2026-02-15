import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart';

import 'deep_link_service.dart';


/// Top-level function to handle background messages
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('Handling background message: ${message.messageId}');
  // Handle background message here
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
            .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
        final granted = await androidPlugin?.requestNotificationsPermission();
        debugPrint('Android local notification permission granted: $granted');
      }

      // Initialize local notifications plugin
      const androidSettings = AndroidInitializationSettings('@drawable/ic_notification');
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
            AndroidFlutterLocalNotificationsPlugin>()
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
      _showLocalNotification(message);
    });

    // Handle notification taps when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('Notification opened app: ${message.messageId}');
      _handleNotificationTap(message);
    });

    // Handle notification tap when app is terminated
    final initialMessage = await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      debugPrint('App opened from terminated state: ${initialMessage.messageId}');
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

      final title = message.notification?.title ?? message.data['title'] ?? 'New Notification';
      final body = message.notification?.body ?? message.data['body'] ?? '';
      
      debugPrint('Showing notification - Title: $title, Body: $body');

      // Add to internal stream for history
      _messageStreamController.add(message);

      await _localNotifications.show(
        message.hashCode,
        title,
        body,
        notificationDetails,
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
    // Handle local notification tap
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
    await _firebaseMessaging.subscribeToTopic(topic);
    debugPrint('Subscribed to topic: $topic');
  }

  /// Unsubscribe from topic
  Future<void> unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
    debugPrint('Unsubscribed from topic: $topic');
  }
}

