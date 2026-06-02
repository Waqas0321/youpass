import 'package:youpass/features/invitations/domain/entities/invitation_ticket_entity.dart';
import 'package:youpass/features/invitations/domain/repositories/invitations_repository.dart';

class FetchInvitationTicketUseCase {
  FetchInvitationTicketUseCase(this.repository);

  final InvitationsRepository repository;

  Future<InvitationTicketEntity> call(String invitationId) {
    return repository.fetchTicket(invitationId);
  }
}
