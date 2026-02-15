import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/models/announcement.dart';
import '../../domain/models/contributor.dart';
import '../../domain/models/event.dart';
import '../../domain/models/oversight_committee.dart';
import '../../domain/models/partner.dart';
import '../../domain/models/place.dart';
import '../../domain/models/project.dart';
import '../../domain/models/university_model.dart';
import '../../domain/models/comment.dart';

class FirestoreRepository {
  final FirebaseFirestore? _firestore;

  FirestoreRepository({FirebaseFirestore? firestore})
      : _firestore = firestore;

  FirebaseFirestore get _safeFirestore {
    try {
      return _firestore ?? FirebaseFirestore.instance;
    } catch (e) {
      throw StateError(
        'Firebase not initialized. Run "flutterfire configure" to set up Firebase.',
      );
    }
  }

  // Places collection
  Stream<List<Place>> watchPlaces() {
    try {
      return _safeFirestore
          .collection('places')
          .snapshots()
          .map((snapshot) {
            final list = snapshot.docs
                .map((doc) => Place.fromJson({...doc.data(), 'id': doc.id}))
                .toList();
            // Sort by order field (lower = first)
            list.sort((a, b) => (a.order ?? 999).compareTo(b.order ?? 999));
            return list;
          });
    } catch (e) {
      return Stream.value(<Place>[]);
    }
  }

  // Contributors collection (fetching from Council collection)
  Stream<List<Contributor>> watchContributors() {
    try {
      return _safeFirestore
          .collection('Council')
          .snapshots()
          .map((snapshot) {
            final list = snapshot.docs
                .map((doc) => Contributor.fromJson(doc.data()))
                .toList();
            // Sort by order field
            list.sort((a, b) => (a.order ?? 999).compareTo(b.order ?? 999));
            return list;
          });
    } catch (e) {
      return Stream.value(<Contributor>[]);
    }
  }

  // Contributors by year (fetching from Council collection)
  Stream<List<Contributor>> watchContributorsByYear(int year) {
    try {
      return _safeFirestore
          .collection('Council')
          .where('year', isEqualTo: year)
          .snapshots()
          .map((snapshot) {
            final list = snapshot.docs
                .map((doc) => Contributor.fromJson(doc.data()))
                .toList();
            // Sort by order field
            list.sort((a, b) => (a.order ?? 999).compareTo(b.order ?? 999));
            return list;
          });
    } catch (e) {
      return Stream.value(<Contributor>[]);
    }
  }

  // Get available years for contributors (fetching from Council collection)
  Future<List<int>> getContributorYears() async {
    try {
      final snapshot = await _safeFirestore.collection('Council').get();
      final years = <int>{};
      for (var doc in snapshot.docs) {
        final year = doc.data()['year'] as int?;
        if (year != null) years.add(year);
      }
      return years.toList()..sort((a, b) => b.compareTo(a));
    } catch (e) {
      return <int>[];
    }
  }

  // Partners collection - Query from 'places' with specific categories
  Stream<List<Partner>> watchPartners() {
    try {
      return _safeFirestore
          .collection('places')
          .where('category', whereIn: ['الرئيسية', 'شركاء النجاح', 'partners'])
          .snapshots()
          .map((snapshot) {
            final list = snapshot.docs
                .map((doc) => Partner.fromJson({...doc.data(), 'id': doc.id}))
                .toList();
            // Sort by order field
            list.sort((a, b) => (a.order ?? 999).compareTo(b.order ?? 999));
            return list;
          });
    } catch (e) {
      return Stream.value(<Partner>[]);
    }
  }

  // Projects collection - Query from 'places' with category 'مشاريعنا'
  Stream<List<Project>> watchProjects() {
    try {
      return _safeFirestore
          .collection('projects')
          .snapshots()
          .map((snapshot) {
            final list = snapshot.docs
              .map((doc) => Project.fromJson({...doc.data(), 'id': doc.id}))
              .toList();
            // Sort by order field
            list.sort((a, b) => (a.order ?? 999).compareTo(b.order ?? 999));
            return list;
          });
    } catch (e) {
      return Stream.value(<Project>[]);
    }
  }

  // Events collection (if needed)
  Stream<List<AppEvent>> watchEvents() {
    try {
      return _safeFirestore
          .collection('events')
          .snapshots()
          .map((snapshot) {
            final list = snapshot.docs
                .map((doc) => AppEvent.fromJson({...doc.data(), 'id': doc.id}))
                .toList();
            // Sort by date ascending
            list.sort((a, b) => a.date.compareTo(b.date));
            return list;
          });
    } catch (e) {
      return Stream.value(<AppEvent>[]);
    }
  }

