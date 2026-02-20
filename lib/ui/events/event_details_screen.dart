import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart'; // Implemented import
import 'package:lucide_icons/lucide_icons.dart';

import '../../domain/models/event.dart';
import '../shared/ambient_background.dart';
import '../shared/cached_image_widget.dart';

class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({super.key, required this.event});

  final AppEvent event;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowRight),
          onPressed: () => context.pop(),
        ),
      ),
      body: AmbientBackground(
        child: CustomScrollView(
          slivers: [
            // Hero Image
            SliverToBoxAdapter(
              child: Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Theme.of(context).scaffoldBackgroundColor,
                    ],
                  ),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    event.imageAsset.startsWith('http')
                        ? CachedImageWidget(
                            imageUrl: event.imageAsset,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            event.imageAsset,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              color: const Color(0xFF1E293B),
                              alignment: Alignment.center,
                              child: const Icon(
                                LucideIcons.image,
                                color: Colors.white54,
                                size: 48,
                              ),
                            ),
                          ),
                    // Gradient overlay
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Theme.of(context).scaffoldBackgroundColor,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Content
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: event.category.color.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            event.category.icon,
                            size: 16,
                            color: event.category.color,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            event.category.label,
                            style: Theme.of(context).textTheme.labelLarge
                                ?.copyWith(
                                  color: event.category.color,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      event.title,
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    // Date & Location Info
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).cardColor.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Theme.of(
                            context,
                          ).dividerColor.withValues(alpha: 0.1),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                LucideIcons.calendar,
                                color: Colors.grey.shade500,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  // Format: Friday, 23 Jan 2026
                                  '${event.date.day}/${event.date.month}/${event.date.year} • ${event.date.hour}:${event.date.minute.toString().padLeft(2, '0')}',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                            ],
                          ),
                          const Divider(height: 24),
                          Row(
                            children: [
                              Icon(
                                LucideIcons.mapPin,
                                color: Colors.grey.shade500,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  event.location,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      event.description,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.copyWith(height: 1.6),
                    ),
                    const SizedBox(height: 24),
                    if (event.url.isNotEmpty)
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: () async {
                            final uri = Uri.parse(event.url);
                            try {
                              if (!await launchUrl(
                                uri,
                                mode: LaunchMode.externalApplication,
                              )) {
                                throw 'Could not launch $uri';
                              }
                            } catch (e) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('تعذر فتح الرابط'),
                                  ),
                                );
                              }
                            }
                          },
                          icon: const Icon(LucideIcons.externalLink),
                          label: const Text('تسجيل / تفاصيل أكثر'),
                          style: FilledButton.styleFrom(
                            backgroundColor: event.category.color,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 16,
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
