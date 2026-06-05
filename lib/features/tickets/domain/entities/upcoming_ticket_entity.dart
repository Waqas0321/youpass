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
    this.ticketOrderId,
    this.assignableCount,
    this.origin,
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
  final String? ticketOrderId;
  final int? assignableCount;
  final String? origin;

  bool get usesNetworkImage {
    final value = imageAssetPath.trim().toLowerCase();
    return value.startsWith('http://') || value.startsWith('https://');
  }

  bool get hasTicketOrderId {
    final value = ticketOrderId?.trim();
    return value != null && value.isNotEmpty;
  }

  bool get showsAssignAction {
    if (canAssignTickets) {
      return true;
    }
    if (hasTicketOrderId) {
      return true;
    }
    if ((assignableCount ?? 0) > 0) {
      return true;
    }
    return origin == 'purchase';
  }

  String? get assignmentOrderId {
    if (!hasTicketOrderId) {
      return null;
    }
    return ticketOrderId!.trim();
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
        ticketOrderId,
        assignableCount,
        origin,
      ];
}
