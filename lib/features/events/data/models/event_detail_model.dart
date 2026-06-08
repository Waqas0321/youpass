import 'package:youpass/core/utils/json_readers.dart';
import 'package:youpass/features/events/data/models/event_model.dart';
import 'package:youpass/features/events/domain/entities/event_detail_entity.dart';
import 'package:youpass/features/events/domain/entities/event_purchase_meta_entity.dart';

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
    super.purchase,
  });

  factory EventDetailModel.fromJson(Map<String, dynamic> json) {
    final base = EventModel.fromJson(json);
    final purchaseRaw = json['purchase'];

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
          JsonReaders.nullableString(json, 'venueName'),
      city: JsonReaders.nullableString(json, 'city'),
      purchase: purchaseRaw is Map<String, dynamic>
          ? _parsePurchase(purchaseRaw)
          : null,
    );
  }

  static EventPurchaseMetaEntity _parsePurchase(Map<String, dynamic> json) {
    final rate = json['service_fee_rate'] ?? json['serviceFeeRate'];
    return EventPurchaseMetaEntity(
      serviceFeeRate: rate is num ? rate.toDouble() : 0.05,
      currency: JsonReaders.string(json, 'currency', fallback: 'CLP'),
      hasTicketOfferings: _readBool(json, 'has_ticket_offerings') ||
          _readBool(json, 'hasTicketOfferings'),
      hasVenueLayout: _readBool(json, 'has_venue_layout') ||
          _readBool(json, 'hasVenueLayout'),
    );
  }

  static bool _readBool(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value is bool) {
      return value;
    }
    return false;
  }
}
