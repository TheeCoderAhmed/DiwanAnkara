import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:yc_ankara_app/l10n/app_localizations.dart';

import '../../data/firestore/firestore_providers.dart';
import '../../domain/models/announcement.dart';
import '../../domain/models/categories.dart';
import '../../domain/models/partner.dart';
import '../../domain/models/place.dart';
import '../../domain/models/project.dart';
import '../../domain/models/university_model.dart';
import '../../routing/app_router.dart';
// import '../../tools/data_seeder.dart';
import 'home_providers.dart';

import '../../services/notification_controller.dart';
import '../projects/project_details_page.dart';
import '../shared/ambient_background.dart';
import '../shared/cached_image_widget.dart';
import '../shared/empty_state.dart';
import '../shared/floating_navigation_bar.dart';
import '../shared/glassmorphism_header.dart';
import '../shared/skeleton_bento_card.dart';
import '../shared/skeleton_place_card.dart';
import '../widgets/ikamet_tracker_widget.dart';
import '../widgets/place_card.dart';
import '../widgets/student_hacks_widget.dart';
import '../widgets/offline_banner.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _searchCtrl = TextEditingController();
  final _scrollController = ScrollController();
  final _scrollOffset = ValueNotifier<double>(0.0);

  // Debouncing and background filtering
  Timer? _debounce;
  List<Place>? _filteredResults;
  bool _isFiltering = false;

  // Getter for search state toggle
  bool get _isSearching => _searchCtrl.text.trim().isNotEmpty;

  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  bool _isOffline = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    // Add listener with debouncing
    _searchCtrl.addListener(_onSearchChanged);

    // Connectivity listener
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((
      results,
    ) {
      if (mounted) {
        setState(() {
          _isOffline = results.contains(ConnectivityResult.none);
        });
      }
    });
  }

  void _onSearchChanged() {
    // Cancel previous timer
    _debounce?.cancel();

    // Start new timer (300ms delay)
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          // Trigger rebuild which will call background filter
        });
      }
    });
  }

  void _onScroll() {
    _scrollOffset.value = _scrollController.offset;
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _connectivitySubscription?.cancel();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _scrollOffset.dispose();
    _searchCtrl.removeListener(_onSearchChanged);
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchCtrl.text.trim();
    final placesAsync = ref.watch(placesStreamProvider);

    final announcementsAsync = ref.watch(announcementsStreamProvider);
    final partnersAsync = ref.watch(partnersStreamProvider);
    final projectsAsync = ref.watch(projectsStreamProvider);
    final universitiesAsync = ref.watch(universitiesStreamProvider);

    // Notification count
    final notifications = ref.watch(notificationControllerProvider);
    final unreadCount = notifications.where((n) => !n.isRead).length;
    final l10n = AppLocalizations.of(context);

    final appSettingsAsync = ref.watch(appSettingsProvider);
    final appSettings = appSettingsAsync.valueOrNull;

    return Scaffold(
      body: Stack(
        children: [
          ValueListenableBuilder<double>(
            valueListenable: _scrollOffset,
            builder: (context, offset, child) {
              return AmbientBackground(scrollOffset: offset, child: child!);
            },
            child: placesAsync.when(
              data: (places) {
                final popularPlaces = places
                    .where((p) => p.isPopular)
                    .toList(growable: false);

                // Use the memoized universities provider
                final mappedUniversities = ref.watch(
                  mappedUniversitiesProvider,
                );

                // Merge lists for search - memoized if possible or simple merge
                final allSearchablePlaces = [...places, ...mappedUniversities];

                // Background filtering with debouncing
                if (query.isNotEmpty && !_isFiltering) {
                  _isFiltering = true;
                  compute(_filterPlaces, {
                    'query': query,
                    'places': allSearchablePlaces,
                  }).then((results) {
                    if (mounted) {
                      setState(() {
                        _filteredResults = results;
                        _isFiltering = false;
                      });
                    }
                  });
                } else if (query.isEmpty) {
                  _filteredResults = null;
                }

                final filteredPlaces = _filteredResults ?? [];

                return CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    // Glassmorphism Header with Search (ALWAYS visible)
                    SliverToBoxAdapter(
                      child: GlassmorphismHeader(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                            20,
                            MediaQuery.paddingOf(context).top + 16,
                            20,
                            20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _greeting(l10n),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          HapticFeedback.lightImpact();
                                          context.push(
                                            const NotificationsRoute().location,
                                          );
                                        },
                                        icon: Badge(
                                          isLabelVisible: unreadCount > 0,
                                          label: Text('$unreadCount'),
                                          child: const Icon(LucideIcons.bell),
                                        ),
                                        style: IconButton.styleFrom(
                                          backgroundColor: Colors.white
                                              .withValues(alpha: 0.1),
                                          foregroundColor: Theme.of(
                                            context,
                                          ).colorScheme.onSurface,
                                          minimumSize: const Size(48, 48),
                                          padding: EdgeInsets.zero,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              TextField(
                                controller: _searchCtrl,
                                decoration: InputDecoration(
                                  hintText: l10n.searchHint,
                                  prefixIcon: const Icon(LucideIcons.search),
                                  suffixIcon: _isSearching
                                      ? IconButton(
                                          onPressed: () {
                                            HapticFeedback.lightImpact();
                                            _searchCtrl.clear();
                                          },
                                          icon: const Icon(LucideIcons.x),
                                          style: IconButton.styleFrom(
                                            minimumSize: const Size(48, 48),
                                          ),
                                        )
                                      : null,
                                  filled: true,
                                  fillColor:
                                      Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white.withValues(alpha: 0.1)
                                      : Theme.of(context)
                                            .colorScheme
                                            .surfaceContainerHighest
                                            .withValues(alpha: 0.6),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        ((Theme.of(context).cardTheme.shape
                                                    as RoundedRectangleBorder?)
                                                ?.borderRadius
                                            as BorderRadius?) ??
                                        BorderRadius.circular(16),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // ============ SEARCH MODE: Show ONLY Search Results ============
                    if (_isSearching) ...[
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 24),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Text(
                                l10n.searchResults,
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(height: 16),
                            if (filteredPlaces.isEmpty)
                              Padding(
                                padding: const EdgeInsets.all(40),
                                child: EmptyState(message: l10n.noResults),
                              )
                            else
                              ...filteredPlaces.map(
                                (p) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 8,
                                  ),
                                  child: _SearchResultTile(
                                    place: p,
                                    universities:
                                        universitiesAsync.valueOrNull ?? [],
                                  ),
                                ),
                              ),
                            SizedBox(
                              height: FloatingNavigationBar.totalHeight(
                                context,
                              ),
                            ), // Bottom padding for navbar
                          ],
                        ),
                      ),
                    ],

                    // Emergency Banner (ALWAYS visible if active)
                    if (appSettings?.emergencyBannerVisible == true &&
                        appSettings?.emergencyBannerText.trim().isNotEmpty ==
                            true)
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                            20,
                            MediaQuery.paddingOf(context).top + 16,
                            20,
                            0,
                          ),
                          child: _EmergencyBanner(
                            text: appSettings!.emergencyBannerText,
                          ),
                        ),
                      ),

                    // ============ MAIN MODE: Show Main Content ============
                    if (!_isSearching) ...[
                      // Announcements Carousel (Connected to Firebase)
                      if (appSettings?.enableAnnouncements ?? true)
                        SliverToBoxAdapter(
                          child: announcementsAsync.when(
                            data: (announcements) {
                              if (announcements.isEmpty) {
                                return const SizedBox.shrink();
                              }

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 24),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    child: Text(
                                      l10n.announcements,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  // 2.5 — Carousel with dot indicator
                                  Builder(
                                    builder: (context) {
                                      final dotIndex = ValueNotifier<int>(0);
                                      return Column(
                                        children: [
                                          RepaintBoundary(
                                            child: CarouselSlider.builder(
                                              itemCount: announcements.length,
                                              options: CarouselOptions(
                                                height: 200,
                                                autoPlay: true,
                                                enlargeCenterPage: true,
                                                viewportFraction: 0.9,
                                                autoPlayInterval:
                                                    const Duration(seconds: 4),
                                                autoPlayAnimationDuration:
                                                    const Duration(
                                                      milliseconds: 800,
                                                    ),
                                                onPageChanged: (index, reason) {
                                                  dotIndex.value = index;
                                                },
                                              ),
                                              itemBuilder:
                                                  (context, index, realIndex) {
                                                    return _AnnouncementCardFromFirebase(
                                                      announcement:
                                                          announcements[index],
                                                    );
                                                  },
                                            ),
                                          ),
                                          const SizedBox(height: 12),
                                          // Animated dots
                                          ValueListenableBuilder<int>(
                                            valueListenable: dotIndex,
                                            builder: (context, current, _) {
                                              return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: List.generate(
                                                  announcements.length,
                                                  (i) => AnimatedContainer(
                                                    duration: const Duration(
                                                      milliseconds: 250,
                                                    ),
                                                    curve: Curves.easeInOut,
                                                    margin:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 3,
                                                        ),
                                                    width: current == i
                                                        ? 20
                                                        : 6,
                                                    height: 6,
                                                    decoration: BoxDecoration(
                                                      color: current == i
                                                          ? Theme.of(context)
                                                                .colorScheme
                                                                .primary
                                                          : Theme.of(context)
                                                                .colorScheme
                                                                .onSurface
                                                                .withValues(
                                                                  alpha: 0.2,
                                                                ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            3,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 24),
                                ],
                              );
                            },
                            error: (_, __) => const SizedBox.shrink(),
                            loading: () => const SizedBox.shrink(),
                          ),
                        ),

                      // Popular Places
                      if (appSettings?.enablePopularPlaces ?? true)
                        if (popularPlaces.isNotEmpty)
                          SliverToBoxAdapter(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: Text(
                                    l10n.popularPlaces,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                RepaintBoundary(
                                  child: SizedBox(
                                    height: 260,
                                    child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                      ),
                                      itemCount: popularPlaces.length,
                                      separatorBuilder: (_, __) =>
                                          const SizedBox(width: 12),
                                      itemBuilder: (context, index) {
                                        final p = popularPlaces[index];
                                        return PlaceCard(
                                          place: p,
                                          isHorizontal: true,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 24),
                              ],
                            ),
                          ),

                      // Ikamet Tracker Widget
                      if (appSettings?.enableIkametTracker ?? true)
                        const SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            child: RepaintBoundary(
                              child: IkametTrackerWidget(),
                            ),
                          ),
                        ),

                      // Currency Exchange Widget
                      if (appSettings?.enableCurrencyConverter ?? true)
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: RepaintBoundary(
                              child: CurrencyExchangeWidget(
                                fallbackRates:
                                    appSettings?.currencyFallbackRates,
                              ),
                            ),
                          ),
                        ),

                      // Student Hacks Widget
                      if (appSettings?.enableStudentHacks ?? true)
                        const SliverToBoxAdapter(
                          child: RepaintBoundary(child: StudentHacksWidget()),
                        ),

                      // Projects Section
                      if (appSettings?.enableProjects ?? true)
                        SliverToBoxAdapter(
                          child: projectsAsync.when(
                            data: (projects) {
                              if (projects.isEmpty) {
                                return const SizedBox.shrink();
                              }

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    child: Text(
                                      l10n.projects,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  RepaintBoundary(
                                    child: SizedBox(
                                      height: 160,
                                      child: ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                        ),
                                        itemCount: projects.length,
                                        separatorBuilder: (_, __) =>
                                            const SizedBox(width: 12),
                                        itemBuilder: (context, index) {
                                          return _ProjectCard(
                                            project: projects[index],
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                ],
                              );
                            },
                            error: (_, __) => const SizedBox.shrink(),
                            loading: () => const SizedBox.shrink(),
                          ),
                        ),

                      // Partners Section
                      if (appSettings?.enablePartners ?? true)
                        SliverToBoxAdapter(
                          child: partnersAsync.when(
                            data: (partners) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                      20,
                                      32,
                                      20,
                                      16,
                                    ),
                                    child: Text(
                                      l10n.partners,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                  if (partners.isEmpty)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                      ),
                                      child: EmptyState(
                                        message: l10n.noPartners,
                                        icon: LucideIcons.building2,
                                      ),
                                    )
                                  else
                                    RepaintBoundary(
                                      child: _buildPartnersGrid(
                                        context,
                                        partners,
                                      ),
                                    ),
                                  SizedBox(
                                    height: FloatingNavigationBar.totalHeight(
                                      context,
                                    ),
                                  ), // Bottom padding for navbar
                                ],
                              );
                            },
                            error: (_, __) => const SizedBox.shrink(),
                            loading: () => const SizedBox.shrink(),
                          ),
                        ),
                    ],
                  ],
                );
              },
              error: (e, _) => Center(
                child: EmptyState(
                  message: '${l10n.error}: $e',
                  icon: LucideIcons.alertCircle,
                ),
              ),
              loading: () => CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        20,
                        MediaQuery.paddingOf(context).top + 16,
                        20,
                        20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 20,
                            width: 200,
                            decoration: BoxDecoration(
                              color:
                                  Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.grey.shade800
                                  : Colors.grey.shade300,
                              borderRadius:
                                  ((Theme.of(context).cardTheme.shape
                                          as RoundedRectangleBorder?)
                                      ?.borderRadius ??
                                  BorderRadius.circular(8)),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            height: 48,
                            decoration: BoxDecoration(
                              color:
                                  Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.grey.shade800
                                  : Colors.grey.shade300,
                              borderRadius:
                                  ((Theme.of(context).cardTheme.shape
                                          as RoundedRectangleBorder?)
                                      ?.borderRadius ??
                                  BorderRadius.circular(16)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 24,
                      ),
                      child: Row(
                        children: List.generate(
                          3,
                          (index) => Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: index < 2 ? 12 : 0,
                              ),
                              child: SkeletonPlaceCard(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 1.1,
                            ),
                        itemCount: 6,
                        itemBuilder: (context, index) => SkeletonBentoCard(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_isOffline)
            const Positioned(top: 0, left: 0, right: 0, child: OfflineBanner()),
        ],
      ),
    );
  }

  Widget _buildPartnersGrid(BuildContext context, List<Partner> partners) {
    // Modern horizontal scroll with circular avatars
    return SizedBox(
      height: 90,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: partners.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          return _ModernPartnerLogo(partner: partners[index]);
        },
      ),
    );
  }

  /// Returns a time-of-day greeting using the l10n strings (2.1)
  String _greeting(AppLocalizations l10n) {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) return l10n.goodMorning;
    if (hour >= 12 && hour < 17) return l10n.goodAfternoon;
    if (hour >= 17 && hour < 21) return l10n.goodEvening;
    return l10n.goodNight;
  }

  // Static method for background filtering via compute()
  static List<Place> _filterPlaces(Map<String, dynamic> params) {
    final String query = params['query'] as String;
    final List<Place> places = params['places'] as List<Place>;

    // Turkish character normalization helper
    String normalizeTurkish(String text) {
      return text
          .toLowerCase()
          .replaceAll('ı', 'i')
          .replaceAll('ğ', 'g')
          .replaceAll('ü', 'u')
          .replaceAll('ş', 's')
          .replaceAll('ö', 'o')
          .replaceAll('ç', 'c')
          .replaceAll('İ', 'i');
    }

    final normalizedQuery = normalizeTurkish(query);

    return places.where((p) {
      final normalizedName = normalizeTurkish(p.nameTr);
      final normalizedDesc = normalizeTurkish(p.descriptionAr);
      final normalizedCat = normalizeTurkish(p.category.jsonValue);
      final normalizedCatAr = normalizeTurkish(p.category.arabicLabel);

      return normalizedName.contains(normalizedQuery) ||
          normalizedDesc.contains(normalizedQuery) ||
          normalizedCat.contains(normalizedQuery) ||
          normalizedCatAr.contains(normalizedQuery);
    }).toList();
  }
}

