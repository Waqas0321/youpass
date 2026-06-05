import 'package:youpass/features/invitations/domain/entities/invitation_ticket_entity.dart';
import 'package:youpass/features/tickets/domain/repositories/tickets_repository.dart';

class FetchTicketQrUseCase {
  FetchTicketQrUseCase(this.repository);

  final TicketsRepository repository;

  Future<InvitationTicketEntity> call(String ticketId) {
    return repository.fetchTicketQr(ticketId);
  }
}
