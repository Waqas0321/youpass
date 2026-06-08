import 'package:youpass/features/events/domain/entities/event_entity.dart';
import 'package:youpass/features/events/domain/entities/event_purchase_meta_entity.dart';

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
    this.description,
    this.venueName,
    this.city,
    this.purchase,
  });

  final String? description;
  final String? venueName;
  final String? city;
  final EventPurchaseMetaEntity? purchase;

  @override
  EventDetailEntity copyWith({bool? isFavorite}) {
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
      description: description,
      venueName: venueName,
      city: city,
      purchase: purchase,
    );
  }
}
