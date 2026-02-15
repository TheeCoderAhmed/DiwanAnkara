import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../settings/theme_controller.dart';
import 'favorites_service.dart';

/// Provider for FavoritesService
final favoritesServiceProvider = Provider<FavoritesService>((ref) {
  final prefs = ref.watch(sharedPrefsProvider);
  return FavoritesService(prefs);
});

/// StateNotifier to manage favorites state
class FavoritesNotifier extends StateNotifier<List<String>> {
  final FavoritesService _service;

  FavoritesNotifier(this._service) : super(_service.getSavedPlaceIds());

  void loadFavorites() {
    state = _service.getSavedPlaceIds();
  }

  Future<void> toggleFavorite(String placeId) async {
    await _service.togglePlace(placeId);
    state = _service.getSavedPlaceIds();
  }

  bool isFavorite(String placeId) {
    return state.contains(placeId);
  }
}

/// Provider for favorites notifier
final favoritesProvider = StateNotifierProvider<FavoritesNotifier, List<String>>((ref) {
  final service = ref.watch(favoritesServiceProvider);
  return FavoritesNotifier(service);
});
