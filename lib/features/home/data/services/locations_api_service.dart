import 'package:youpass/core/network/api_endpoints.dart';
import 'package:youpass/core/network/base_api_service.dart';
import 'package:youpass/core/utils/json_readers.dart';
import 'package:youpass/features/home/domain/entities/location_suggestion_entity.dart';

class LocationsApiService extends BaseApiService {
  LocationsApiService(super.apiClient);

  Future<List<LocationSuggestionEntity>> searchLocations({
    required String query,
    String? countryCode,
    int limit = 8,
  }) async {
    final uri = Uri.parse(ApiEndpoints.locationsSearch).replace(
      queryParameters: {
        'q': query.trim(),
        'limit': '$limit',
        if (countryCode != null && countryCode.trim().isNotEmpty)
          'country_code': countryCode.trim().toUpperCase(),
      },
    );

    final data = await getData(uri.toString());
    final results = data['results'];
    if (results is! List) {
      return const [];
    }

    return results
        .whereType<Map<String, dynamic>>()
        .map(_fromJson)
        .where((item) => item.label.trim().isNotEmpty)
        .toList();
  }

  LocationSuggestionEntity _fromJson(Map<String, dynamic> json) {
    return LocationSuggestionEntity(
      id: JsonReaders.string(json, 'id'),
      label: JsonReaders.string(json, 'label'),
      city: JsonReaders.string(
        json,
        'city',
        fallback: JsonReaders.string(json, 'label'),
      ),
      latitude: _readDouble(json, 'latitude'),
      longitude: _readDouble(json, 'longitude'),
      subtitle: JsonReaders.nullableString(json, 'subtitle'),
      country: JsonReaders.nullableString(json, 'country'),
      countryCode: JsonReaders.nullableString(json, 'country_code') ??
          JsonReaders.nullableString(json, 'countryCode'),
    );
  }

  double _readDouble(Map<String, dynamic> json, String key) {
    final raw = json[key];
    if (raw is num) {
      return raw.toDouble();
    }
    return double.tryParse(raw?.toString() ?? '') ?? 0;
  }
}
