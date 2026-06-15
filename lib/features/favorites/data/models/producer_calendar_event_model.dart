import 'package:youpass/core/utils/json_readers.dart';
import 'package:youpass/features/favorites/data/models/favorite_producer_model.dart';
import 'package:youpass/features/favorites/domain/entities/producer_calendar_event_entity.dart';

class ProducerCalendarEventModel extends ProducerCalendarEventEntity {
  const ProducerCalendarEventModel({
    required super.id,
    required super.title,
    required super.dateLabel,
    required super.locationLabel,
    super.imageUrl,
    super.eventTypeSlug,
    super.eventTypeName,
    super.venueName,
    super.minPrice,
    super.currencyCode,
    super.ticketCta,
    super.followersPresaleActive,
    super.followersPresaleLabel,
    super.isFavorite,
    super.startsAt,
  });

  factory ProducerCalendarEventModel.fromJson(Map<String, dynamic> json) {
    final eventType = json['event_type'];
    String? slug;
    String? name;
    if (eventType is Map<String, dynamic>) {
      slug = JsonReaders.nullableString(eventType, 'slug');
      name = JsonReaders.nullableString(eventType, 'name');
    }

    final ctaRaw = JsonReaders.string(json, 'ticket_cta', fallback: 'buy');
    final ticketCta = switch (ctaRaw) {
      'presale' => ProducerTicketCta.presale,
      'prepay' => ProducerTicketCta.prepay,
      _ => ProducerTicketCta.buy,
    };

    final startsAtRaw = json['starts_at'];
    DateTime? startsAt;
    if (startsAtRaw is String && startsAtRaw.isNotEmpty) {
      startsAt = DateTime.tryParse(startsAtRaw);
    }

    final minPriceRaw = json['min_price'];
    double? minPrice;
    if (minPriceRaw is num) {
      minPrice = minPriceRaw.toDouble();
    }

    return ProducerCalendarEventModel(
      id: JsonReaders.readId(json),
      title: JsonReaders.string(json, 'title'),
      dateLabel: JsonReaders.string(
        json,
        'date_display',
        fallback: JsonReaders.string(json, 'starts_at_display'),
      ),
      locationLabel: JsonReaders.string(
        json,
        'location_display',
        fallback: _buildLocationFallback(json),
      ),
      imageUrl: JsonReaders.nullableString(json, 'image_url'),
      eventTypeSlug: slug,
      eventTypeName: name,
      venueName: JsonReaders.nullableString(json, 'venue_name'),
      minPrice: minPrice,
      currencyCode: JsonReaders.nullableString(json, 'currency_code'),
      ticketCta: ticketCta,
      followersPresaleActive:
          JsonReaders.boolean(json, 'followers_presale_active'),
      followersPresaleLabel:
          JsonReaders.nullableString(json, 'followers_presale_label'),
      isFavorite: JsonReaders.boolean(json, 'is_favorite'),
      startsAt: startsAt,
    );
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

  static List<ProducerCalendarEventModel> listFromJson(Object? value) {
    if (value is! List) {
      return const [];
    }

    return value
        .whereType<Map<String, dynamic>>()
        .map(ProducerCalendarEventModel.fromJson)
        .toList();
  }
}
