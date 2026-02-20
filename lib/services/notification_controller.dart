import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../domain/models/app_notification.dart';
import '../settings/theme_controller.dart'; // Import sharedPrefsProvider from here
import 'notification_service.dart'; // Add import for NotificationService
import 'in_app_message_provider.dart'; // Add import for InAppMessage model

class NotificationController extends StateNotifier<List<AppNotification>> {
  final SharedPreferences prefs;
  static const String _storageKey = 'app_notifications';

  NotificationController(this.prefs) : super([]) {
    _loadNotifications();
  }

  void _loadNotifications() {
    final jsonStringList = prefs.getStringList(_storageKey);
    if (jsonStringList != null) {
      state =
          jsonStringList
              .map((s) => AppNotification.fromJson(json.decode(s)))
              .toList()
            ..sort(
              (a, b) => b.timestamp.compareTo(a.timestamp),
            ); // Newest first
    }
  }

  Future<void> _saveNotifications() async {
    final jsonStringList = state.map((n) => json.encode(n.toJson())).toList();
    await prefs.setStringList(_storageKey, jsonStringList);
  }

  Future<void> addNotification({
    required String title,
    required String body,
    DateTime? timestamp,
    Map<String, dynamic>? data,
    String? id,
  }) async {
    debugPrint('🔔 NotificationController: addNotification called: "$title"');
    
    final resolvedId = id ?? const Uuid().v4();
    if (state.any((n) => n.id == resolvedId)) {
      debugPrint('🔔 NotificationController: Duplicate notification ignored ($resolvedId)');
      return;
    }

    final newNotification = AppNotification(
      id: resolvedId,
      title: title,
      body: body,
      timestamp: timestamp ?? DateTime.now(),
      isRead: false,
      data: data,
    );

    debugPrint(
      '🔔 NotificationController: Updating state with Push/FCM notification',
    );
    state = [newNotification, ...state];
    await _saveNotifications();
  }

  Future<void> addFromInAppMessage(InAppMessage message) async {
    // Check if duplicate
    if (state.any((n) => n.id == message.id)) return;

    debugPrint(
      '🔔 NotificationController: addFromInAppMessage called: "${message.title}"',
    );
    final newNotification = AppNotification(
      id: message.id,
      title: message.title,
      body: message.message,
      timestamp:
          DateTime.now(), // Firestore doesn't provide timestamp in the provider currently, just a list
      isRead: false,
      data: {'link': message.link, 'type': 'in-app'},
    );

    debugPrint('🔔 NotificationController: Updating state with In-App Message');
    state = [newNotification, ...state];
    await _saveNotifications();
  }

  Future<void> deleteNotification(String id) async {
    state = state.where((n) => n.id != id).toList();
    await _saveNotifications();
  }

  Future<void> markAsRead(String id) async {
    state = state.map((n) {
      if (n.id == id) {
        return n.copyWith(isRead: true);
      }
      return n;
    }).toList();
    await _saveNotifications();
  }

  Future<void> markAllAsRead() async {
    state = state.map((n) => n.copyWith(isRead: true)).toList();
    await _saveNotifications();
  }

  Future<void> clearAll() async {
    state = [];
    await _saveNotifications();
  }

  int get unreadCount => state.where((n) => !n.isRead).length;
}

final notificationControllerProvider =
    StateNotifierProvider<NotificationController, List<AppNotification>>((ref) {
      final prefs = ref.watch(sharedPrefsProvider);
      return NotificationController(prefs);
    });

// Provider to listen to incoming FCM messages and add them to history
final notificationListenerProvider = Provider<void>((ref) {
  debugPrint('🔔 notificationListenerProvider: INITIALIZING...');
  final controller = ref.watch(notificationControllerProvider.notifier);
  // We use the singleton NotificationService directly
  final service = NotificationService();

  // Listen to FCM messages
  final fcmSubscription = service.messageStream.listen((message) {
    debugPrint(
      '🔔 notificationListenerProvider: Received FCM message from stream: ${message.messageId}',
    );
    controller.addNotification(
      id: message.messageId,
      title:
          message.notification?.title ?? message.data['title'] ?? 'إشعار جديد',
      body: message.notification?.body ?? message.data['body'] ?? '',
      timestamp: message.sentTime,
      data: message.data,
    );
  });

  ref.listen(inAppMessagesProvider, (previous, next) {
    final messages = next.valueOrNull ?? [];
    for (final msg in messages) {
      // Add all recent messages to history, even if inactive for the popup
      controller.addFromInAppMessage(msg);
    }
  });

  ref.onDispose(() {
    fcmSubscription.cancel();
  });
});
