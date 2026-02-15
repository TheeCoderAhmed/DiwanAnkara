import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../ui/home/home_screen.dart';
import '../ui/directory/directory_screen.dart';
import '../ui/more/more_screen.dart';
import '../ui/universities/university_detail_screen.dart';
import '../ui/shared/not_found_screen.dart';
import '../ui/pdf/pdf_viewer_screen.dart';
import '../ui/places/place_details_screen.dart';
import '../ui/places/place_list_screen.dart';
import '../domain/models/university_model.dart';
import '../ui/places/saved_places_screen.dart';
import '../ui/contributors/contributors_timeline_screen.dart';
import '../ui/oversight_committees/oversight_committees_timeline_screen.dart';
import '../ui/events/event_details_screen.dart';
import '../ui/events/events_screen.dart';
import '../ui/events/previous_events_screen.dart';
import '../ui/announcements/announcement_detail_screen.dart';
import '../ui/onboarding/onboarding_screen.dart';
import '../domain/models/event.dart';
import '../domain/models/announcement.dart';
import '../services/onboarding_service.dart';
import '../settings/theme_controller.dart';
import '../ui/shared/ambient_background.dart';
import '../ui/shared/floating_navigation_bar.dart';
import '../ui/notifications/notifications_screen.dart';
import '../services/notification_controller.dart';
import '../ui/widgets/in_app_message_overlay.dart';
import 'package:yc_ankara_app/l10n/app_localizations.dart';

/// Global router reference for deep linking navigation from outside widget context
GoRouter? globalRouterRef;

