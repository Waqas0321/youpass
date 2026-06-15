import 'package:equatable/equatable.dart';
import 'package:youpass/features/home/domain/entities/banner_tap_action_entity.dart';
import 'package:youpass/features/waitlist/domain/entities/event_waitlist_status_entity.dart';

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
    this.subtitle,
    this.bannerId,
    this.aspectRatio,
    this.tapAction,
    this.distanceKm,
    this.travelTimeMinutes,
    this.startsAt,
    this.waitlist,
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
  final String? subtitle;
  final String? bannerId;
  final String? aspectRatio;
  final BannerTapActionEntity? tapAction;
  final double? distanceKm;
  final int? travelTimeMinutes;
  final DateTime? startsAt;
  final EventWaitlistStatusEntity? waitlist;

  EventEntity copyWith({
    bool? isFavorite,
    double? distanceKm,
    int? travelTimeMinutes,
    bool clearDistance = false,
    EventWaitlistStatusEntity? waitlist,
    bool clearWaitlist = false,
  }) {
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
      subtitle: subtitle,
      bannerId: bannerId,
      aspectRatio: aspectRatio,
      tapAction: tapAction,
      distanceKm: clearDistance ? null : (distanceKm ?? this.distanceKm),
      travelTimeMinutes:
          clearDistance ? null : (travelTimeMinutes ?? this.travelTimeMinutes),
      startsAt: startsAt,
      waitlist: clearWaitlist ? null : (waitlist ?? this.waitlist),
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
        subtitle,
        bannerId,
        aspectRatio,
        tapAction,
        distanceKm,
        travelTimeMinutes,
        startsAt,
        waitlist,
      ];
}
