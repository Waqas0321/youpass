import 'package:youpass/core/utils/json_readers.dart';
import 'package:youpass/features/events/domain/entities/event_entity.dart';
import 'package:youpass/features/home/domain/entities/banner_tap_action_entity.dart';
import 'package:youpass/features/waitlist/domain/entities/event_waitlist_status_entity.dart';

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
    super.subtitle,
    super.bannerId,
    super.aspectRatio,
    super.tapAction,
    super.distanceKm,
    super.travelTimeMinutes,
    super.startsAt,
    super.waitlist,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    final location = JsonReaders.string(
      json,
      'location_display',
      fallback: _buildLocationFallback(json),
    );
    final tapActionRaw = json['tap_action'] ?? json['tapAction'];

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
      subtitle: JsonReaders.nullableString(json, 'subtitle'),
      bannerId: JsonReaders.nullableString(json, 'banner_id') ??
          JsonReaders.nullableString(json, 'bannerId'),
      aspectRatio: JsonReaders.nullableString(json, 'aspect_ratio') ??
          JsonReaders.nullableString(json, 'aspectRatio'),
      tapAction: tapActionRaw == null ? null : BannerTapActionEntity.fromJson(tapActionRaw),
      distanceKm: _readDistanceKm(json),
      travelTimeMinutes: _readTravelTimeMinutes(json),
      startsAt: JsonReaders.dateTime(json, 'starts_at'),
      waitlist: EventWaitlistStatusEntity.fromJson(
        json['waitlist'] as Map<String, dynamic>?,
      ),
    );
  }

  static double? _readDistanceKm(Map<String, dynamic> json) {
    final raw = json['distance_km'] ?? json['distanceKm'];
    if (raw is num) {
      return raw.toDouble();
    }
    return null;
  }

  static int? _readTravelTimeMinutes(Map<String, dynamic> json) {
    final raw = json['travel_time_minutes'] ?? json['travelTimeMinutes'];
    if (raw is int) {
      return raw;
    }
    if (raw is num) {
      return raw.toInt();
    }
    return null;
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
