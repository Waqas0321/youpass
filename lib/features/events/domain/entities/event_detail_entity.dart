import 'package:youpass/features/events/domain/entities/event_availability_entity.dart';
import 'package:youpass/features/events/domain/entities/event_entity.dart';
import 'package:youpass/features/events/domain/entities/event_purchase_meta_entity.dart';
import 'package:youpass/features/favorites/domain/entities/favorite_producer_entity.dart';
import 'package:youpass/features/waitlist/domain/entities/event_waitlist_status_entity.dart';

class EventDetailEntity extends EventEntity {
  const EventDetailEntity({
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
    super.distanceKm,
    super.travelTimeMinutes,
    super.waitlist,
    this.description,
    this.venueName,
    this.city,
    this.latitude,
    this.longitude,
    this.producer,
    this.purchase,
    this.availability,
    this.scheduleDisplay,
  });

  final String? description;
  final String? venueName;
  final String? city;
  final double? latitude;
  final double? longitude;
  final FavoriteProducerEntity? producer;
  final EventPurchaseMetaEntity? purchase;
  final EventAvailabilityEntity? availability;
  final String? scheduleDisplay;

  String get addressLabel {
    final venue = venueName?.trim();
    final cityName = city?.trim();
    if (venue != null && venue.isNotEmpty) {
      if (cityName != null &&
          cityName.isNotEmpty &&
          !venue.toLowerCase().contains(cityName.toLowerCase())) {
        return '$venue, $cityName';
      }
      return venue;
    }
    return locationLabel;
  }

  String get scheduleLabel {
    final compact = scheduleDisplay?.trim();
    if (compact != null && compact.isNotEmpty) {
      return compact;
    }

    final time = timeLabel?.trim();
    if (time != null && time.isNotEmpty) {
      return '$dateLabel · $time';
    }
    return dateTimeLabel;
  }

  bool get hasAddress => addressLabel.trim().isNotEmpty;

  bool get hasProducer => producer != null;

  bool get hasDescription =>
      description != null && description!.trim().isNotEmpty;

  @override
  EventDetailEntity copyWith({
    bool? isFavorite,
    double? distanceKm,
    int? travelTimeMinutes,
    bool clearDistance = false,
    EventWaitlistStatusEntity? waitlist,
    bool clearWaitlist = false,
    FavoriteProducerEntity? producer,
    bool clearProducer = false,
    EventAvailabilityEntity? availability,
    bool clearAvailability = false,
    String? scheduleDisplay,
  }) {
    return EventDetailEntity(
      id: id,
      title: title,
      dateTimeLabel: dateTimeLabel,
      dateLabel: dateLabel,
      locationLabel: locationLabel,
      timeLabel: timeLabel,
      imageUrl: imageUrl,
      eventTypeSlug: eventTypeSlug,
      countryCode: countryCode,
      isFavorite: isFavorite ?? this.isFavorite,
      distanceKm: clearDistance ? null : (distanceKm ?? this.distanceKm),
      travelTimeMinutes:
          clearDistance ? null : (travelTimeMinutes ?? this.travelTimeMinutes),
      waitlist: clearWaitlist ? null : (waitlist ?? this.waitlist),
      description: description,
      venueName: venueName,
      city: city,
      latitude: latitude,
      longitude: longitude,
      producer: clearProducer ? null : (producer ?? this.producer),
      purchase: purchase,
      availability: clearAvailability ? null : (availability ?? this.availability),
      scheduleDisplay: scheduleDisplay ?? this.scheduleDisplay,
    );
  }

  EventDetailEntity copyWithProducerFollowing(bool isFollowing) {
    final currentProducer = producer;
    if (currentProducer == null) {
      return this;
    }

    return copyWith(
      producer: FavoriteProducerEntity(
        id: currentProducer.id,
        name: currentProducer.name,
        logoUrl: currentProducer.logoUrl,
        description: currentProducer.description,
        coverageLabel: currentProducer.coverageLabel,
        followerCount: currentProducer.followerCount,
        isFollowing: isFollowing,
      ),
    );
  }
}
