import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../data/firestore/firestore_providers.dart';
import '../../domain/models/event.dart';
import '../../routing/app_router.dart';
import '../shared/cached_image_widget.dart';

import 'package:yc_ankara_app/l10n/app_localizations.dart';

class EventsPreviewWidget extends ConsumerWidget {
  const EventsPreviewWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsAsync = ref.watch(eventsStreamProvider);

    return eventsAsync.when(
      data: (events) {
        final now = DateTime.now();
        // Event is upcoming if it ends in the future.
        // We approximate end time as date + 1 hour.
        final cutoff = now.subtract(const Duration(hours: 1));

        final upcomingEvents =
            events.where((e) => e.date.isAfter(cutoff)).toList()
              ..sort((a, b) => a.date.compareTo(b.date)); // Ascending

        if (upcomingEvents.isEmpty) return const SizedBox.shrink();

        return Column(
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D9488).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    LucideIcons.calendarClock,
                    color: Color(0xFF0D9488),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  AppLocalizations.of(context).upcomingEvents,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () => context.pushNamed(EventsRoute.name),
                  child: Text(AppLocalizations.of(context).showAll),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Events List
            SizedBox(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: upcomingEvents.take(5).length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: _MiniEventCard(event: upcomingEvents[index]),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
          ],
        ).animate().fadeIn().slideY(begin: 0.1, end: 0);
      },
      error: (_, __) => const SizedBox.shrink(),
      loading: () => const SizedBox.shrink(),
    );
  }
}

class PreviousEventsWidget extends ConsumerWidget {
  const PreviousEventsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsAsync = ref.watch(eventsStreamProvider);

    return eventsAsync.when(
      data: (events) {
        final now = DateTime.now();
        final cutoff = now.subtract(const Duration(hours: 1));

        final previousEvents =
            events.where((e) => e.date.isBefore(cutoff)).toList()..sort(
              (a, b) => b.date.compareTo(a.date),
            ); // Descending (newest first)

        if (previousEvents.isEmpty) return const SizedBox.shrink();

        return Column(
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    LucideIcons.history,
                    color: Colors.grey,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  AppLocalizations.of(context).previousEvents,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade600,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () =>
                      context.pushNamed(const PreviousEventsRoute().name),
                  child: Text(
                    AppLocalizations.of(context).showAll,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Events List
            SizedBox(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: previousEvents.take(5).length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: _MiniEventCard(
                      event: previousEvents[index],
                      isGrayscale: true, // Optional visual distinction
                      usePreviousEventsRoute: true,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
          ],
        ).animate().fadeIn().slideY(begin: 0.1, end: 0);
      },
      error: (_, __) => const SizedBox.shrink(),
      loading: () => const SizedBox.shrink(),
    );
  }
}

class _MiniEventCard extends StatelessWidget {
  const _MiniEventCard({
    required this.event,
    this.isGrayscale = false,
    this.usePreviousEventsRoute = false,
  });

  final AppEvent event;
  final bool isGrayscale;
  final bool usePreviousEventsRoute;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardTheme = theme.cardTheme;
    final shape = (cardTheme.shape as RoundedRectangleBorder?) ??
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16));

    return GestureDetector(
      onTap: () => context.pushNamed(
        usePreviousEventsRoute
            ? const PreviousEventsRoute().name
            : EventsRoute.name,
      ),
      child: Container(
        width: 280,
        decoration: BoxDecoration(
          color: cardTheme.color ?? (isDark ? const Color(0xFF1E293B) : Colors.white),
          borderRadius: shape.borderRadius,
          border: shape.side != BorderSide.none
              ? Border.fromBorderSide(shape.side)
              : Border.all(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.1)
                      : Colors.grey.withValues(alpha: 0.2),
                ),
          boxShadow: cardTheme.shadowColor != null
              ? [
                  BoxShadow(
                    color: cardTheme.shadowColor!,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: ColorFiltered(
          colorFilter: isGrayscale
              ? const ColorFilter.matrix(<double>[
                  0.2126,
                  0.7152,
                  0.0722,
                  0,
                  0,
                  0.2126,
                  0.7152,
                  0.0722,
                  0,
                  0,
                  0.2126,
                  0.7152,
                  0.0722,
                  0,
                  0,
                  0,
                  0,
                  0,
                  1,
                  0,
                ])
              : const ColorFilter.mode(Colors.transparent, BlendMode.multiply),
          child: Row(
            children: [
              // Image Section
              ClipRRect(
                borderRadius: BorderRadius.horizontal(
                  right: (shape.borderRadius as BorderRadius).topRight,
                ), // Right side for RTL image
                child: SizedBox(
                  width: 100,
                  height: double.infinity,
                  child: CachedImageWidget(
                    imageUrl: event.imageAsset,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Content Section
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: event.category.color.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          DateFormat(
                            'd MMM',
                            Localizations.localeOf(context).languageCode,
                          ).format(event.date),
                          style: TextStyle(
                            color: event.category.color,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        event.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(
                            LucideIcons.mapPin,
                            size: 14,
                            color: Colors.grey.shade500,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              event.location,
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 12,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
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
