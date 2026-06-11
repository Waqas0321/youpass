import 'package:youpass/core/utils/json_readers.dart';
import 'package:youpass/features/events/domain/entities/event_entity.dart';

class EventModel extends EventEntity {
  const EventModel({
    required super.id,
    required super.title,
    required super.dateTimeLabel,
    required super.dateLabel,
    required super.locationLabel,
    super.timeLabel,
    super.imageUrl,
    super.eventTypeSlug,
    super.countryCode,
    super.isFavorite,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    final location = JsonReaders.string(
      json,
      'location_display',
      fallback: _buildLocationFallback(json),
    );

    return EventModel(
      id: JsonReaders.readId(json),
      title: JsonReaders.string(json, 'title'),
      dateTimeLabel: JsonReaders.string(
        json,
        'date_time_display',
        fallback: JsonReaders.string(json, 'starts_at_display'),
      ),
      dateLabel: JsonReaders.string(
        json,
        'date_display',
        fallback: JsonReaders.string(
          json,
          'starts_at_display',
          fallback: JsonReaders.string(json, 'date_time_display'),
        ),
      ),
      locationLabel: location,
      timeLabel: JsonReaders.nullableString(json, 'starts_at_time'),
      imageUrl: JsonReaders.nullableString(json, 'image_url'),
      eventTypeSlug: _readEventTypeSlug(json),
      countryCode: JsonReaders.nullableString(json, 'country_code'),
      isFavorite: JsonReaders.boolean(json, 'is_favorite'),
    );
  }

  static String? _readEventTypeSlug(Map<String, dynamic> json) {
    final eventType = json['event_type'];
    if (eventType is! Map<String, dynamic>) {
      return null;
    }

    final slug = eventType['slug']?.toString();
    return slug == null || slug.isEmpty ? null : slug;
  }

  static String _buildLocationFallback(Map<String, dynamic> json) {
    final venue = JsonReaders.string(json, 'venue_name');
    final city = JsonReaders.string(json, 'city');
    if (venue.isEmpty) {
      return city;
    }
    if (city.isEmpty) {
      return venue;
    }
    return '$venue, $city';
  }

  static List<EventModel> listFromJson(Object? value) {
    if (value is! List) {
      return const [];
    }

    return value
        .whereType<Map<String, dynamic>>()
        .map(EventModel.fromJson)
        .toList();
  }
}
