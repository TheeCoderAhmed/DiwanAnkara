import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../services/notification_controller.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:yc_ankara_app/l10n/app_localizations.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifications = ref.watch(notificationControllerProvider);
    final controller = ref.read(notificationControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).notifications),
        centerTitle: true,
        actions: [
          if (notifications.isNotEmpty)
            IconButton(
              icon: const Icon(LucideIcons.trash2, size: 20),
              onPressed: () {
                HapticFeedback.mediumImpact();
                _showClearAllDialog(context, controller);
              },
              tooltip: AppLocalizations.of(context).clearAll,
            ),
        ],
      ),
      body: notifications.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    LucideIcons.bellOff,
                    size: 64,
                    color: Theme.of(context).disabledColor,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    AppLocalizations.of(context).noNotifications,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).disabledColor,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return Dismissible(
                  key: Key(notification.id),
                  direction: DismissDirection.endToStart,
                  onDismissed: (_) {
                    controller.deleteNotification(notification.id);
                  },
                  background: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: AlignmentDirectional.centerEnd,
                    child: const Icon(LucideIcons.trash2, color: Colors.white),
                  ),
                  child: Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    elevation: 0,
                    color: Theme.of(context).cardTheme.color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: Theme.of(
                          context,
                        ).dividerColor.withValues(alpha: 0.1),
                      ),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        HapticFeedback.selectionClick();
                        controller.markAsRead(notification.id);
                        // Handle navigation payload
                        if (notification.data != null &&
                            notification.data!.containsKey('route')) {
                          // Example payload: { "route": "/places/details/123" }
                          final route = notification.data!['route'];
                          if (route != null) {
                            context.push(route);
                          }
                        } else if (notification.data != null &&
                            notification.data!.containsKey('link')) {
                          // DeepLinkService handles this usually, but we can do rudimentary check
                          // final link = notification.data!['link'];
                          // Simple URL launch or internal logic
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    notification.title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          fontWeight: notification.isRead
                                              ? FontWeight.normal
                                              : FontWeight.bold,
                                        ),
                                  ),
                                ),
                                if (!notification.isRead)
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              notification.body,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.color
                                        ?.withValues(alpha: 0.8),
                                  ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              DateFormat(
                                'dd/MM/yyyy hh:mm a',
                              ).format(notification.timestamp),
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: Theme.of(context).disabledColor,
                                    fontSize: 10,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  void _showClearAllDialog(
    BuildContext context,
    NotificationController controller,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context).clearAllNotificationsTitle),
        content: Text(
          AppLocalizations.of(context).clearAllNotificationsMessage,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context).cancel),
          ),
          TextButton(
            onPressed: () {
              controller.clearAll();
              Navigator.pop(context);
            },
            child: Text(
              AppLocalizations.of(context).clear,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
