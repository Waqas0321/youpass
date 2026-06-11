import 'package:youpass/core/utils/json_readers.dart';

class ConfigCategoryModel {
  const ConfigCategoryModel({
    required this.id,
    required this.label,
    this.countryCode,
    this.eventTypeSlug,
  });

  final String id;
  final String label;
  final String? countryCode;
  final String? eventTypeSlug;

  factory ConfigCategoryModel.fromJson(Map<String, dynamic> json) {
    final id = JsonReaders.string(json, 'id');
    var countryCode = JsonReaders.nullableString(json, 'country_code') ??
        JsonReaders.nullableString(json, 'countryCode');

    if ((countryCode == null || countryCode.isEmpty) && id.startsWith('country:')) {
      countryCode = id.substring('country:'.length);
    }

    return ConfigCategoryModel(
      id: id,
      label: JsonReaders.string(json, 'label'),
      countryCode: countryCode,
      eventTypeSlug: JsonReaders.nullableString(json, 'event_type_slug') ??
          JsonReaders.nullableString(json, 'eventTypeSlug'),
    );
  }

  static List<ConfigCategoryModel> listFromRawData(Object? data) {
    if (data is! List) {
      return const [];
    }

    return data
        .whereType<Map<String, dynamic>>()
        .map(ConfigCategoryModel.fromJson)
        .where((category) => category.id.isNotEmpty && category.label.isNotEmpty)
        .toList();
  }
}
