import 'package:youpass/core/utils/json_readers.dart';
import 'package:youpass/features/events/domain/entities/event_availability_entity.dart';
import 'package:youpass/features/events/data/models/event_model.dart';
import 'package:youpass/features/events/domain/entities/event_detail_entity.dart';
import 'package:youpass/features/events/domain/entities/event_purchase_meta_entity.dart';
import 'package:youpass/features/favorites/data/models/favorite_producer_model.dart';
import 'package:youpass/features/vip_venue/data/models/physical_venue_model.dart';
import 'package:youpass/features/waitlist/domain/entities/event_waitlist_status_entity.dart';

class EventDetailModel extends EventDetailEntity {
  const EventDetailModel({
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
    super.description,
    super.venueName,
    super.city,
    super.latitude,
    super.longitude,
    super.producer,
    super.purchase,
    super.waitlist,
    super.availability,
    super.scheduleDisplay,
    super.venueId,
    super.physicalVenue,
  });

  factory EventDetailModel.fromJson(Map<String, dynamic> json) {
    final base = EventModel.fromJson(json);
    final purchaseRaw = json['purchase'];
    final producerRaw = json['producer'];
    final physicalVenueRaw = json['physical_venue'] ?? json['physicalVenue'];

    return EventDetailModel(
      id: base.id,
      title: base.title,
      dateTimeLabel: base.dateTimeLabel,
      dateLabel: base.dateLabel,
      locationLabel: base.locationLabel,
      timeLabel: base.timeLabel,
      imageUrl: base.imageUrl,
      eventTypeSlug: base.eventTypeSlug,
      countryCode: base.countryCode,
      isFavorite: base.isFavorite,
      description: JsonReaders.nullableString(json, 'description') ??
          JsonReaders.nullableString(json, 'short_description'),
      venueName: JsonReaders.nullableString(json, 'venue_name') ??
          JsonReaders.nullableString(json, 'venueName') ??
          (physicalVenueRaw is Map<String, dynamic>
              ? PhysicalVenueModel.fromJson(physicalVenueRaw).name
              : null),
      city: JsonReaders.nullableString(json, 'city') ??
          (physicalVenueRaw is Map<String, dynamic>
              ? PhysicalVenueModel.fromJson(physicalVenueRaw).city
              : null),
      latitude: _readDouble(json, 'latitude'),
      longitude: _readDouble(json, 'longitude'),
      producer: producerRaw is Map<String, dynamic>
          ? FavoriteProducerModel.fromJson(producerRaw)
          : null,
      purchase: purchaseRaw is Map<String, dynamic>
          ? _parsePurchase(purchaseRaw)
          : null,
      waitlist: EventWaitlistStatusEntity.fromJson(
        json['waitlist'] as Map<String, dynamic>?,
      ),
      scheduleDisplay: JsonReaders.nullableString(json, 'schedule_display') ??
          JsonReaders.nullableString(json, 'scheduleDisplay'),
      venueId: JsonReaders.nullableString(json, 'venue_id') ??
          JsonReaders.nullableString(json, 'venueId'),
      physicalVenue: physicalVenueRaw is Map<String, dynamic>
          ? PhysicalVenueModel.fromJson(physicalVenueRaw)
          : null,
    );
  }

  EventDetailModel withAvailability(EventAvailabilityEntity availability) {
    return EventDetailModel(
      id: id,
      title: title,
      dateTimeLabel: dateTimeLabel,
      dateLabel: dateLabel,
      locationLabel: locationLabel,
      timeLabel: timeLabel,
      imageUrl: imageUrl,
      eventTypeSlug: eventTypeSlug,
      countryCode: countryCode,
      isFavorite: isFavorite,
      description: description,
      venueName: venueName,
      city: city,
      latitude: latitude,
      longitude: longitude,
      producer: producer,
      purchase: purchase,
      waitlist: waitlist,
      availability: availability,
      scheduleDisplay: scheduleDisplay,
      venueId: venueId,
      physicalVenue: physicalVenue,
    );
  }

  static double? _readDouble(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value is num) {
      return value.toDouble();
    }
    return null;
  }

  static EventPurchaseMetaEntity _parsePurchase(Map<String, dynamic> json) {
    final rate = json['service_fee_rate'] ?? json['serviceFeeRate'];
    return EventPurchaseMetaEntity(
      serviceFeeRate: rate is num ? rate.toDouble() : 0.05,
      currency: JsonReaders.string(json, 'currency', fallback: 'CLP'),
      paymentGateway: JsonReaders.string(json, 'payment_gateway',
          fallback: JsonReaders.string(json, 'paymentGateway', fallback: 'klap')),
      countryCode: JsonReaders.string(json, 'country_code',
          fallback: JsonReaders.string(json, 'countryCode', fallback: 'CL')),
      hasTicketOfferings: _readBool(json, 'has_ticket_offerings') ||
          _readBool(json, 'hasTicketOfferings'),
      hasVenueLayout: _readBool(json, 'has_venue_layout') ||
          _readBool(json, 'hasVenueLayout'),
      canPurchaseFromApi: _readOptionalBool(json, 'can_purchase') ??
          _readOptionalBool(json, 'canPurchase'),
    );
  }

  static bool? _readOptionalBool(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value is bool) {
      return value;
    }
    return null;
  }

  static bool _readBool(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value is bool) {
      return value;
    }
    return false;
  }
}
