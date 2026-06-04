import 'package:equatable/equatable.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_qr_status.dart';
import 'package:youpass/features/tickets/domain/entities/ticket_tier.dart';

class UpcomingTicketEntity extends Equatable {
  const UpcomingTicketEntity({
    required this.id,
    required this.title,
    required this.dateLabel,
    required this.locationLabel,
    required this.ticketTypeLabel,
    required this.imageAssetPath,
    this.eventId,
    this.tier = TicketTier.general,
    this.isActive = true,
    this.canViewQr = false,
    this.canAssignTickets = false,
    this.qrStatus,
  });

  final String id;
  final String? eventId;
  final String title;
  final String dateLabel;
  final String locationLabel;
  final String ticketTypeLabel;
  final String imageAssetPath;
  final TicketTier tier;
  final bool isActive;
  final bool canViewQr;
  final bool canAssignTickets;
  final InvitationQrStatus? qrStatus;

  bool get usesNetworkImage {
    final value = imageAssetPath.trim().toLowerCase();
    return value.startsWith('http://') || value.startsWith('https://');
  }

  @override
  List<Object?> get props => [
        id,
        eventId,
        title,
        dateLabel,
        locationLabel,
        ticketTypeLabel,
        imageAssetPath,
        tier,
        isActive,
        canViewQr,
        canAssignTickets,
        qrStatus,
      ];
}
