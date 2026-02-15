import 'package:shared_preferences/shared_preferences.dart';

/// Service to manage saved/favorited place IDs using SharedPreferences
class FavoritesService {
  static const String _favoritesKey = 'saved_places';

  final SharedPreferences _prefs;

  FavoritesService(this._prefs);

  /// Get list of saved place IDs
  List<String> getSavedPlaceIds() {
    return _prefs.getStringList(_favoritesKey) ?? [];
  }

  /// Check if a place is saved
  bool isPlaceSaved(String placeId) {
    final savedIds = getSavedPlaceIds();
    return savedIds.contains(placeId);
  }

  /// Add a place to saved places
  Future<bool> addPlace(String placeId) async {
    final savedIds = getSavedPlaceIds();
    if (!savedIds.contains(placeId)) {
      savedIds.add(placeId);
      return await _prefs.setStringList(_favoritesKey, savedIds);
    }
    return true;
  }

  /// Remove a place from saved places
  Future<bool> removePlace(String placeId) async {
    final savedIds = getSavedPlaceIds();
    savedIds.remove(placeId);
    return await _prefs.setStringList(_favoritesKey, savedIds);
  }

  /// Toggle save state for a place
  Future<bool> togglePlace(String placeId) async {
    if (isPlaceSaved(placeId)) {
      return await removePlace(placeId);
    } else {
      return await addPlace(placeId);
    }
  }
}
