import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

import '../../data/firestore/firestore_providers.dart';
import '../../domain/models/event.dart';
import '../shared/cached_image_widget.dart';
import '../shared/empty_state.dart';
import '../shared/glassmorphism_header.dart';
import 'package:yc_ankara_app/l10n/app_localizations.dart';
import 'package:yc_ankara_app/ui/extensions/event_category_extensions.dart';

class EventsScreen extends ConsumerStatefulWidget {
  const EventsScreen({super.key});

  @override
  ConsumerState<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends ConsumerState<EventsScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final offset = _scrollController.offset;
    if (offset > 40 && _calendarFormat == CalendarFormat.month) {
      setState(() {
        _calendarFormat = CalendarFormat.twoWeeks;
      });
    } else if (offset < 50 && _calendarFormat == CalendarFormat.twoWeeks) {
      setState(() {
        _calendarFormat = CalendarFormat.month;
      });
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 800),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    final eventsAsync = ref.watch(eventsStreamProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight + MediaQuery.paddingOf(context).top),
        child: GlassmorphismHeader(
          height: kToolbarHeight + MediaQuery.paddingOf(context).top,
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              AppLocalizations.of(context).eventCalendar,
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
          // Group events by day
          final eventsByDay = <DateTime, List<AppEvent>>{};
          for (var event in events) {
            final date = DateTime(event.date.year, event.date.month, event.date.day);
            if (eventsByDay[date] == null) eventsByDay[date] = [];
            eventsByDay[date]!.add(event);
          }

          final selectedEvents = _selectedDay == null
              ? []
              : eventsByDay[DateTime(
                  _selectedDay!.year, _selectedDay!.month, _selectedDay!.day)] ??
                  [];
          
          // Get upcoming events if no day selected
          final upcomingEvents = events
              .where((e) => e.date.isAfter(DateTime.now().subtract(const Duration(hours: 1))))
              .take(3)
              .toList();
              
          final displayEvents = _selectedDay != null ? selectedEvents : upcomingEvents;

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
              child: Column(
                children: [
                  // Calendar Section
                  GestureDetector(
                    onTap: _scrollToTop,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOutCubic,
                      margin: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1E293B) : Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: TableCalendar<AppEvent>(
                        firstDay: DateTime.utc(2024, 1, 1),
                        lastDay: DateTime.utc(2030, 12, 31),
                        focusedDay: _focusedDay,
                        calendarFormat: _calendarFormat,
                        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                        eventLoader: (day) {
                          final d = DateTime(day.year, day.month, day.day);
                          return eventsByDay[d] ?? [];
                        },
                        startingDayOfWeek: StartingDayOfWeek.monday,
                        calendarStyle: CalendarStyle(
                          outsideDaysVisible: false,
                          weekendTextStyle: TextStyle(color: Colors.red.shade400),
                          todayDecoration: BoxDecoration(
                            color: const Color(0xFF0D9488).withValues(alpha: 0.5),
                            shape: BoxShape.circle,
                          ),
                          selectedDecoration: const BoxDecoration(
                            color: Color(0xFF0D9488),
                            shape: BoxShape.circle,
                          ),
                          markerDecoration: const BoxDecoration(
                            color: Color(0xFFF59E0B),
                            shape: BoxShape.circle,
                          ),
                        ),
                        headerStyle: const HeaderStyle(
                          formatButtonVisible: false,
                          titleCentered: true,
                          titleTextStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onDaySelected: (selectedDay, focusedDay) {
                          setState(() {
                            _selectedDay = selectedDay;
                            _focusedDay = focusedDay;
                          });
                        },
                        onFormatChanged: (format) {
                          if (_calendarFormat != format) {
                            setState(() {
                              _calendarFormat = format;
                            });
                          }
                        },
                        onPageChanged: (focusedDay) {
                          _focusedDay = focusedDay;
                        },
                      ),
                    ),
                  ).animate().fadeIn().slideY(begin: -0.1, end: 0),

                  // Divider
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Row(
                      children: [
                          Text(
                            _selectedDay != null 
                                ? AppLocalizations.of(context).eventsOnDate(DateFormat('d MMMM', Localizations.localeOf(context).languageCode).format(_selectedDay!))
                                : AppLocalizations.of(context).upcomingEvents,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        const Spacer(),
                        if (_selectedDay != null)
                          TextButton(
                            onPressed: () => setState(() => _selectedDay = null),
                            child: Text(AppLocalizations.of(context).showAll),
                          ),
                      ],
                    ),
                  ),

                  // Events List
                  Expanded(
                    child: displayEvents.isEmpty
                        ? Center(
                            child: EmptyState(
                              message: _selectedDay != null
                                  ? AppLocalizations.of(context).noEventsOnDay
                                  : AppLocalizations.of(context).noUpcomingEvents,
                              icon: LucideIcons.calendarX,
                            ),
                          )
                        : ListView.builder(
                            controller: _scrollController,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            itemCount: displayEvents.length,
                            itemBuilder: (context, index) {
                              final event = displayEvents[index] as AppEvent;
                              return _EventCard(event: event)
                                  .animate()
                                  .fadeIn(delay: (100 * index).ms)
                                  .slideX(begin: 0.1, end: 0);
                            },
                          ),
                  ),
                ],
              ),
            ),
          );
        },
        error: (e, s) => Center(child: Text('${AppLocalizations.of(context).error}: $e')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  }

class _EventCard extends StatelessWidget {
  const _EventCard({required this.event});

  final AppEvent event;

  Future<void> _launchRSVP(BuildContext context) async {
    if (event.url.isEmpty) return;
    
    // Add haptic feedback
    HapticFeedback.mediumImpact();
    
    final uri = Uri.parse(event.url);
    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        throw 'Could not launch $uri';
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context).errorOpeningRegistrationLink)),
        );
      }
    }
  }

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
            color: event.category.color.withValues(alpha: 0.15),
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: -5,
          ),
        ],
        border: Border.all(
          color: event.category.color.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        children: [
          // Image Header
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                child: SizedBox(
                  height: 140,
                  width: double.infinity,
                  child: CachedImageWidget(
                    imageUrl: event.imageAsset,
                    height: 140,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Category Badge
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(event.category.icon, size: 14, color: Colors.white),
                      const SizedBox(width: 8),
                      Text(
                        event.category.localizedLabel(context),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
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
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // Date Badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: event.category.color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Text(
                            DateFormat('MMM', Localizations.localeOf(context).languageCode).format(event.date),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: event.category.color,
                            ),
                          ),
                          Text(
                            DateFormat('d').format(event.date),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: event.category.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(LucideIcons.mapPin, size: 16, color: Colors.grey.shade500),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        event.location,
                        style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // Time
                    const SizedBox(width: 12),
                    Icon(LucideIcons.clock, size: 16, color: Colors.grey.shade500),
                    const SizedBox(width: 6),
                    Text(
                      DateFormat('h:mm a', Localizations.localeOf(context).languageCode).format(event.date),
                      style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
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
                      color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                
                // Action Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => _launchRSVP(context),
                    icon: const Icon(LucideIcons.externalLink, size: 18),
                    label: Text(AppLocalizations.of(context).registerNow),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: event.category.color,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      shadowColor: event.category.color.withValues(alpha: 0.4),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