// Currency Exchange Widget
class CurrencyExchangeWidget extends StatefulWidget {
  final Map<String, double>? fallbackRates;
  const CurrencyExchangeWidget({super.key, this.fallbackRates});

  @override
  State<CurrencyExchangeWidget> createState() => _CurrencyExchangeWidgetState();
}

class _CurrencyExchangeWidgetState extends State<CurrencyExchangeWidget> {
  final _amountController = TextEditingController(text: '100');
  String _fromCurrency = 'TRY';
  String _toCurrency = 'USD';
  bool _isLoading = false;

  // Live exchange rates (will be fetched from API)
  final Map<String, double> _rates = {
    'USD': 0.037,
    'EUR': 0.034,
    'TRY': 1.0,
    'SAR': 0.139,
    'YER': 9.27,
    'AED': 0.136,
    'KWD': 0.011,
    'QAR': 0.135,
    'GBP': 0.029,
    'EGP': 2.30,
  };

  @override
  void initState() {
    super.initState();
    _fetchRates();
  }

  Future<void> _fetchRates() async {
    setState(() => _isLoading = true);
    try {
      // Fetch USD rates
      final usdResponse = await http.get(
        Uri.parse('https://api.exchangerate-api.com/v4/latest/USD'),
      );

      // Fetch EUR rates
      final eurResponse = await http.get(
        Uri.parse('https://api.exchangerate-api.com/v4/latest/EUR'),
      );

      if (usdResponse.statusCode == 200 && eurResponse.statusCode == 200) {
        final usdData = json.decode(usdResponse.body);

        if (mounted) {
          setState(() {
            final rates = Map<String, dynamic>.from(usdData['rates'] as Map);
            final usdToTry = (rates['TRY'] as num).toDouble();

            // Define the currencies we want to track
            final targetCurrencies = [
              'USD',
              'EUR',
              'TRY',
              'SAR',
              'YER',
              'AED',
              'KWD',
              'QAR',
              'GBP',
              'EGP',
            ];

            // Update rates relative to TRY (since base is 1.0 TRY)
            for (var currency in targetCurrencies) {
              if (rates.containsKey(currency)) {
                final usdToCurrency = (rates[currency] as num).toDouble();
                _rates[currency] = usdToCurrency / usdToTry;
              }
            }

            // Ensure TRY is exactly 1.0
            _rates['TRY'] = 1.0;

            _isLoading = false;
          });
        }
      }
    } catch (e) {
      debugPrint('Error fetching exchange rates: $e');
      if (mounted) {
        final l10n = AppLocalizations.of(context);
        setState(() {
          _isLoading = false;
          if (widget.fallbackRates != null) {
            _rates.addAll(widget.fallbackRates!);
            _rates['TRY'] = 1.0;
          }
        });
        // Show user-friendly error notification
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(LucideIcons.alertCircle, color: Colors.white, size: 20),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    l10n.exchangeRateError,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.orange.shade700,
            duration: const Duration(seconds: 4),
            behavior: SnackBarBehavior.floating,
            action: SnackBarAction(
              label: l10n.retry,
              textColor: Colors.white,
              onPressed: _fetchRates,
            ),
          ),
        );
      }
    }
  }

  double get _convertedAmount {
    final amount = double.tryParse(_amountController.text) ?? 0;
    if (_fromCurrency == _toCurrency) return amount;

    // Convert to TRY first, then to target currency
    final tryAmount = amount / _rates[_fromCurrency]!;
    return tryAmount * _rates[_toCurrency]!;
  }

  void _swapCurrencies() {
    HapticFeedback.selectionClick();
    setState(() {
      final temp = _fromCurrency;
      _fromCurrency = _toCurrency;
      _toCurrency = temp;
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  const Color(0xFF1E293B).withValues(alpha: 0.8),
                  const Color(0xFF334155).withValues(alpha: 0.6),
                ]
              : [
                  Colors.white.withValues(alpha: 0.9),
                  Colors.grey.shade50.withValues(alpha: 0.8),
                ],
        ),
        borderRadius:
            ((Theme.of(context).cardTheme.shape as RoundedRectangleBorder?)
                ?.borderRadius ??
            BorderRadius.circular(20)),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.grey.withValues(alpha: 0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0D9488).withValues(alpha: 0.2),
                      borderRadius:
                          ((Theme.of(context).cardTheme.shape
                                  as RoundedRectangleBorder?)
                              ?.borderRadius ??
                          BorderRadius.circular(12)),
                    ),
                    child: const Icon(
                      LucideIcons.arrowLeftRight,
                      color: Color(0xFF0D9488),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    AppLocalizations.of(context).currencyConverter,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (_isLoading) ...[
                    const SizedBox(width: 12),
                    const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Color(0xFF0D9488),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              IconButton(
                onPressed: _isLoading ? null : _fetchRates,
                icon: const Icon(LucideIcons.refreshCw, size: 20),
                color: const Color(0xFF0D9488),
                tooltip: AppLocalizations.of(context).refreshRates,
              ),
            ],
          ),
          const SizedBox(height: 20),

          // From Currency
          _buildCurrencyInput(
            label: AppLocalizations.of(context).from,
            controller: _amountController,
            selectedCurrency: _fromCurrency,
            onCurrencyChanged: (val) => setState(() => _fromCurrency = val!),
          ),

          const SizedBox(height: 12),

          // Swap Button
          Center(
            child: GestureDetector(
              onTap: _swapCurrencies,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF0D9488),
                  borderRadius:
                      ((Theme.of(context).cardTheme.shape
                              as RoundedRectangleBorder?)
                          ?.borderRadius ??
                      BorderRadius.circular(12)),
                ),
                child: const Icon(
                  LucideIcons.arrowUpDown,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // To Currency (Read-only)
          _buildCurrencyOutput(
            label: AppLocalizations.of(context).to,
            amount: _convertedAmount,
            selectedCurrency: _toCurrency,
            onCurrencyChanged: (val) => setState(() => _toCurrency = val!),
          ),

          const SizedBox(height: 16),

          // Exchange Rate Info
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : Colors.grey.withValues(alpha: 0.1),
              borderRadius:
                  ((Theme.of(context).cardTheme.shape
                          as RoundedRectangleBorder?)
                      ?.borderRadius ??
                  BorderRadius.circular(12)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(LucideIcons.info, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  '1 $_fromCurrency = ${(_rates[_toCurrency]! / _rates[_fromCurrency]!).toStringAsFixed(4)} $_toCurrency',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _buildCurrencyInput({
    required String label,
    required TextEditingController controller,
    required String selectedCurrency,
    required ValueChanged<String?> onCurrencyChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                onChanged: (_) => setState(() {}),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).cardColor.withValues(alpha: 0.5),
                  border: OutlineInputBorder(
                    borderRadius:
                        ((Theme.of(context).cardTheme.shape
                                    as RoundedRectangleBorder?)
                                ?.borderRadius
                            as BorderRadius?) ??
                        BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            _buildCurrencyDropdown(selectedCurrency, onCurrencyChanged),
          ],
        ),
      ],
    );
  }

  Widget _buildCurrencyOutput({
    required String label,
    required double amount,
    required String selectedCurrency,
    required ValueChanged<String?> onCurrencyChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor.withValues(alpha: 0.5),
                  borderRadius:
                      ((Theme.of(context).cardTheme.shape
                              as RoundedRectangleBorder?)
                          ?.borderRadius ??
                      BorderRadius.circular(12)),
                ),
                child: Text(
                  amount.toStringAsFixed(2),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0D9488),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            _buildCurrencyDropdown(selectedCurrency, onCurrencyChanged),
          ],
        ),
      ],
    );
  }

  Widget _buildCurrencyDropdown(String value, ValueChanged<String?> onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF0D9488).withValues(alpha: 0.2),
        borderRadius:
            ((Theme.of(context).cardTheme.shape as RoundedRectangleBorder?)
                ?.borderRadius ??
            BorderRadius.circular(12)),
      ),
      child: DropdownButton<String>(
        value: value,
        underline: const SizedBox(),
        dropdownColor: Theme.of(context).cardColor,
        style: const TextStyle(
          color: Color(0xFF0D9488),
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        items:
            [
              'TRY',
              'USD',
              'EUR',
              'SAR',
              'YER',
              'AED',
              'KWD',
              'QAR',
              'GBP',
              'EGP',
            ].map((currency) {
              return DropdownMenuItem(value: currency, child: Text(currency));
            }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}

class _ModernPartnerLogo extends StatelessWidget {
  const _ModernPartnerLogo({required this.partner});

  final Partner partner;

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    return Container(
          width: 65,
          height: 65,
          decoration: BoxDecoration(
            color: isLight ? Colors.white : Theme.of(context).cardColor,
            shape: BoxShape.circle,
            border: Border.all(
              color: isLight
                  ? Colors.grey.withValues(alpha: 0.15)
                  : Colors.white.withValues(alpha: 0.1),
              width: 1,
            ),
            boxShadow: isLight
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: partner.logoAsset.trim().isEmpty
                ? Icon(
                    LucideIcons.building2,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.3),
                    size: 24,
                  )
                : partner.logoAsset.startsWith('http')
                ? CachedImageWidget(
                    imageUrl: partner.logoAsset,
                    fit: BoxFit.contain,
                  )
                : Image.asset(
                    partner.logoAsset,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => Icon(
                      LucideIcons.building2,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.3),
                      size: 24,
                    ),
                  ),
          ),
        )
        .animate()
        .fadeIn(duration: 300.ms)
        .scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1));
  }
}