final goRouterProvider = Provider<GoRouter>((ref) {
  final prefs = ref.watch(sharedPrefsProvider);
  final onboardingService = OnboardingService(prefs);
  
  final router = GoRouter(

    debugLogDiagnostics: false,
    initialLocation: const HomeScreenRoute().location,
    errorBuilder: (_, __) => const NotFoundScreen(),
    redirect: (context, state) {
      final hasSeenOnboarding = onboardingService.hasSeenOnboarding();
      final isOnOnboardingPage = state.uri.path == const OnboardingRoute().path;
      
      // If user hasn't seen onboarding and not already on onboarding page, redirect to onboarding
      if (!hasSeenOnboarding && !isOnOnboardingPage) {
        return const OnboardingRoute().location;
      }
      
      // If user has seen onboarding and is on onboarding page, redirect to home
      if (hasSeenOnboarding && isOnOnboardingPage) {
        return const HomeScreenRoute().location;
      }
      
      return null; // No redirect needed
    },
    routes: [
      // Onboarding route (standalone, outside shell)
      GoRoute(
        path: const OnboardingRoute().path,
        name: const OnboardingRoute().name,
        builder: (_, __) => const OnboardingScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: const HomeScreenRoute().path,
                name: const HomeScreenRoute().name,
                builder: (_, __) => const HomeScreen(),
              ),
              GoRoute(
                path: const NotificationsRoute().path,
                name: const NotificationsRoute().name,
                builder: (_, __) => const NotificationsScreen(),
              ),
              GoRoute(
                path: const PdfViewerRoute().path,
                name: const PdfViewerRoute().name,
                builder: (context, state) {
                  final title = state.uri.queryParameters['title'] ?? 'PDF';
                  final asset = state.uri.queryParameters['asset'] ?? '';
                  return PdfViewerScreen(title: title, pdfAssetPath: asset);
                },
              ),
              GoRoute(
                path: const PlaceListRoute().path,
                name: const PlaceListRoute().name,
                builder: (context, state) {
                  final cat = state.uri.queryParameters['category'] ?? '';
                  return PlaceListScreen(category: cat);
                },
              ),
              GoRoute(
                path: const PlaceDetailsRoute().path,
                name: const PlaceDetailsRoute().name,
                builder: (context, state) {
                  final id = state.pathParameters['id'] ?? '';
                  return PlaceDetailsScreen(placeId: id);
                },
              ),
              GoRoute(
                path: const UniversityDetailsRoute().path,
                name: const UniversityDetailsRoute().name,
                builder: (context, state) {
                  final university = state.extra as UniversityModel;
                  return UniversityDetailScreen(university: university);
                },
              ),
              GoRoute(
                path: const EventDetailsRoute().path,
                name: const EventDetailsRoute().name,
                builder: (context, state) {
                  final eventId = state.pathParameters['id'] ?? '';
                  final imageAsset = state.uri.queryParameters['image'] ?? '';
                  final url = state.uri.queryParameters['url'] ?? '';
                  final event = AppEvent(
                    id: eventId,
                    imageAsset: imageAsset,
                    url: url,
                    title: AppLocalizations.of(context).eventDetails,
                    description: '',
                    date: DateTime.now(),
                    location: '',
                    category: EventCategory.other,
                  );
                  return EventDetailsScreen(event: event);
                },
              ),
              GoRoute(
                path: const AnnouncementDetailsRoute().path,
                name: const AnnouncementDetailsRoute().name,
                builder: (context, state) {
                  final announcementId = state.pathParameters['id'] ?? '';
                  final announcement = state.extra as Announcement?;
                  return AnnouncementDetailScreen(
                    announcementId: announcementId,
                    announcement: announcement,
                  );
                },
              ),
              GoRoute(
                path: EventsRoute.path,
                name: EventsRoute.name,
                builder: (_, __) => const EventsScreen(),
              ),
              GoRoute(
                path: const PreviousEventsRoute().path,
                name: const PreviousEventsRoute().name,
                builder: (_, __) => const PreviousEventsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: const DirectoryScreenRoute().path,
                name: const DirectoryScreenRoute().name,
                builder: (_, __) => const DirectoryScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: const MoreScreenRoute().path,
                name: const MoreScreenRoute().name,
                builder: (_, __) => const MoreScreen(),
              ),
              GoRoute(
                path: const SavedPlacesRoute().path,
                name: const SavedPlacesRoute().name,
                builder: (_, __) => const SavedPlacesScreen(),
              ),
              GoRoute(
                path: const ContributorsTimelineRoute().path,
                name: const ContributorsTimelineRoute().name,
                builder: (_, __) => const ContributorsTimelineScreen(),
              ),
              GoRoute(
                path: const OversightCommitteesTimelineRoute().path,
                name: const OversightCommitteesTimelineRoute().name,
                builder: (_, __) => const OversightCommitteesTimelineScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
  
  // Set global router reference for deep linking
  globalRouterRef = router;
  
  return router;
});


class HomeScreenRoute {
  const HomeScreenRoute();
  String get name => 'home';
  String get path => '/';
  String get location => path;
}

class NotificationsRoute {
  const NotificationsRoute();
  String get name => 'notifications';
  String get path => '/notifications';
  String get location => path;
}

class DirectoryScreenRoute {
  const DirectoryScreenRoute();
  String get name => 'directory';
  String get path => '/directory';
  String get location => path;
}

class MoreScreenRoute {
  const MoreScreenRoute();
  String get name => 'more';
  String get path => '/more';
  String get location => path;
}

class ContributorsTimelineRoute {
  const ContributorsTimelineRoute();
  String get name => 'contributors-timeline';
  String get path => '/contributors-timeline';
  String get location => path;
}

class OversightCommitteesTimelineRoute {
  const OversightCommitteesTimelineRoute();
  String get name => 'oversight-committees-timeline';
  String get path => '/oversight-committees-timeline';
  String get location => path;
}

class SavedPlacesRoute {
  const SavedPlacesRoute();
  String get name => 'saved-places';
  String get path => '/saved-places';
  String get location => path;
}

class OnboardingRoute {
  const OnboardingRoute();
  String get name => 'onboarding';
  String get path => '/onboarding';
  String get location => path;
}

class PdfViewerRoute {
  const PdfViewerRoute();
  String get name => 'pdf';
  String get path => '/pdf';
  String location({required String title, required String assetPath}) {
    return Uri(
      path: path,
      queryParameters: {
        'title': title,
        'asset': assetPath,
      },
    ).toString();
  }
}

class PlaceListRoute {
  const PlaceListRoute();
  String get name => 'places';
  String get path => '/places';
  String location({required String category}) {
    return Uri(path: path, queryParameters: {'category': category}).toString();
  }
}

class PlaceDetailsRoute {
  const PlaceDetailsRoute();
  String get name => 'place_details';
  String get path => '/places/:id';
  String location({required String id}) => '/places/$id';
}

class UniversityDetailsRoute {
  const UniversityDetailsRoute();
  String get name => 'university_details';
  String get path => '/universities/:id';
  String location({required String id}) => '/universities/$id';
}

class EventDetailsRoute {
  const EventDetailsRoute();
  String get name => 'event_details';
  String get path => '/events/:id';
  String location({
    required String id,
    required String image,
    required String url,
  }) {
    return Uri(
      path: '/events/$id',
      queryParameters: {
        'image': image,
        'url': url,
      },
    ).toString();
  }
}

class AnnouncementDetailsRoute {
  const AnnouncementDetailsRoute();
  String get name => 'announcement_details';
  String get path => '/announcements/:id';
  String location({required String id}) => '/announcements/$id';
}

class EventsRoute {
  const EventsRoute();
  static const name = 'events';
  static const path = '/events';
  static const location = path;
}

class PreviousEventsRoute {
  const PreviousEventsRoute();
  String get name => 'previous_events';
  String get path => '/previous_events';
  String get location => path;
}

class AppShell extends ConsumerWidget {
  const AppShell({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  void _onDestinationSelected(BuildContext context, int index) {
    // If Directory tab (index 1) is tapped while already active, pop to root
    if (index == 1 && navigationShell.currentIndex == 1) {
      // Pop all routes in the Directory branch to return to root
      while (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
    }
    // Navigate to the selected branch
    navigationShell.goBranch(index);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Activate notification listener
    ref.watch(notificationListenerProvider);
    
    return AmbientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: InAppMessageOverlay(child: navigationShell),
        extendBody: true,
        bottomNavigationBar: FloatingNavigationBar(
          currentIndex: navigationShell.currentIndex,
          onDestinationSelected: (index) => _onDestinationSelected(context, index),
        ),
      ),
    );
  }
}
