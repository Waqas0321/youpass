import 'package:youpass/features/invitations/domain/entities/invitation_ticket_entity.dart';

class EventTicketRouteArgs {
  const EventTicketRouteArgs({
    required this.ticket,
    this.showQrCode = true,
  });

  final InvitationTicketEntity ticket;
  final bool showQrCode;
}