class _SearchResultTile extends ConsumerWidget {
  const _SearchResultTile({required this.place, required this.universities});

  final Place place;
  final List<UniversityModel> universities;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(8),
        leading: ClipRRect(
          borderRadius:
              ((Theme.of(context).cardTheme.shape as RoundedRectangleBorder?)
                  ?.borderRadius ??
              BorderRadius.circular(8)),
          child: SizedBox(
            width: 56,
            height: 56,
            child: _buildImage(place.imageAsset),
          ),
        ),
        title: Text(
          place.nameTr,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          place.category.getLabel(context),
          style: TextStyle(color: Colors.grey[600], fontSize: 12),
        ),
        trailing: const Icon(LucideIcons.chevronLeft),
        onTap: () {
          HapticFeedback.selectionClick();
          if (place.category == PlaceCategory.university) {
            final uni = universities.firstWhere(
              (u) => u.id == place.id,
              orElse: () => UniversityModel(id: '', name: place.nameTr),
            );
            if (uni.id.isNotEmpty) {
              context.push(
                const UniversityDetailsRoute().location(id: uni.id),
                extra: uni,
              );
              return;
            }
          }
          context.push(const PlaceDetailsRoute().location(id: place.id));
        },
      ),
    );
  }

  Widget _buildImage(String rawPath) {
    return CachedImageWidget(
      imageUrl: rawPath,
      fit: BoxFit.cover,
      errorIcon: LucideIcons.imageOff,
    );
  }
}

