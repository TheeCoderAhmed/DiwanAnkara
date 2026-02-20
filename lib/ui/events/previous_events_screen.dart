import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:yc_ankara_app/l10n/app_localizations.dart';

import '../../data/firestore/firestore_providers.dart';
import '../../domain/models/event.dart';
import '../shared/cached_image_widget.dart';
import '../shared/empty_state.dart';
import '../shared/glassmorphism_header.dart';

class PreviousEventsScreen extends ConsumerWidget {
  const PreviousEventsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsAsync = ref.watch(eventsStreamProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          kToolbarHeight + MediaQuery.paddingOf(context).top,
        ),
        child: GlassmorphismHeader(
          height: kToolbarHeight + MediaQuery.paddingOf(context).top,
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              AppLocalizations.of(context).pastEvents,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(LucideIcons.chevronRight),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ),
      body: eventsAsync.when(
        data: (events) {
          final now = DateTime.now();
          final cutoff = now.subtract(const Duration(hours: 1));

          // Filter previous events
          final previousEvents =
              events.where((e) => e.date.isBefore(cutoff)).toList()..sort(
                (a, b) => b.date.compareTo(a.date),
              ); // Descending (newest first)

          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: isDark
                    ? [const Color(0xFF0F172A), const Color(0xFF1E293B)]
                    : [const Color(0xFFF0FDF4), const Color(0xFFF8FAFC)],
              ),
            ),
            child: SafeArea(
              child: previousEvents.isEmpty
                  ? Center(
                      child: EmptyState(
                        message: AppLocalizations.of(context).noPastEvents,
                        icon: LucideIcons.history,
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      itemCount: previousEvents.length,
                      itemBuilder: (context, index) {
                        return _PreviousEventCard(event: previousEvents[index])
                            .animate()
                            .fadeIn(delay: (100 * index).ms)
                            .slideX(begin: 0.1, end: 0);
                      },
                    ),
            ),
          );
        },
        error: (e, s) => Center(child: Text('خطأ: $e')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class _PreviousEventCard extends StatelessWidget {
  const _PreviousEventCard({required this.event});

  final AppEvent event;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.05)
              : Colors.grey.withValues(alpha: 0.1),
        ),
      ),
      child: ColorFiltered(
        // Add a grayscale filter to indicate it's past
        colorFilter: const ColorFilter.matrix(
          <double>[
            0.95,
            0,
            0,
            0,
            0,
            0,
            0.95,
            0,
            0,
            0,
            0,
            0,
            0.95,
            0,
            0,
            0,
            0,
            0,
            1,
            0,
          ],
        ), // Slight desaturation, not full black and white to keep it looking good
        child: Column(
          children: [
            // Image Header
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              child: SizedBox(
                height: 120,
                width: double.infinity,
                child: CachedImageWidget(
                  imageUrl: event.imageAsset,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          event.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // Date Badge (Past)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          DateFormat(
                            'd MMM yyyy',
                            Localizations.localeOf(context).languageCode,
                          ).format(event.date),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: isDark
                                ? Colors.grey.shade300
                                : Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        LucideIcons.mapPin,
                        size: 14,
                        color: Colors.grey.shade500,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          event.location,
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 13,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  if (event.description.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Text(
                      event.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: isDark
                            ? Colors.grey.shade500
                            : Colors.grey.shade600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
