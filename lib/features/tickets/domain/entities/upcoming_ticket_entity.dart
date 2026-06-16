import 'package:equatable/equatable.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_qr_status.dart';
import 'package:youpass/features/tickets/domain/entities/ticket_display_status.dart';
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
    this.displayStatus = TicketDisplayStatus.active,
    this.canViewQr = false,
    this.canAssignTickets = false,
    this.canCancel = false,
    this.qrStatus,
    this.ticketOrderId,
    this.assignableCount,
    this.origin,
    this.eventStartsAt,
  });

  final String id;
  final String? eventId;
  final String title;
  final String dateLabel;
  final String locationLabel;
  final String ticketTypeLabel;
  final String imageAssetPath;
  final TicketTier tier;
  final TicketDisplayStatus displayStatus;
  final bool canViewQr;
  final bool canAssignTickets;
  final bool canCancel;
  final InvitationQrStatus? qrStatus;
  final String? ticketOrderId;
  final int? assignableCount;
  final String? origin;
  final DateTime? eventStartsAt;

  bool get isActive => displayStatus == TicketDisplayStatus.active;

  bool get usesNetworkImage {
    final value = imageAssetPath.trim().toLowerCase();
    return value.startsWith('http://') || value.startsWith('https://');
  }

  bool get hasTicketOrderId {
    final value = ticketOrderId?.trim();
    return value != null && value.isNotEmpty;
  }

  bool get showsAssignAction =>
      canAssignTickets || (assignableCount ?? 0) > 0;

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
        displayStatus,
        canViewQr,
        canAssignTickets,
        canCancel,
        qrStatus,
        ticketOrderId,
        assignableCount,
        origin,
        eventStartsAt,
      ];
}
