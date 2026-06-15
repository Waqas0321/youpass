import 'package:equatable/equatable.dart';

class ProducerCalendarEventEntity extends Equatable {
  const ProducerCalendarEventEntity({
    required this.id,
    required this.title,
    required this.dateLabel,
    required this.locationLabel,
    this.imageUrl,
    this.eventTypeSlug,
    this.eventTypeName,
    this.venueName,
    this.minPrice,
    this.currencyCode,
    this.ticketCta = ProducerTicketCta.buy,
    this.followersPresaleActive = false,
    this.followersPresaleLabel,
    this.isFavorite = false,
    this.startsAt,
  });

  final String id;
  final String title;
  final String dateLabel;
  final String locationLabel;
  final String? imageUrl;
  final String? eventTypeSlug;
  final String? eventTypeName;
  final String? venueName;
  final double? minPrice;
  final String? currencyCode;
  final ProducerTicketCta ticketCta;
  final bool followersPresaleActive;
  final String? followersPresaleLabel;
  final bool isFavorite;
  final DateTime? startsAt;

  @override
  List<Object?> get props => [
        id,
        title,
        dateLabel,
        locationLabel,
        imageUrl,
        eventTypeSlug,
        eventTypeName,
        venueName,
        minPrice,
        currencyCode,
        ticketCta,
        followersPresaleActive,
        followersPresaleLabel,
        isFavorite,
        startsAt,
      ];
}

enum ProducerTicketCta {
  buy,
  presale,
  prepay,
}
