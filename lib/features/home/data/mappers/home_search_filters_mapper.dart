import 'package:youpass/core/utils/json_readers.dart';
import 'package:youpass/features/home/domain/entities/home_search_filters_entity.dart';

class HomeSearchFiltersMapper {
  HomeSearchFiltersMapper._();

  static HomeSearchFiltersConfigEntity fromJson(Object? value) {
    if (value is! Map<String, dynamic>) {
      return HomeSearchFiltersConfigEntity.defaults;
    }

    final filters = value['filters'];
    final filtersMap = filters is Map<String, dynamic> ? filters : value;

    return HomeSearchFiltersConfigEntity(
      datePresets: _parseOptions(filtersMap['date_presets'] ?? filtersMap['datePresets']),
      venueTypes: _parseOptions(filtersMap['venue_types'] ?? filtersMap['venueTypes']),
      cities: _parseCities(filtersMap['cities']),
      priceRange: _parsePriceRange(filtersMap['price_range'] ?? filtersMap['priceRange']),
      debounceMs: JsonReaders.integer(value, 'debounce_ms',
          fallback: JsonReaders.integer(value, 'debounceMs', fallback: 300)),
      emptyMessage: JsonReaders.string(
        value,
        'empty_message',
        fallback: JsonReaders.string(
          value,
          'emptyMessage',
          fallback: "We couldn't find any events with that term.",
        ),
      ),
      historyLimit: JsonReaders.integer(value, 'history_limit',
          fallback: JsonReaders.integer(value, 'historyLimit', fallback: 10)),
      filtersEnabled: JsonReaders.boolean(value, 'filters_enabled',
          fallback: JsonReaders.boolean(value, 'filtersEnabled', fallback: true)),
      searchEndpoint: JsonReaders.string(value, 'search_endpoint',
          fallback: JsonReaders.string(value, 'searchEndpoint', fallback: '/events')),
      searchParam: JsonReaders.string(value, 'search_param',
          fallback: JsonReaders.string(value, 'searchParam', fallback: 'q')),
    );
  }

  static List<HomeFilterOptionEntity> _parseOptions(Object? value) {
    if (value is! List) {
      return const [];
    }

    return value
        .whereType<Map<String, dynamic>>()
        .map(
          (item) => HomeFilterOptionEntity(
            id: JsonReaders.string(item, 'id'),
            label: JsonReaders.string(item, 'label'),
          ),
        )
        .where((item) => item.id.isNotEmpty)
        .toList();
  }

  static List<HomeCityFilterEntity> _parseCities(Object? value) {
    if (value is! List) {
      return const [];
    }

    return value
        .whereType<Map<String, dynamic>>()
        .map((item) {
          final zonesRaw = item['zones'];
          final zones = zonesRaw is List
              ? zonesRaw.whereType<String>().where((zone) => zone.isNotEmpty).toList()
              : const <String>[];

          return HomeCityFilterEntity(
            id: JsonReaders.string(item, 'id'),
            label: JsonReaders.string(item, 'label'),
            zones: zones,
          );
        })
        .where((item) => item.id.isNotEmpty)
        .toList();
  }

  static HomePriceRangeEntity _parsePriceRange(Object? value) {
    if (value is! Map<String, dynamic>) {
      return HomeSearchFiltersConfigEntity.defaults.priceRange;
    }

    return HomePriceRangeEntity(
      min: _readDouble(value, 'min'),
      max: _readDouble(value, 'max', fallback: 500000),
      currency: JsonReaders.string(value, 'currency', fallback: 'CLP'),
      freeToggleEnabled: JsonReaders.boolean(
        value,
        'free_toggle_enabled',
        fallback: JsonReaders.boolean(value, 'freeToggleEnabled', fallback: true),
      ),
    );
  }

  static double _readDouble(Map<String, dynamic> json, String key, {double fallback = 0}) {
    final raw = json[key];
    if (raw is num) {
      return raw.toDouble();
    }
    return fallback;
  }
}
