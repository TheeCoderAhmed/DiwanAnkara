import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yc_ankara_app/services/favorites_service.dart';

void main() {
  group('FavoritesService', () {
    late FavoritesService service;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      service = FavoritesService(prefs);
    });

    test('returns empty list when no favorites saved', () {
      expect(service.getSavedPlaceIds(), isEmpty);
    });

    test('adds place to favorites', () async {
      await service.addPlace('place_1');
      expect(service.getSavedPlaceIds(), contains('place_1'));
    });

    test('does not add duplicate places', () async {
      await service.addPlace('place_1');
      await service.addPlace('place_1');
      expect(service.getSavedPlaceIds().length, equals(1));
    });

    test('removes place from favorites', () async {
      await service.addPlace('place_1');
      await service.removePlace('place_1');
      expect(service.getSavedPlaceIds(), isEmpty);
    });

    test('handles removing non-existent place gracefully', () async {
      // Should not throw
      await service.removePlace('non_existent');
      expect(service.getSavedPlaceIds(), isEmpty);
    });

    test('toggles place state correctly', () async {
      // Toggle on
      await service.togglePlace('place_1');
      expect(service.isPlaceSaved('place_1'), isTrue);

      // Toggle off
      await service.togglePlace('place_1');
      expect(service.isPlaceSaved('place_1'), isFalse);
    });

    test('isPlaceSaved returns correct boolean', () async {
      expect(service.isPlaceSaved('place_1'), isFalse);
      await service.addPlace('place_1');
      expect(service.isPlaceSaved('place_1'), isTrue);
    });
  });
}
