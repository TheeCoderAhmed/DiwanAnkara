import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../services/in_app_message_provider.dart';

/// Overlay widget that displays in-app messages from Firestore.
/// This should be placed in the widget tree above your main content
/// (e.g., in AppShell) to show on top of the app.
class InAppMessageOverlay extends ConsumerWidget {
  final Widget child;

  const InAppMessageOverlay({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messagesAsync = ref.watch(inAppMessagesProvider);
    final dismissedIds = ref.watch(dismissedMessagesProvider);

    return Material(
      type: MaterialType.transparency,
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          child,
          messagesAsync.when(
            data: (messages) {
              // Filter out dismissed messages AND inactive messages
              final visible = messages
                  .where((m) => m.isActive && !dismissedIds.contains(m.id))
                  .toList();

              debugPrint('🎯 InAppMessageOverlay: ${messages.length} total, ${visible.length} visible, ${dismissedIds.length} dismissed');

              if (visible.isEmpty) return const SizedBox.shrink();

              // Show the first undismissed message
              final msg = visible.first;
              debugPrint('🎯 Rendering message: ${msg.id} layout=${msg.layout} title=${msg.title}');

              return _buildMessage(context, ref, msg);
            },
            loading: () {
              debugPrint('🎯 InAppMessageOverlay: loading...');
              return const SizedBox.shrink();
            },
            error: (error, _) {
              debugPrint('🎯 InAppMessageOverlay: ERROR: $error');
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(BuildContext context, WidgetRef ref, InAppMessage msg) {
    switch (msg.layout) {
      case 'top-banner':
        return _TopBannerMessage(message: msg, onDismiss: () => _dismiss(ref, msg.id));
      case 'modal':
        return _ModalMessage(message: msg, onDismiss: () => _dismiss(ref, msg.id));
      case 'image-only':
        return _ImageOnlyMessage(message: msg, onDismiss: () => _dismiss(ref, msg.id));
      case 'card':
      default:
        return _CardMessage(message: msg, onDismiss: () => _dismiss(ref, msg.id));
    }
  }

  void _dismiss(WidgetRef ref, String id) {
    ref.read(dismissedMessagesProvider.notifier).dismiss(id);
  }
}

/// Helper to parse hex color strings from admin panel
Color _parseColor(String hex, [Color fallback = Colors.white]) {
  try {
    final cleaned = hex.replaceAll('#', '');
    if (cleaned.length == 6) {
      return Color(int.parse('FF$cleaned', radix: 16));
    } else if (cleaned.length == 8) {
      return Color(int.parse(cleaned, radix: 16));
    }
  } catch (_) {}
  return fallback;
}

/// Handle button tap — open link
Future<void> _handleLinkTap(String link) async {
  if (link.isEmpty) return;
  final uri = Uri.tryParse(link);
  if (uri != null && await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

// ─────────────────────────────────────────────
// TOP BANNER LAYOUT
// ─────────────────────────────────────────────
class _TopBannerMessage extends StatefulWidget {
  final InAppMessage message;
  final VoidCallback onDismiss;

  const _TopBannerMessage({required this.message, required this.onDismiss});

  @override
  State<_TopBannerMessage> createState() => _TopBannerMessageState();
}

class _TopBannerMessageState extends State<_TopBannerMessage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _dismissWithAnimation() {
    _controller.reverse().then((_) => widget.onDismiss());
  }

  @override
  Widget build(BuildContext context) {
    final msg = widget.message;
    final bgColor = _parseColor(msg.backgroundColor);
    final txtColor = _parseColor(msg.textColor, Colors.black);
    final topPadding = MediaQuery.of(context).padding.top;

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SlideTransition(
        position: _slideAnimation,
        child: GestureDetector(
          onVerticalDragEnd: (details) {
            if (details.primaryVelocity != null && details.primaryVelocity! < 0) {
              _dismissWithAnimation();
            }
          },
          child: Container(
            padding: EdgeInsets.only(
              top: topPadding + 8,
              left: 16,
              right: 16,
              bottom: 16,
            ),
            decoration: BoxDecoration(
              color: bgColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (msg.title.isNotEmpty)
                            Text(
                              msg.title,
                              style: TextStyle(
                                color: txtColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          if (msg.message.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Text(
                              msg.message,
                              style: TextStyle(
                                color: txtColor.withValues(alpha: 0.85),
                                fontSize: 14,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: _dismissWithAnimation,
                      child: Icon(Icons.close, color: txtColor.withValues(alpha: 0.6), size: 20),
                    ),
                  ],
                ),
                if (msg.buttonText.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: _ActionButton(message: msg, onDismiss: _dismissWithAnimation),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// MODAL LAYOUT
// ─────────────────────────────────────────────
class _ModalMessage extends StatelessWidget {
  final InAppMessage message;
  final VoidCallback onDismiss;

  const _ModalMessage({required this.message, required this.onDismiss});

  @override
  Widget build(BuildContext context) {
    final bgColor = _parseColor(message.backgroundColor);
    final txtColor = _parseColor(message.textColor, Colors.black);
    final imageUrl = message.portraitImageUrl.isNotEmpty
        ? message.portraitImageUrl
        : message.landscapeImageUrl;
    final hasImage = imageUrl.isNotEmpty;

    return Positioned.fill(
      child: GestureDetector(
        onTap: onDismiss,
        child: Container(
          color: Colors.black54,
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () {}, // Prevent dismiss when tapping the modal itself
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 32),
              constraints: BoxConstraints(
                maxWidth: 400,
                maxHeight: MediaQuery.of(context).size.height * 0.75,
              ),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Close button row
                      Align(
                        alignment: AlignmentDirectional.topEnd,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: GestureDetector(
                            onTap: onDismiss,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.close, color: txtColor.withValues(alpha: 0.6), size: 20),
                            ),
                          ),
                        ),
                      ),
                      // Image
                      if (hasImage)
                        CachedNetworkImage(
                          imageUrl: imageUrl,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          placeholder: (_, __) => Container(
                            height: 180,
                            color: Colors.grey.shade200,
                            child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                          ),
                          errorWidget: (_, __, ___) => const SizedBox.shrink(),
                        ),
                      // Text content
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            if (message.title.isNotEmpty)
                              Text(
                                message.title,
                                style: TextStyle(
                                  color: txtColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            if (message.message.isNotEmpty) ...[
                              const SizedBox(height: 12),
                              Text(
                                message.message,
                                style: TextStyle(
                                  color: txtColor.withValues(alpha: 0.85),
                                  fontSize: 15,
                                  height: 1.5,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                            if (message.buttonText.isNotEmpty) ...[
                              const SizedBox(height: 20),
                              _ActionButton(message: message, onDismiss: onDismiss),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// IMAGE ONLY LAYOUT
// ─────────────────────────────────────────────
class _ImageOnlyMessage extends StatelessWidget {
  final InAppMessage message;
  final VoidCallback onDismiss;

  const _ImageOnlyMessage({required this.message, required this.onDismiss});

  @override
  Widget build(BuildContext context) {
    final imageUrl = message.portraitImageUrl.isNotEmpty
        ? message.portraitImageUrl
        : message.landscapeImageUrl;

    if (imageUrl.isEmpty) {
      // No image, fall back to card
      return _CardMessage(message: message, onDismiss: onDismiss);
    }

    return Positioned.fill(
      child: GestureDetector(
        onTap: onDismiss,
        child: Container(
          color: Colors.black87,
          alignment: Alignment.center,
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              GestureDetector(
                onTap: () {
                  if (message.link.isNotEmpty) {
                    _handleLinkTap(message.link);
                    onDismiss();
                  }
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.contain,
                      placeholder: (_, __) => const SizedBox(
                        height: 200,
                        child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                      ),
                      errorWidget: (_, __, ___) => Container(
                        height: 200,
                        color: Colors.grey.shade800,
                        child: const Center(
                          child: Icon(Icons.broken_image, color: Colors.white54, size: 48),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 50,
                right: 16,
                child: GestureDetector(
                  onTap: onDismiss,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.close, color: Colors.white, size: 24),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// CARD LAYOUT (default)
// ─────────────────────────────────────────────
class _CardMessage extends StatefulWidget {
  final InAppMessage message;
  final VoidCallback onDismiss;

  const _CardMessage({required this.message, required this.onDismiss});

  @override
  State<_CardMessage> createState() => _CardMessageState();
}

class _CardMessageState extends State<_CardMessage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _dismissWithAnimation() {
    _controller.reverse().then((_) => widget.onDismiss());
  }

  @override
  Widget build(BuildContext context) {
    final msg = widget.message;
    final bgColor = _parseColor(msg.backgroundColor);
    final txtColor = _parseColor(msg.textColor, Colors.black);
    final imageUrl = msg.portraitImageUrl.isNotEmpty
        ? msg.portraitImageUrl
        : msg.landscapeImageUrl;
    final hasImage = imageUrl.isNotEmpty;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Positioned(
      bottom: bottomPadding + 90, // Above the bottom nav bar
      left: 16,
      right: 16,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (hasImage)
                    CachedNetworkImage(
                      imageUrl: imageUrl,
                      width: double.infinity,
                      height: 140,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => Container(
                        height: 140,
                        color: Colors.grey.shade200,
                        child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                      ),
                      errorWidget: (_, __, ___) => const SizedBox.shrink(),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (msg.title.isNotEmpty)
                                    Text(
                                      msg.title,
                                      style: TextStyle(
                                        color: txtColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  if (msg.message.isNotEmpty) ...[
                                    const SizedBox(height: 6),
                                    Text(
                                      msg.message,
                                      style: TextStyle(
                                        color: txtColor.withValues(alpha: 0.8),
                                        fontSize: 14,
                                      ),
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: _dismissWithAnimation,
                              child: Icon(Icons.close, color: txtColor.withValues(alpha: 0.5), size: 20),
                            ),
                          ],
                        ),
                        if (msg.buttonText.isNotEmpty) ...[
                          const SizedBox(height: 12),
                          _ActionButton(message: msg, onDismiss: _dismissWithAnimation),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// SHARED ACTION BUTTON
// ─────────────────────────────────────────────
class _ActionButton extends StatelessWidget {
  final InAppMessage message;
  final VoidCallback onDismiss;

  const _ActionButton({required this.message, required this.onDismiss});

  @override
  Widget build(BuildContext context) {
    final btnBgColor = _parseColor(message.buttonBackgroundColor, Theme.of(context).colorScheme.primary);
    final btnTxtColor = _parseColor(message.buttonTextColor, Colors.white);

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (message.link.isNotEmpty) {
            _handleLinkTap(message.link);
          }
          onDismiss();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: btnBgColor,
          foregroundColor: btnTxtColor,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 0,
        ),
        child: Text(
          message.buttonText,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
      ),
    );
  }
}
