import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/firestore/firestore_providers.dart';
import '../../domain/models/categories.dart';
import '../../domain/models/place.dart';

/// Provider that transforms the list of universities into Place models.
/// This is memoized by Riverpod, so it won't re-calculate unless the source
/// universities stream changes.
final mappedUniversitiesProvider = Provider<List<Place>>((ref) {
  final universities = ref.watch(universitiesStreamProvider).valueOrNull ?? [];
  
  return universities.map((u) => Place(
    id: u.id,
    category: PlaceCategory.university,
    nameTr: u.name,
    descriptionAr: u.descriptionAr ?? 'جامعة في تركيا',
    lat: u.lat ?? 0,
    lng: u.lng ?? 0,
    imageAsset: u.logoUrl ?? '',
    isPopular: false,
    documents: const [],
    pdfUrl: u.introductionDocUrl,
    docUrl: u.bachelorDocUrl, 
  )).toList();
});