  // Universities collection
  Stream<List<UniversityModel>> watchUniversities() {
    try {
      return _safeFirestore
          .collection('universities')
          .snapshots()
          .map((snapshot) {
            final list = snapshot.docs
                .map((doc) => UniversityModel.fromJson(doc.data()))
                .toList();
            // Sort by order field
            list.sort((a, b) => (a.order ?? 999).compareTo(b.order ?? 999));
            return list;
          });
    } catch (e) {
      return Stream.value(<UniversityModel>[]);
    }
  }

  // Announcements collection (note: DB has typo 'annoucments')
  Stream<List<Announcement>> watchAnnouncements() {
    try {
      return _safeFirestore
          .collection('annoucments')  // Matches DB spelling (missing 'n')
          .snapshots()
          .map((snapshot) {
        try {
          final list = snapshot.docs
              .map((doc) =>
                  Announcement.fromJson({...doc.data(), 'id': doc.id}))
              .toList();
          // Sort by order field (if set), then by date descending
          list.sort((a, b) {
            final orderA = a.order ?? 999;
            final orderB = b.order ?? 999;
            if (orderA != orderB) return orderA.compareTo(orderB);
            return b.date.compareTo(a.date);
          });
          return list;
        } catch (e) {
          // If mapping fails, return empty list to prevent stream error
          return <Announcement>[];
        }
      });
    } catch (e) {
      return Stream.value(<Announcement>[]);
    }
  }

  // Get single announcement by ID (for deep linking)
  Future<Announcement?> getAnnouncementById(String id) async {
    try {
      final doc = await _safeFirestore.collection('annoucments').doc(id).get();
      if (!doc.exists) return null;
      return Announcement.fromJson({...doc.data()!, 'id': doc.id});
    } catch (e) {
      return null;
    }
  }

  // Oversight Committees collection
  Stream<List<OversightCommittee>> watchOversightCommittees() {
    try {
      return _safeFirestore
          .collection('OversightCommittee')
          .snapshots()
          .map((snapshot) {
            final list = snapshot.docs
                .map((doc) => OversightCommittee.fromJson(doc.data()))
                .toList();
            // Sort by order field
            list.sort((a, b) => (a.order ?? 999).compareTo(b.order ?? 999));
            return list;
          });
    } catch (e) {
      return Stream.value(<OversightCommittee>[]);
    }
  }

  // Oversight Committees by year
  Stream<List<OversightCommittee>> watchOversightCommitteesByYear(int year) {
    try {
      return _safeFirestore
          .collection('OversightCommittee')
          .where('year', isEqualTo: year)
          .snapshots()
          .map((snapshot) {
            final list = snapshot.docs
                .map((doc) => OversightCommittee.fromJson(doc.data()))
                .toList();
            // Sort by order field
            list.sort((a, b) => (a.order ?? 999).compareTo(b.order ?? 999));
            return list;
          });
    } catch (e) {
      return Stream.value(<OversightCommittee>[]);
    }
  }

  // Get available years for oversight committees
  Future<List<int>> getOversightCommitteeYears() async {
    try {
      final snapshot = await _safeFirestore.collection('OversightCommittee').get();
      final years = <int>{};
      for (var doc in snapshot.docs) {
        final year = doc.data()['year'] as int?;
        if (year != null) years.add(year);
      }
      return years.toList()..sort((a, b) => b.compareTo(a));
    } catch (e) {
      return <int>[];
    }
  }

  // Comments - Submit a new comment/review
  Future<bool> submitComment({
    required String announcementId,
    required String userName,
    required String commentText,
    required String targetType,
  }) async {
    try {
      final docRef = _safeFirestore.collection('Comments').doc();
      await docRef.set({
        'id': docRef.id,
        'announcementId': announcementId,
        'userName': userName,
        'commentText': commentText,
        'timestamp': FieldValue.serverTimestamp(),
        'status': 'pending',
        'targetType': targetType,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  // Comments - Watch public reviews for a specific target (directory items)
  Stream<List<Comment>> watchPublicReviews(String targetId) {
    try {
      return _safeFirestore
          .collection('Comments')
          .where('announcementId', isEqualTo: targetId)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) {
                try {
                  final comment = Comment.fromJson({...doc.data(), 'id': doc.id});
                  // Filter approved comments in code to avoid composite index
                  return comment.status == 'approved' ? comment : null;
                } catch (e) {
                  return null;
                }
              })
              .whereType<Comment>()
              .toList()
              ..sort((a, b) => b.timestamp.compareTo(a.timestamp))); // Sort by timestamp descending
    } catch (e) {
      return Stream.value(<Comment>[]);
    }
  }

  // Comments - Watch comments for a specific announcement (kept for backward compatibility)
  Stream<List<Map<String, dynamic>>> watchComments(String announcementId) {
    try {
      return _safeFirestore
          .collection('Comments')
          .where('announcementId', isEqualTo: announcementId)
          .where('status', isEqualTo: 'approved')
          .orderBy('timestamp', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => {...doc.data(), 'id': doc.id})
              .toList());
    } catch (e) {
      return Stream.value(<Map<String, dynamic>>[]);
    }
  }
}


