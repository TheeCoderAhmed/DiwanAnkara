import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Model for in-app message from Firestore
class InAppMessage {
  final String id;
  final String title;
  final String message;
  final String layout; // 'card', 'modal', 'image-only', 'top-banner'
  final String backgroundColor;
  final String textColor;
  final String portraitImageUrl;
  final String landscapeImageUrl;
  final String buttonText;
  final String buttonTextColor;
  final String buttonBackgroundColor;
  final String link;
  final bool isActive;
  final int order;

  InAppMessage({
    required this.id,
    required this.title,
    required this.message,
    required this.layout,
    required this.backgroundColor,
    required this.textColor,
    required this.portraitImageUrl,
    required this.landscapeImageUrl,
    required this.buttonText,
    required this.buttonTextColor,
    required this.buttonBackgroundColor,
    required this.link,
    required this.isActive,
    required this.order,
  });

  factory InAppMessage.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    debugPrint(
      '📨 Parsing in-app message: ${doc.id} => layout=${data['layout']}, title=${data['title']}',
    );
    return InAppMessage(
      id: doc.id,
      title: data['title'] ?? '',
      message: data['message'] ?? '',
      layout: data['layout'] ?? 'card',
      backgroundColor: data['backgroundColor'] ?? '#ffffff',
      textColor: data['textColor'] ?? '#000000',
      portraitImageUrl: data['portraitImageUrl'] ?? '',
      landscapeImageUrl: data['landscapeImageUrl'] ?? '',
      buttonText: data['buttonText'] ?? '',
      buttonTextColor: data['buttonTextColor'] ?? '#1a73e8',
      buttonBackgroundColor: data['buttonBackgroundColor'] ?? '#ffffff',
      link: data['link'] ?? '',
      isActive: data['isActive'] ?? true,
      order: data['order'] ?? 0,
    );
  }
}

/// Provider that streams active in-app messages from Firestore
final inAppMessagesProvider = StreamProvider<List<InAppMessage>>((ref) {
  debugPrint(
    '🔍 InAppMessagesProvider: Syncing all recent messages for history...',
  );
  return FirebaseFirestore.instance
      .collection('notifications')
      .where('type', isEqualTo: 'in-app')
      .orderBy(
        'order',
        descending: true,
      ) // Order by latest first for history sync
      .limit(20) // Limit to last 20 messages
      .snapshots()
      .handleError((error) {
        debugPrint('❌ InAppMessagesProvider ERROR: $error');
      })
      .map((snapshot) {
        debugPrint(
          '📬 InAppMessagesProvider: Syncing ${snapshot.docs.length} messages to history',
        );
        return snapshot.docs
            .map((doc) => InAppMessage.fromFirestore(doc))
            .toList();
      });
});

/// Tracks which in-app message IDs have been dismissed this session
class DismissedMessagesNotifier extends StateNotifier<Set<String>> {
  DismissedMessagesNotifier() : super({});

  void dismiss(String id) {
    state = {...state, id};
  }

  bool isDismissed(String id) => state.contains(id);
}

final dismissedMessagesProvider =
    StateNotifierProvider<DismissedMessagesNotifier, Set<String>>(
      (ref) => DismissedMessagesNotifier(),
    );
