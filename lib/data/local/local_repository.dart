import 'package:hive_flutter/hive_flutter.dart';

class LocalRepository {
  static const String _appBoxName = 'app_cache';

  static List<T> getCachedData<T>({
    required String key,
    required T Function(Map<String, dynamic> json) fromJson,
  }) {
    final box = Hive.box(_appBoxName);
    final List<dynamic> rawData = box.get(key, defaultValue: []);
    
    return rawData.map((e) {
      final map = Map<String, dynamic>.from(e as Map);
      return fromJson(map);
    }).toList();
  }

  static Future<void> cacheData<T>({
    required String key,
    required List<T> items,
    required Map<String, dynamic> Function(T item) toJson,
  }) async {
    final box = Hive.box(_appBoxName);
    final data = items.map((i) => toJson(i)).toList();
    await box.put(key, data);
  }
}
