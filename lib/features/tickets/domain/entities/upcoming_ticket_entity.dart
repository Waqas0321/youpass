import 'package:equatable/equatable.dart';
import 'package:youpass/features/tickets/domain/entities/ticket_tier.dart';

class UpcomingTicketEntity extends Equatable {
  const UpcomingTicketEntity({
    required this.id,
    required this.title,
    required this.dateLabel,
    required this.locationLabel,
    required this.ticketTypeLabel,
    required this.imageAssetPath,
    this.tier = TicketTier.general,
    this.isActive = true,
  });

  final String id;
  final String title;
  final String dateLabel;
  final String locationLabel;
  final String ticketTypeLabel;
  final String imageAssetPath;
  final TicketTier tier;
  final bool isActive;

  @override
  List<Object?> get props => [
        id,
        title,
        dateLabel,
        locationLabel,
        ticketTypeLabel,
        imageAssetPath,
        tier,
        isActive,
      ];
}