class _AnnouncementCardFromFirebase extends StatelessWidget {
  const _AnnouncementCardFromFirebase({required this.announcement});

  final Announcement announcement;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to announcement detail screen
        context.push(
          const AnnouncementDetailsRoute().location(id: announcement.id),
          extra: announcement,
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius:
              ((Theme.of(context).cardTheme.shape as RoundedRectangleBorder?)
                  ?.borderRadius ??
              BorderRadius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius:
              ((Theme.of(context).cardTheme.shape as RoundedRectangleBorder?)
                  ?.borderRadius ??
              BorderRadius.circular(16)),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Image
              announcement.imageUrl.isNotEmpty &&
                      announcement.imageUrl.startsWith('http')
                  ? CachedImageWidget(
                      imageUrl: announcement.imageUrl,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      color: const Color(0xFF1E293B),
                      alignment: Alignment.center,
                      child: const Icon(
                        LucideIcons.megaphone,
                        color: Colors.white54,
                        size: 48,
                      ),
                    ),
              // Gradient overlay for text readability
              Container(
                decoration: BoxDecoration(
                  borderRadius:
                      ((Theme.of(context).cardTheme.shape
                              as RoundedRectangleBorder?)
                          ?.borderRadius ??
                      BorderRadius.circular(16)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.8),
                    ],
                  ),
                ),
              ),
              // Content
              Positioned(
                left: 20,
                right: 20,
                bottom: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title
                    if (announcement.title.isNotEmpty)
                      Text(
                        announcement.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    if (announcement.title.isNotEmpty)
                      const SizedBox(height: 8),
                    // Description
                    if (announcement.description.isNotEmpty)
                      Text(
                        announcement.description,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1, end: 0);
  }
}

class _ProjectCard extends StatelessWidget {
  const _ProjectCard({required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        // Dynamic action handling based on Firestore data
        if (project.contactPhone != null && project.contactPhone!.isNotEmpty) {
          final isClub = project.name.contains('نادي');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProjectDetailsPage(
                title: project.name,
                description: project.description ?? '',
                imageUrl: project.imageUrl,
                actionType: isClub
                    ? ProjectActionType.whatsapp
                    : ProjectActionType.contact,
                contactName: AppLocalizations.of(context).contactAndInquiry,
                contactNumber: isClub ? null : project.contactPhone,
                whatsappLink: isClub
                    ? 'https://wa.me/${project.contactPhone?.replaceAll('+', '')}'
                    : null,
              ),
            ),
          );
          return;
        }

