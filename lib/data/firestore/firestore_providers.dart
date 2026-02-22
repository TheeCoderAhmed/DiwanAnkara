import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/event.dart' show AppEvent;

import '../../domain/models/announcement.dart';
import '../../domain/models/contributor.dart';
import '../../domain/models/event.dart';
import '../../domain/models/oversight_committee.dart';
import '../../domain/models/partner.dart';
import '../../domain/models/place.dart';
import '../../domain/models/project.dart';
import '../../domain/models/university_model.dart';
import '../../domain/models/comment.dart';
import '../../domain/models/app_settings.dart';
import 'firestore_repository.dart';
import '../local/local_repository.dart';

final firestoreRepositoryProvider = Provider<FirestoreRepository>((ref) {
  return FirestoreRepository();
});

final appSettingsProvider = StreamProvider<AppSettings>((ref) {
  final repo = ref.watch(firestoreRepositoryProvider);
  return repo.watchAppSettings();
});

final placesStreamProvider = StreamProvider<List<Place>>((ref) async* {
  yield LocalRepository.getCachedData<Place>(
    key: 'places',
    fromJson: (json) => Place.fromJson(json),
  );

  final repo = ref.watch(firestoreRepositoryProvider);
  await for (final items in repo.watchPlaces()) {
    await LocalRepository.cacheData<Place>(
      key: 'places',
      items: items,
      toJson: (item) => item.toJson(),
    );
    yield items;
  }
});

final contributorsStreamProvider = StreamProvider<List<Contributor>>((ref) {
  final repo = ref.watch(firestoreRepositoryProvider);
  return repo.watchContributors();
});

final contributorsByYearProvider =
    StreamProvider.family<List<Contributor>, int>((ref, year) {
      final repo = ref.watch(firestoreRepositoryProvider);
      return repo.watchContributorsByYear(year);
    });

final contributorYearsProvider = FutureProvider<List<int>>((ref) async {
  final repo = ref.watch(firestoreRepositoryProvider);
  return repo.getContributorYears();
});

final partnersStreamProvider = StreamProvider<List<Partner>>((ref) async* {
  yield LocalRepository.getCachedData<Partner>(
    key: 'partners',
    fromJson: (json) => Partner.fromJson(json),
  );

  final repo = ref.watch(firestoreRepositoryProvider);
  await for (final items in repo.watchPartners()) {
    await LocalRepository.cacheData<Partner>(
      key: 'partners',
      items: items,
      toJson: (item) => item.toJson(),
    );
    yield items;
  }
});

final projectsStreamProvider = StreamProvider<List<Project>>((ref) async* {
  yield LocalRepository.getCachedData<Project>(
    key: 'projects',
    fromJson: (json) => Project.fromJson(json),
  );

  final repo = ref.watch(firestoreRepositoryProvider);
  await for (final items in repo.watchProjects()) {
    await LocalRepository.cacheData<Project>(
      key: 'projects',
      items: items,
      toJson: (item) => item.toJson(),
    );
    yield items;
  }
});

final eventsStreamProvider = StreamProvider<List<AppEvent>>((ref) async* {
  yield LocalRepository.getCachedData<AppEvent>(
    key: 'events',
    fromJson: (json) => AppEvent.fromJson(json),
  );

  final repo = ref.watch(firestoreRepositoryProvider);
  await for (final items in repo.watchEvents()) {
    await LocalRepository.cacheData<AppEvent>(
      key: 'events',
      items: items,
      toJson: (item) => item.toJson(),
    );
    yield items;
  }
});

final universitiesStreamProvider = StreamProvider<List<UniversityModel>>((
  ref,
) async* {
  // 1. Emitting cached data immediately
  yield LocalRepository.getCachedData<UniversityModel>(
    key: 'universities',
    fromJson: (json) =>
        UniversityModel.fromJson(json, id: json['id'] as String?),
  );

  final repo = ref.watch(firestoreRepositoryProvider);

  // 2. Sync with Firestore
  await for (final unis in repo.watchUniversities()) {
    await LocalRepository.cacheData<UniversityModel>(
      key: 'universities',
      items: unis,
      toJson: (uni) => uni.toJson(),
    );
    yield unis;
  }
});

