import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yc_ankara_app/services/favorites_service.dart';
import 'package:yc_ankara_app/services/favorites_provider.dart';

void main() {
  group('FavoritesNotifier', () {
    late FavoritesService service;
    late FavoritesNotifier notifier;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      service = FavoritesService(prefs);
      notifier = FavoritesNotifier(service);
    });

    test('initializes with empty favorites', () {
      expect(notifier.state, isEmpty);
    });

    test('toggleFavorite adds and removes correctly', () async {
      await notifier.toggleFavorite('place_1');
      expect(notifier.state, contains('place_1'));

      await notifier.toggleFavorite('place_1');
      expect(notifier.state, isNot(contains('place_1')));
    });

    test('isFavorite returns correct state', () async {
      expect(notifier.isFavorite('place_1'), isFalse);

      await notifier.toggleFavorite('place_1');
      expect(notifier.isFavorite('place_1'), isTrue);
    });

    test('loadFavorites refreshes state from service', () async {
      // Manually add via service directly
      await service.addPlace('place_direct');

      // Notifier state should be stale
      expect(notifier.state, isNot(contains('place_direct')));

      // Reload
      notifier.loadFavorites();
      expect(notifier.state, contains('place_direct'));
    });
  });
}
