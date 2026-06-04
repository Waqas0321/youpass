import 'package:equatable/equatable.dart';

class EventEntity extends Equatable {
  const EventEntity({
    required this.id,
    required this.title,
    required this.dateTimeLabel,
    required this.dateLabel,
    required this.locationLabel,
    this.timeLabel,
    this.imageUrl,
    this.eventTypeSlug,
    this.countryCode,
    this.isFavorite = false,
  });

  final String id;
  final String title;
  final String dateTimeLabel;
  final String dateLabel;
  final String locationLabel;
  final String? timeLabel;
  final String? imageUrl;
  final String? eventTypeSlug;
  final String? countryCode;
  final bool isFavorite;

  EventEntity copyWith({bool? isFavorite}) {
    return EventEntity(
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
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        dateTimeLabel,
        dateLabel,
        locationLabel,
        timeLabel,
        imageUrl,
        eventTypeSlug,
        countryCode,
        isFavorite,
      ];
}
