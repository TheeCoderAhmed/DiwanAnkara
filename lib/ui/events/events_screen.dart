import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

import '../../app/app_constants.dart';
import '../../data/firestore/firestore_providers.dart';
import '../../domain/models/event.dart';
import '../shared/cached_image_widget.dart';
import '../shared/empty_state.dart';
import '../shared/floating_navigation_bar.dart';
import 'package:yc_ankara_app/l10n/app_localizations.dart';
import 'package:yc_ankara_app/ui/extensions/event_category_extensions.dart';

// ─────────────────────────────────────────────────────────────
// Tab enum
// ─────────────────────────────────────────────────────────────
enum _EventsTab { upcoming, past }

class EventsScreen extends ConsumerStatefulWidget {
  const EventsScreen({super.key});

  @override
  ConsumerState<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends ConsumerState<EventsScreen>
    with SingleTickerProviderStateMixin {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  _EventsTab _activeTab = _EventsTab.upcoming;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // ─── build ─────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final eventsAsync = ref.watch(eventsStreamProvider);
    final upcoming = ref.watch(upcomingEventsProvider);
    final past = ref.watch(pastEventsProvider);
    final eventsByDay = ref.watch(eventsByDayProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = Theme.of(context).colorScheme.primary;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: eventsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('${l10n.error}: $e')),
        data: (_) {
          // All heavy computation lives in the memoized providers above.
          List<AppEvent> baseList = _activeTab == _EventsTab.upcoming
              ? upcoming
              : past;

          // Filter by selected calendar day
          List<AppEvent> displayList = _selectedDay == null
              ? baseList
              : baseList.where((e) {
                  return e.date.year == _selectedDay!.year &&
                      e.date.month == _selectedDay!.month &&
                      e.date.day == _selectedDay!.day;
                }).toList();

          return CustomScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [
              // ── Glassmorphic App Bar ─────────────────────────
              SliverAppBar(
                pinned: true,
                floating: false,
                expandedHeight: 0,
                backgroundColor: isDark
                    ? Colors.black.withValues(alpha: 0.7)
                    : Colors.white.withValues(alpha: 0.85),
                // Phase 1.2: RepaintBoundary gives BackdropFilter its own
                // GPU compositing layer so scroll events never trigger a re-blur.
                flexibleSpace: RepaintBoundary(
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(color: Colors.transparent),
                    ),
                  ),
                ),
                title: Text(
                  l10n.eventCalendar,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                // Only show back button when pushed on a stack
                automaticallyImplyLeading: Navigator.canPop(context),
                leading: Navigator.canPop(context)
                    ? IconButton(
                        icon: const Icon(LucideIcons.chevronRight),
                        onPressed: () => Navigator.pop(context),
                      )
                    : null,
                elevation: 0,
                scrolledUnderElevation: 0,
              ),

              // ── Sticky Calendar ──────────────────────────────
              SliverPersistentHeader(
                pinned: true,
                delegate: _CalendarHeaderDelegate(
                  focusedDay: _focusedDay,
                  selectedDay: _selectedDay,
                  eventLoader: (day) {
                    final d = DateTime(day.year, day.month, day.day);
                    return eventsByDay[d] ?? [];
                  },
                  primary: primary,
                  isDark: isDark,
                  onDaySelected: (selected, focused) {
                    setState(() {
                      _selectedDay = selected;
                      _focusedDay = focused;
                    });
                  },
                  onPageChanged: (focused) => _focusedDay = focused,
                ),
              ),

              // ── Tab Strip ────────────────────────────────────
              SliverToBoxAdapter(
                child: _TabStrip(
                  activeTab: _activeTab,
                  upcomingCount: upcoming.length,
                  pastCount: past.length,
                  onChanged: (tab) => setState(() {
                    _activeTab = tab;
                    _selectedDay = null;
                  }),
                ),
              ),

              // ── Day clear pill ───────────────────────────────
              if (_selectedDay != null)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Icon(
                          LucideIcons.calendarCheck,
                          size: 16,
                          color: primary,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          DateFormat(
                            'd MMMM',
                            Localizations.localeOf(context).languageCode,
                          ).format(_selectedDay!),
                          style: Theme.of(
                            context,
                          ).textTheme.labelLarge?.copyWith(color: primary),
                        ),
                        const Spacer(),
                        TextButton.icon(
                          onPressed: () => setState(() => _selectedDay = null),
                          icon: const Icon(LucideIcons.x, size: 14),
                          label: Text(l10n.showAll),
                          style: TextButton.styleFrom(
                            foregroundColor: primary,
                            visualDensity: VisualDensity.compact,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              // ── Event List ───────────────────────────────────
              if (displayList.isEmpty)
                SliverFillRemaining(
                  child: Center(
                    child: EmptyState(
                      icon: LucideIcons.calendarX,
                      message: _selectedDay != null
                          ? l10n.noEventsOnDay
                          : _activeTab == _EventsTab.upcoming
                          ? l10n.noUpcomingEvents
                          : l10n.noPastEvents,
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(
                    context.spacing.screenPadding,
                    12,
                    context.spacing.screenPadding,
                    FloatingNavigationBar.totalHeight(context) + 16,
                  ),
                  sliver: SliverList.builder(
                    itemCount: displayList.length,
                    itemBuilder: (context, i) {
                      final event = displayList[i];
                      // Phase 1.3: Cap stagger at 5 items (max 160ms total)
                      // to stop the scheduler running for 1200ms+ on large lists.
                      final delay = (40 * i.clamp(0, 4)).ms;
                      return _activeTab == _EventsTab.upcoming
                          ? _UpcomingEventCard(event: event)
                                .animate()
                                .fadeIn(delay: delay, duration: 200.ms)
                                .slideY(begin: 0.04, end: 0, duration: 200.ms)
                          : _PastEventCard(event: event)
                                .animate()
                                .fadeIn(delay: delay, duration: 200.ms)
                                .slideY(begin: 0.04, end: 0, duration: 200.ms);
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Sticky Calendar delegate
// ─────────────────────────────────────────────────────────────
class _CalendarHeaderDelegate extends SliverPersistentHeaderDelegate {
  _CalendarHeaderDelegate({
    required this.focusedDay,
    required this.selectedDay,
    required this.eventLoader,
    required this.primary,
    required this.isDark,
    required this.onDaySelected,
    required this.onPageChanged,
  });

  final DateTime focusedDay;
  final DateTime? selectedDay;
  final List<AppEvent> Function(DateTime) eventLoader;
  final Color primary;
  final bool isDark;
  final void Function(DateTime, DateTime) onDaySelected;
  final void Function(DateTime) onPageChanged;

  // Full month height / collapsed header-only height
  static const _monthHeight = 360.0;
  static const _headerHeight = 56.0; // just the month-title + nav row

  @override
  double get minExtent => _headerHeight;
  @override
  double get maxExtent => _monthHeight;

  @override
  // Phase 1.1: Compare actual field values so the calendar only rebuilds when
  // the focused month, selected day, primary colour or brightness truly change.
  // The old `=> true` caused a full TableCalendar rebuild on every scroll pixel.
  bool shouldRebuild(_CalendarHeaderDelegate old) =>
      old.focusedDay != focusedDay ||
      old.selectedDay != selectedDay ||
      old.primary != primary ||
      old.isDark != isDark;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    // Phase 1.2: RepaintBoundary gives BackdropFilter its own compositing
    // layer so it is never re-blurred just because scroll content changed.
    return RepaintBoundary(
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // was 20
          child: Container(
            color: isDark
                ? Colors.black.withValues(alpha: 0.55)
                : Colors.white.withValues(alpha: 0.88),
            // OverflowBox gives TableCalendar its full natural height so its
            // internal Column never hits a tight constraint during fast scrolling.
            // ClipRect above handles all visual clipping to the sliver's bounds.
            child: OverflowBox(
              alignment: Alignment.topCenter,
              minHeight: 0,
              maxHeight: _monthHeight,
              child: TableCalendar<AppEvent>(
                firstDay: DateTime.utc(2024, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: focusedDay,
                calendarFormat: CalendarFormat.month,
                selectedDayPredicate: (day) => isSameDay(selectedDay, day),
                eventLoader: eventLoader,
                startingDayOfWeek: StartingDayOfWeek.monday,
                availableCalendarFormats: const {CalendarFormat.month: ''},
                calendarStyle: CalendarStyle(
                  outsideDaysVisible: false,
                  weekendTextStyle: TextStyle(color: Colors.red.shade400),
                  todayDecoration: BoxDecoration(
                    color: primary.withValues(alpha: 0.35),
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: primary,
                    shape: BoxShape.circle,
                  ),
                  markerDecoration: BoxDecoration(
                    color: primary.withValues(alpha: 0.75),
                    shape: BoxShape.circle,
                  ),
                  markerSize: 5,
                  markersMaxCount: 3,
                ),
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: Theme.of(context).textTheme.titleMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                  leftChevronIcon: Icon(
                    LucideIcons.chevronLeft,
                    size: 18,
                    color: primary,
                  ),
                  rightChevronIcon: Icon(
                    LucideIcons.chevronRight,
                    size: 18,
                    color: primary,
                  ),
                ),
                onDaySelected: onDaySelected,
                onPageChanged: onPageChanged,
              ),
            ), // OverflowBox
          ), // Container
        ), // BackdropFilter
      ), // ClipRect
    ); // RepaintBoundary
  }
}

// ─────────────────────────────────────────────────────────────
// Segmented tab strip
// ─────────────────────────────────────────────────────────────
class _TabStrip extends StatelessWidget {
  const _TabStrip({
    required this.activeTab,
    required this.upcomingCount,
    required this.pastCount,
    required this.onChanged,
  });

  final _EventsTab activeTab;
  final int upcomingCount;
  final int pastCount;
  final ValueChanged<_EventsTab> onChanged;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        context.spacing.screenPadding,
        16,
        context.spacing.screenPadding,
        8,
      ),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withValues(alpha: 0.06)
              : Colors.black.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Stack(
          children: [
            // Sliding active indicator
            AnimatedAlign(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              alignment: activeTab == _EventsTab.upcoming
                  ? AlignmentDirectional.centerStart
                  : AlignmentDirectional.centerEnd,
              child: FractionallySizedBox(
                widthFactor: 0.5,
                child: Container(
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: primary.withValues(alpha: 0.35),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Labels
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      HapticFeedback.selectionClick();
                      onChanged(_EventsTab.upcoming);
                    },
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            LucideIcons.calendarClock,
                            size: 15,
                            color: activeTab == _EventsTab.upcoming
                                ? Colors.white
                                : null,
                          ),
                          const SizedBox(width: 6),
                          AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 200),
                            style: Theme.of(context).textTheme.labelLarge!
                                .copyWith(
                                  fontWeight: activeTab == _EventsTab.upcoming
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: activeTab == _EventsTab.upcoming
                                      ? Colors.white
                                      : null,
                                ),
                            child: Text(
                              '${AppLocalizations.of(context).upcomingEvents} ($upcomingCount)',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      HapticFeedback.selectionClick();
                      onChanged(_EventsTab.past);
                    },
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            LucideIcons.history,
                            size: 15,
                            color: activeTab == _EventsTab.past
                                ? Colors.white
                                : null,
                          ),
                          const SizedBox(width: 6),
                          AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 200),
                            style: Theme.of(context).textTheme.labelLarge!
                                .copyWith(
                                  fontWeight: activeTab == _EventsTab.past
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: activeTab == _EventsTab.past
                                      ? Colors.white
                                      : null,
                                ),
                            child: Text(
                              '${AppLocalizations.of(context).pastEvents} ($pastCount)',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Upcoming Event Card — rich hero image + registration CTA
// ─────────────────────────────────────────────────────────────
class _UpcomingEventCard extends StatelessWidget {
  const _UpcomingEventCard({required this.event});
  final AppEvent event;

  Future<void> _launchRSVP(BuildContext context) async {
    if (event.url.isEmpty) return;
    HapticFeedback.mediumImpact();
    final uri = Uri.parse(event.url);
    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $uri');
      }
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context).errorOpeningRegistrationLink,
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final catColor = event.category.color;
    final locale = Localizations.localeOf(context).languageCode;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: isDark
            ? Theme.of(context).colorScheme.surfaceContainerHighest
            : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: catColor.withValues(alpha: 0.18),
            blurRadius: 24,
            offset: const Offset(0, 8),
            spreadRadius: -4,
          ),
        ],
        border: Border.all(color: catColor.withValues(alpha: 0.25), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Hero image with overlays ──────────────────────
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                child: SizedBox(
                  height: 160,
                  width: double.infinity,
                  child: CachedImageWidget(
                    imageUrl: event.imageAsset,
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Bottom gradient for legibility
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.55),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Date badge — top left
              Positioned(
                top: 12,
                left: 12,
                child: _DateBadge(date: event.date, color: catColor),
              ),
              // Category pill — top right
              Positioned(
                top: 12,
                right: 12,
                child: _CategoryPill(
                  icon: event.category.icon,
                  label: event.category.localizedLabel(context),
                  color: catColor,
                ),
              ),
            ],
          ),

          // ── Content ──────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Icon(
                      LucideIcons.mapPin,
                      size: 14,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        event.location,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.5),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(
                      LucideIcons.clock,
                      size: 14,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      DateFormat('h:mm a', locale).format(event.date),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.5),
                      ),
                    ),
                  ],
                ),
                if (event.description.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  Text(
                    event.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.6),
                      height: 1.5,
                    ),
                  ),
                ],
                if (event.url.isNotEmpty) ...[
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () => _launchRSVP(context),
                      icon: const Icon(LucideIcons.externalLink, size: 16),
                      label: Text(AppLocalizations.of(context).registerNow),
                      style: FilledButton.styleFrom(
                        backgroundColor: catColor,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Past Event Card — same structure but muted + “CONCLUDED” pill
// Phase 6: Removed Opacity wrapper — applies 0.75 alpha directly on
// BoxDecoration colour, border and shadow to eliminate the extra
// off-screen compositing pass that Opacity forces.
// ─────────────────────────────────────────────────────────────
class _PastEventCard extends StatelessWidget {
  const _PastEventCard({required this.event});
  final AppEvent event;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final locale = Localizations.localeOf(context).languageCode;
    // Apply muted alpha directly to decoration values instead of wrapping in
    // Opacity, which would create an additional off-screen compositing layer.
    final cardColor =
        (isDark
                ? Theme.of(context).colorScheme.surfaceContainerHighest
                : Colors.white)
            .withValues(alpha: 0.75);
    final borderColor = isDark
        ? Colors.white.withValues(alpha: 0.045)
        : Colors.grey.withValues(alpha: 0.09);
    final shadowColor = Colors.black.withValues(alpha: 0.045);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with grayscale + concluded pill
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                // RepaintBoundary stops Impeller from trying to push inherited
                // opacity into ColorFiltered (which cannot accept it), fixing
                // the "SetInheritedOpacity CanAcceptOpacity" validation error.
                child: RepaintBoundary(
                  child: ColorFiltered(
                    colorFilter: const ColorFilter.matrix([
                      0.33,
                      0.59,
                      0.11,
                      0,
                      0,
                      0.33,
                      0.59,
                      0.11,
                      0,
                      0,
                      0.33,
                      0.59,
                      0.11,
                      0,
                      0,
                      0,
                      0,
                      0,
                      1,
                      0,
                    ]),
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
                ),
              ),
              // "Concluded" badge
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        LucideIcons.checkCircle,
                        size: 12,
                        color: Colors.white70,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        AppLocalizations.of(context).pastEvents,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        event.title,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      DateFormat('d MMM yyyy', locale).format(event.date),
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.5),
                      ),
                    ),
                  ],
                ),
                if (event.location.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        LucideIcons.mapPin,
                        size: 13,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.4),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          event.location,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withValues(alpha: 0.4),
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Shared sub-widgets
// ─────────────────────────────────────────────────────────────

class _DateBadge extends StatelessWidget {
  const _DateBadge({required this.date, required this.color});
  final DateTime date;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            DateFormat('MMM', locale).format(date).toUpperCase(),
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          Text(
            DateFormat('d').format(date),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              height: 1.1,
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryPill extends StatelessWidget {
  const _CategoryPill({
    required this.icon,
    required this.label,
    required this.color,
  });
  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: color.withValues(alpha: 0.4), blurRadius: 8),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: Colors.white),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
