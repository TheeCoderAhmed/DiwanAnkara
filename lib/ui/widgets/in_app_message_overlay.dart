import 'dart:ui';
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

              debugPrint(
                '🎯 InAppMessageOverlay: ${messages.length} total, ${visible.length} visible, ${dismissedIds.length} dismissed',
              );

              if (visible.isEmpty) return const SizedBox.shrink();

              // Show the first undismissed message
              final msg = visible.first;
              debugPrint(
                '🎯 Rendering message: ${msg.id} layout=${msg.layout} title=${msg.title}',
              );

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
        return _TopBannerMessage(
          message: msg,
          onDismiss: () => _dismiss(ref, msg.id),
        );
      case 'modal':
        return _ModalMessage(
          message: msg,
          onDismiss: () => _dismiss(ref, msg.id),
        );
      case 'image-only':
        return _ImageOnlyMessage(
          message: msg,
          onDismiss: () => _dismiss(ref, msg.id),
        );
      case 'card':
      default:
        return _CardMessage(
          message: msg,
          onDismiss: () => _dismiss(ref, msg.id),
        );
    }
  }

  void _dismiss(WidgetRef ref, String id) {
    ref.read(dismissedMessagesProvider.notifier).dismiss(id);
  }
}

BorderRadius _getBorderRadius(BuildContext context) {
  final cardTheme = Theme.of(context).cardTheme;
  if (cardTheme.shape is RoundedRectangleBorder) {
    return (cardTheme.shape as RoundedRectangleBorder).borderRadius
        as BorderRadius;
  }
  return BorderRadius.circular(16);
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

/// A premium image widget that centers the main image over a blurred background
/// of the same image to handle any aspect ratio (Option 2).
class _PremiumSmartImage extends StatelessWidget {
  final String imageUrl;
  final double height;

  const _PremiumSmartImage({required this.imageUrl, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Layer 1: Blurred background (Cover)
          CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            placeholder: (_, __) => const SizedBox.shrink(),
            errorWidget: (_, __, ___) => const SizedBox.shrink(),
          ),
          // Layer 2: Frosted glass overlay
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(color: Colors.black.withValues(alpha: 0.2)),
          ),
          // Layer 3: Centered main image (Contain)
          CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.contain,
            placeholder: (_, __) =>
                const Center(child: CircularProgressIndicator(strokeWidth: 2)),
            errorWidget: (_, __, ___) => const Center(
              child: Icon(Icons.broken_image, color: Colors.white24, size: 40),
            ),
          ),
        ],
      ),
    );
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
    final borderRadius = _getBorderRadius(context);

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SlideTransition(
        position: _slideAnimation,
        child: GestureDetector(
          onVerticalDragEnd: (details) {
            if (details.primaryVelocity != null &&
                details.primaryVelocity! < 0) {
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
              borderRadius: BorderRadius.only(
                bottomLeft: borderRadius.bottomLeft,
                bottomRight: borderRadius.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 20,
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
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    color: txtColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          if (msg.message.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Text(
                              msg.message,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: txtColor.withValues(alpha: 0.85),
                                  ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: _dismissWithAnimation,
                      icon: Icon(
                        Icons.close,
                        color: txtColor.withValues(alpha: 0.6),
                        size: 20,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                if (msg.buttonText.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 150),
                      child: _ActionButton(
                        message: msg,
                        onDismiss: _dismissWithAnimation,
                      ),
                    ),
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
    final txtColor = _parseColor(message.textColor, Colors.black);
    final imageUrl = message.portraitImageUrl.isNotEmpty
        ? message.portraitImageUrl
        : message.landscapeImageUrl;
    final hasImage = imageUrl.isNotEmpty;
    final borderRadius = _getBorderRadius(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Positioned.fill(
      child: GestureDetector(
        onTap: onDismiss,
        child: TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 300),
          tween: Tween(begin: 0.0, end: 1.0),
          builder: (context, value, child) {
            return Container(
              color: Colors.black.withValues(alpha: 0.6 * value),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8 * value, sigmaY: 8 * value),
                child: child,
              ),
            );
          },
          child: Center(
            child: GestureDetector(
              onTap: () {}, // Prevent dismiss when tapping the modal itself
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                constraints: BoxConstraints(
                  maxWidth: 400,
                  maxHeight: MediaQuery.of(context).size.height * 0.8,
                ),
                decoration: BoxDecoration(
                  color: (isDark ? Colors.black : Colors.white).withValues(
                    alpha: 0.85,
                  ),
                  borderRadius: borderRadius,
                  border: Border.all(
                    color: (isDark ? Colors.white : Colors.black).withValues(
                      alpha: 0.1,
                    ),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.25),
                      blurRadius: 40,
                      offset: const Offset(0, 20),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: borderRadius,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (hasImage)
                          Stack(
                            children: [
                              _PremiumSmartImage(
                                imageUrl: imageUrl,
                                height: 260,
                              ),
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.black.withValues(alpha: 0.4),
                                        Colors.transparent,
                                        (isDark ? Colors.black : Colors.white)
                                            .withValues(alpha: 0.85),
                                      ],
                                      stops: const [0, 0.4, 1.0],
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 12,
                                right: 12,
                                child: IconButton(
                                  onPressed: onDismiss,
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 22,
                                  ),
                                  style: IconButton.styleFrom(
                                    backgroundColor: Colors.black.withValues(
                                      alpha: 0.3,
                                    ),
                                    padding: const EdgeInsets.all(4),
                                    minimumSize: const Size(32, 32),
                                  ),
                                ),
                              ),
                            ],
                          )
                        else
                          Align(
                            alignment: AlignmentDirectional.topEnd,
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: IconButton(
                                onPressed: onDismiss,
                                icon: Icon(
                                  Icons.close,
                                  color: txtColor.withValues(alpha: 0.6),
                                ),
                                style: IconButton.styleFrom(
                                  backgroundColor:
                                      (isDark ? Colors.white : Colors.black)
                                          .withValues(alpha: 0.05),
                                ),
                              ),
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(28, 8, 28, 32),
                          child: Column(
                            children: [
                              if (message.title.isNotEmpty)
                                Text(
                                  message.title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(
                                        color: txtColor,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: -0.5,
                                      ),
                                  textAlign: TextAlign.center,
                                ),
                              if (message.message.isNotEmpty) ...[
                                const SizedBox(height: 16),
                                Text(
                                  message.message,
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(
                                        color: txtColor.withValues(alpha: 0.8),
                                        height: 1.6,
                                      ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                              if (message.buttonText.isNotEmpty) ...[
                                const SizedBox(height: 32),
                                _ActionButton(
                                  message: message,
                                  onDismiss: onDismiss,
                                ),
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
    final borderRadius = _getBorderRadius(context);

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
                  margin: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 60,
                  ),
                  child: ClipRRect(
                    borderRadius: borderRadius,
                    child: _PremiumSmartImage(
                      imageUrl: imageUrl,
                      height: MediaQuery.of(context).size.height * 0.5,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 50,
                right: 16,
                child: IconButton(
                  onPressed: onDismiss,
                  icon: const Icon(Icons.close, color: Colors.white, size: 28),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.black.withValues(alpha: 0.5),
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
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
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
    final txtColor = _parseColor(msg.textColor, Colors.black);
    final imageUrl = msg.portraitImageUrl.isNotEmpty
        ? msg.portraitImageUrl
        : msg.landscapeImageUrl;
    final hasImage = imageUrl.isNotEmpty;
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final borderRadius = _getBorderRadius(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Positioned(
      bottom: bottomPadding + 96,
      left: 20,
      right: 20,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            decoration: BoxDecoration(
              color: (isDark ? Colors.black : Colors.white).withValues(
                alpha: 0.8,
              ),
              borderRadius: borderRadius,
              border: Border.all(
                color: (isDark ? Colors.white : Colors.black).withValues(
                  alpha: 0.1,
                ),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 30,
                  offset: const Offset(0, 15),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: borderRadius,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (hasImage)
                      _PremiumSmartImage(imageUrl: imageUrl, height: 200),
                    Padding(
                      padding: const EdgeInsets.all(24),
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.copyWith(
                                              color: txtColor,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: -0.5,
                                            ),
                                      ),
                                    if (msg.message.isNotEmpty) ...[
                                      const SizedBox(height: 10),
                                      Text(
                                        msg.message,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              color: txtColor.withValues(
                                                alpha: 0.7,
                                              ),
                                              height: 1.5,
                                            ),
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),
                              IconButton(
                                onPressed: _dismissWithAnimation,
                                icon: Icon(
                                  Icons.close,
                                  color: txtColor.withValues(alpha: 0.4),
                                  size: 20,
                                ),
                                style: IconButton.styleFrom(
                                  backgroundColor:
                                      (isDark ? Colors.white : Colors.black)
                                          .withValues(alpha: 0.05),
                                  padding: EdgeInsets.zero,
                                  minimumSize: const Size(36, 36),
                                ),
                              ),
                            ],
                          ),
                          if (msg.buttonText.isNotEmpty) ...[
                            const SizedBox(height: 24),
                            _ActionButton(
                              message: msg,
                              onDismiss: _dismissWithAnimation,
                            ),
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
    final btnBgColor = _parseColor(
      message.buttonBackgroundColor,
      Theme.of(context).colorScheme.primary,
    );
    final btnTxtColor = _parseColor(message.buttonTextColor, Colors.white);
    final borderRadius = _getBorderRadius(context);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: borderRadius / 2,
        boxShadow: [
          BoxShadow(
            color: btnBgColor.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
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
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: borderRadius / 2),
          elevation: 0,
        ),
        child: Text(
          message.buttonText,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}
