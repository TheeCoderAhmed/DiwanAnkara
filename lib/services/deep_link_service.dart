import 'package:flutter/foundation.dart';

import '../routing/app_router.dart';


/// Service to handle deep link parsing and navigation
/// 
/// Deep link format: `screen_name:document_id`
/// Examples:
///   - `announcement:abc123` → Opens announcement detail
///   - `place:uni_12345` → Opens place detail (university)
///   - `places:university` → Opens places list filtered by category
///   - `council` → Opens contributors timeline
///   - `oversight` → Opens oversight committees timeline
///   - `home` → Opens home screen
class DeepLinkService {
  static final DeepLinkService _instance = DeepLinkService._internal();
  factory DeepLinkService() => _instance;
  DeepLinkService._internal();

  /// Handle a deep link and navigate to the appropriate screen
  /// 
  /// [link] - The deep link string in format `screen_name:document_id`
  void handleDeepLink(String link) {
    if (link.isEmpty) {
      debugPrint('DeepLinkService: Empty link received');
      return;
    }

    debugPrint('DeepLinkService: Handling deep link: $link');

    // Split the link by our delimiter ':'
    // 'announcement:abc123xyz' becomes ['announcement', 'abc123xyz']
    final List<String> parts = link.split(':');
    final String screenName = parts[0].toLowerCase();
    final String? documentId = parts.length > 1 ? parts[1] : null;

    // Get the router instance
    final router = globalRouterRef;
    if (router == null) {
      debugPrint('DeepLinkService: Router not available');
      return;
    }

    // Navigate to the appropriate screen
    switch (screenName) {
      case 'announcement':
        if (documentId != null && documentId.isNotEmpty) {
          final location = const AnnouncementDetailsRoute().location(id: documentId);
          debugPrint('DeepLinkService: Navigating to announcement: $location');
          router.go(location);
        } else {
          debugPrint('DeepLinkService: Announcement ID missing, going home');
          router.go(const HomeScreenRoute().location);
        }
        break;

      case 'place':
        if (documentId != null && documentId.isNotEmpty) {
          final location = const PlaceDetailsRoute().location(id: documentId);
          debugPrint('DeepLinkService: Navigating to place: $location');
          router.go(location);
        } else {
          debugPrint('DeepLinkService: Place ID missing, going to places list');
          router.go(const PlaceListRoute().location(category: ''));
        }
        break;

      case 'places':
        // documentId here is used as category filter
        final category = documentId ?? '';
        final location = const PlaceListRoute().location(category: category);
        debugPrint('DeepLinkService: Navigating to places list: $location');
        router.go(location);
        break;

      case 'council':
        debugPrint('DeepLinkService: Navigating to contributors timeline');
        router.go(const ContributorsTimelineRoute().location);
        break;

      case 'oversight':
        debugPrint('DeepLinkService: Navigating to oversight committees');
        router.go(const OversightCommitteesTimelineRoute().location);
        break;

      case 'home':
        debugPrint('DeepLinkService: Navigating to home');
        router.go(const HomeScreenRoute().location);
        break;

      case 'saved':
        debugPrint('DeepLinkService: Navigating to saved places');
        router.go(const SavedPlacesRoute().location);
        break;

      case 'directory':
        debugPrint('DeepLinkService: Navigating to directory');
        router.go(const DirectoryScreenRoute().location);
        break;

      case 'more':
        debugPrint('DeepLinkService: Navigating to more screen');
        router.go(const MoreScreenRoute().location);
        break;

      default:
        debugPrint('DeepLinkService: No matching screen found for: $screenName');
        // Default to home if no match found
        router.go(const HomeScreenRoute().location);
    }
  }
}