        // Fallback for legacy/hardcoded behavior if no phone in DB
        if (project.name.contains('صندوق الطالب')) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProjectDetailsPage(
                title: project.name,
                description: project.description ?? '',
                imageUrl: project.imageUrl,
                actionType: ProjectActionType.contact,
                contactName: AppLocalizations.of(context).fundManager,
                contactNumber: '+905551234567', // Placeholder
              ),
            ),
          );
        } else if (project.name.contains('نادي شعرى') ||
            project.name.contains('نادي انقرة')) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProjectDetailsPage(
                title: project.name,
                description: project.description ?? '',
                imageUrl: project.imageUrl,
                actionType: ProjectActionType.whatsapp,
                whatsappLink: 'https://wa.me/905551234567', // Placeholder
              ),
            ),
          );
        } else {
          // Default fall through
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProjectDetailsPage(
                title: project.name,
                description: project.description ?? 'لا يوجد وصف متاح.',
                imageUrl: project.imageUrl,
              ),
            ),
          );
        }
      },
      child: Container(
        width: 280,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius:
              ((Theme.of(context).cardTheme.shape as RoundedRectangleBorder?)
                  ?.borderRadius ??
              BorderRadius.circular(16)),
        ),
        child: ClipRRect(
          borderRadius:
              ((Theme.of(context).cardTheme.shape as RoundedRectangleBorder?)
                  ?.borderRadius ??
              BorderRadius.circular(16)),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Image or placeholder
              if (project.imageUrl.isNotEmpty &&
                  !project.imageUrl.startsWith('assets') &&
                  project.imageUrl.startsWith('http'))
                CachedImageWidget(imageUrl: project.imageUrl, fit: BoxFit.cover)
              else if (project.imageUrl.startsWith('assets'))
                Image.asset(
                  project.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: const Color(0xFF1E293B),
                    child: const Center(
                      child: Icon(
                        LucideIcons.image,
                        color: Colors.white24,
                        size: 48,
                      ),
                    ),
                  ),
                )
              else
                Container(
                  color: const Color(0xFF1E293B),
                  child: const Center(
                    child: Icon(
                      LucideIcons.folder,
                      color: Colors.white54,
                      size: 48,
                    ),
                  ),
                ),
              // Gradient overlay for text readability
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.7),
                    ],
                    stops: const [0.5, 1.0],
                  ),
                ),
              ),
              // Title
              Positioned(
                left: 16,
                right: 16,
                bottom: 16,
                child: Text(
                  project.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ).animate().fadeIn(duration: 300.ms).slideX(begin: 0.1, end: 0),
    );
  }
}

class _EmergencyBanner extends StatelessWidget {
  final String text;
  const _EmergencyBanner({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.shade50.withValues(alpha: 0.9),
        border: Border.all(color: Colors.red.shade300),
        borderRadius:
            ((Theme.of(context).cardTheme.shape as RoundedRectangleBorder?)
                ?.borderRadius ??
            BorderRadius.circular(12)),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(LucideIcons.alertTriangle, color: Colors.red),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.2, end: 0);
  }
}
