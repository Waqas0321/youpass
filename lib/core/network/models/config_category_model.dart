import 'package:youpass/core/utils/json_readers.dart';

class ConfigCategoryModel {
  const ConfigCategoryModel({
    required this.id,
    required this.label,
    this.countryCode,
    this.eventTypeSlug,
    this.flagEmoji,
  });

  final String id;
  final String label;
  final String? countryCode;
  final String? eventTypeSlug;
  final String? flagEmoji;

  Map<String, dynamic> toJson() => {
        'id': id,
        'label': label,
        if (countryCode != null) 'country_code': countryCode,
        if (eventTypeSlug != null) 'event_type_slug': eventTypeSlug,
        if (flagEmoji != null) 'flag_emoji': flagEmoji,
      };

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
      flagEmoji: JsonReaders.nullableString(json, 'flag_emoji') ??
          JsonReaders.nullableString(json, 'flagEmoji'),
    );
  }

  static List<ConfigCategoryModel> listFromRawData(Object? data) {
    if (data is Map<String, dynamic>) {
      return listFromRawData(data['categories'] ?? data['event_categories']);
    }

    if (data is! List) {
      return const [];
    }

    return data
        .whereType<Map<String, dynamic>>()
        .map(ConfigCategoryModel.fromJson)
        .where((category) => category.id.isNotEmpty && category.label.isNotEmpty)
        .toList();
  }

  static List<ConfigCategoryModel> fromEventCategoryPayload(Object? data) {
    if (data is! Map<String, dynamic>) {
      return const [];
    }

    final raw = data['event_categories'];
    if (raw is! List) {
      return const [];
    }

    return raw
        .whereType<Map<String, dynamic>>()
        .map((item) {
          final slug = JsonReaders.string(item, 'slug', fallback: JsonReaders.string(item, 'id'));
          return ConfigCategoryModel(
            id: slug,
            label: JsonReaders.string(item, 'label', fallback: JsonReaders.string(item, 'name')),
            eventTypeSlug: slug,
          );
        })
        .where((category) => category.id.isNotEmpty && category.label.isNotEmpty)
        .toList();
  }
}