final announcementsStreamProvider = StreamProvider<List<Announcement>>((
  ref,
) async* {
  yield LocalRepository.getCachedData<Announcement>(
    key: 'announcements',
    fromJson: (json) => Announcement.fromJson(json),
  );

  final repo = ref.watch(firestoreRepositoryProvider);
  await for (final items in repo.watchAnnouncements()) {
    await LocalRepository.cacheData<Announcement>(
      key: 'announcements',
      items: items,
      toJson: (item) => item.toJson(),
    );
    yield items;
  }
});

final announcementByIdProvider = FutureProvider.family<Announcement?, String>((
  ref,
  id,
) async {
  final repo = ref.watch(firestoreRepositoryProvider);
  return repo.getAnnouncementById(id);
});

final oversightCommitteesStreamProvider =
    StreamProvider<List<OversightCommittee>>((ref) {
      final repo = ref.watch(firestoreRepositoryProvider);
      return repo.watchOversightCommittees();
    });

final oversightCommitteesByYearProvider =
    StreamProvider.family<List<OversightCommittee>, int>((ref, year) {
      final repo = ref.watch(firestoreRepositoryProvider);
      return repo.watchOversightCommitteesByYear(year);
    });

final oversightCommitteeYearsProvider = FutureProvider<List<int>>((ref) async {
  final repo = ref.watch(firestoreRepositoryProvider);
  return repo.getOversightCommitteeYears();
});

// Comment submission provider
final submitCommentProvider =
    Provider<
      Future<bool> Function({
        required String announcementId,
        required String userName,
        required String commentText,
        required String targetType,
        List<String> imageUrls,
        double rating,
        String? userId,
      })
    >((ref) {
      final repo = ref.watch(firestoreRepositoryProvider);
      return ({
        required String announcementId,
        required String userName,
        required String commentText,
        required String targetType,
        List<String> imageUrls = const [],
        double rating = 0.0,
        String? userId,
      }) => repo.submitComment(
        announcementId: announcementId,
        userName: userName,
        commentText: commentText,
        targetType: targetType,
        imageUrls: imageUrls,
        rating: rating,
        userId: userId,
      );
    });

// Comment deletion provider
final deleteCommentProvider = Provider<Future<bool> Function(String commentId)>(
  (ref) {
    final repo = ref.watch(firestoreRepositoryProvider);
    return (commentId) => repo.deleteComment(commentId);
  },
);

// Public reviews stream provider (for directory items)
final publicReviewsProvider = StreamProvider.family<List<Comment>, String>((
  ref,
  targetId,
) {
  final repo = ref.watch(firestoreRepositoryProvider);
  return repo.watchPublicReviews(targetId);
});

// ─────────────────────────────────────────────────────────────
// Derived event providers — memoized, never recompute unless
// the underlying eventsStreamProvider emits a new list.
// Avoids sorting/filtering inside build() on every setState.
// ─────────────────────────────────────────────────────────────

/// Upcoming events: date > now-1h, sorted ascending.
final upcomingEventsProvider = Provider<List<AppEvent>>((ref) {
  final events = ref.watch(eventsStreamProvider).valueOrNull ?? [];
  final cutoff = DateTime.now().subtract(const Duration(hours: 1));
  return events.where((e) => e.date.isAfter(cutoff)).toList()
    ..sort((a, b) => a.date.compareTo(b.date));
});

/// Past events: date ≤ now-1h, sorted descending (most recent first).
final pastEventsProvider = Provider<List<AppEvent>>((ref) {
  final events = ref.watch(eventsStreamProvider).valueOrNull ?? [];
  final cutoff = DateTime.now().subtract(const Duration(hours: 1));
  return events.where((e) => e.date.isBefore(cutoff)).toList()
    ..sort((a, b) => b.date.compareTo(a.date));
});

/// Map of normalised date → events on that day. Used by the calendar dot loader.
final eventsByDayProvider = Provider<Map<DateTime, List<AppEvent>>>((ref) {
  final events = ref.watch(eventsStreamProvider).valueOrNull ?? [];
  final map = <DateTime, List<AppEvent>>{};
  for (final e in events) {
    final d = DateTime(e.date.year, e.date.month, e.date.day);
    (map[d] ??= []).add(e);
  }
  return map;
});
