import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/announcement.dart';
import '../../domain/models/contributor.dart';
import '../../domain/models/event.dart';
import '../../domain/models/oversight_committee.dart';
import '../../domain/models/partner.dart';
import '../../domain/models/place.dart';
import '../../domain/models/project.dart';
import '../../domain/models/university_model.dart';
import '../../domain/models/comment.dart';
import 'firestore_repository.dart';

final firestoreRepositoryProvider = Provider<FirestoreRepository>((ref) {
  return FirestoreRepository();
});

final placesStreamProvider = StreamProvider<List<Place>>((ref) {
  final repo = ref.watch(firestoreRepositoryProvider);
  return repo.watchPlaces();
});

final contributorsStreamProvider = StreamProvider<List<Contributor>>((ref) {
  final repo = ref.watch(firestoreRepositoryProvider);
  return repo.watchContributors();
});

final contributorsByYearProvider = StreamProvider.family<List<Contributor>, int>((ref, year) {
  final repo = ref.watch(firestoreRepositoryProvider);
  return repo.watchContributorsByYear(year);
});

final contributorYearsProvider = FutureProvider<List<int>>((ref) async {
  final repo = ref.watch(firestoreRepositoryProvider);
  return repo.getContributorYears();
});

final partnersStreamProvider = StreamProvider<List<Partner>>((ref) {
  final repo = ref.watch(firestoreRepositoryProvider);
  return repo.watchPartners();
});

final projectsStreamProvider = StreamProvider<List<Project>>((ref) {
  final repo = ref.watch(firestoreRepositoryProvider);
  return repo.watchProjects();
});

final eventsStreamProvider = StreamProvider<List<AppEvent>>((ref) {
  final repo = ref.watch(firestoreRepositoryProvider);
  return repo.watchEvents();
});

final universitiesStreamProvider = StreamProvider<List<UniversityModel>>((ref) {
  final repo = ref.watch(firestoreRepositoryProvider);
  return repo.watchUniversities();
});

final announcementsStreamProvider = StreamProvider<List<Announcement>>((ref) {
  final repo = ref.watch(firestoreRepositoryProvider);
  return repo.watchAnnouncements();
});

final announcementByIdProvider = FutureProvider.family<Announcement?, String>((ref, id) async {
  final repo = ref.watch(firestoreRepositoryProvider);
  return repo.getAnnouncementById(id);
});

final oversightCommitteesStreamProvider = StreamProvider<List<OversightCommittee>>((ref) {
  final repo = ref.watch(firestoreRepositoryProvider);
  return repo.watchOversightCommittees();
});

final oversightCommitteesByYearProvider = StreamProvider.family<List<OversightCommittee>, int>((ref, year) {
  final repo = ref.watch(firestoreRepositoryProvider);
  return repo.watchOversightCommitteesByYear(year);
});

final oversightCommitteeYearsProvider = FutureProvider<List<int>>((ref) async {
  final repo = ref.watch(firestoreRepositoryProvider);
  return repo.getOversightCommitteeYears();
});

// Comment submission provider
final submitCommentProvider = Provider<
    Future<bool> Function({
      required String announcementId,
      required String userName,
      required String commentText,
      required String targetType,
    })>((ref) {
  final repo = ref.watch(firestoreRepositoryProvider);
  return ({
    required String announcementId,
    required String userName,
    required String commentText,
    required String targetType,
  }) =>
      repo.submitComment(
        announcementId: announcementId,
        userName: userName,
        commentText: commentText,
        targetType: targetType,
      );
});

// Public reviews stream provider (for directory items)
final publicReviewsProvider = StreamProvider.family<List<Comment>, String>((ref, targetId) {
  final repo = ref.watch(firestoreRepositoryProvider);
  return repo.watchPublicReviews(targetId);
});

