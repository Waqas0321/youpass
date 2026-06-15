import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:youpass/core/network/config_api_service.dart';
import 'package:youpass/core/network/models/config_category_model.dart';
import 'package:youpass/core/utils/app_logger.dart';

class EventCategoriesCache {
  EventCategoriesCache({
    required ConfigApiService configApiService,
    required SharedPreferences preferences,
  })  : _configApiService = configApiService,
        _preferences = preferences;

  static const String storageKey = 'event_categories_cache_v1';

  final ConfigApiService _configApiService;
  final SharedPreferences _preferences;

  Future<void> hydrate() async {
    try {
      final remote = await _configApiService.fetchEventCategories();
      if (remote.isEmpty) {
        return;
      }

      final encoded = jsonEncode(
        remote.map((category) => category.toJson()).toList(),
      );
      await _preferences.setString(storageKey, encoded);
      AppLogger.info('Cached ${remote.length} event categories');
    } catch (error, stackTrace) {
      AppLogger.error(
        'Failed to cache event categories',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  List<ConfigCategoryModel> readCached() {
    final raw = _preferences.getString(storageKey);
    if (raw == null || raw.isEmpty) {
      return const [];
    }

    try {
      final decoded = jsonDecode(raw);
      return ConfigCategoryModel.listFromRawData(decoded);
    } catch (_) {
      return const [];
    }
  }
}
