import 'package:youpass/features/invitations/domain/repositories/invitations_repository.dart';

class RejectInvitationUseCase {
  RejectInvitationUseCase(this.repository);

  final InvitationsRepository repository;

  Future<void> call(String invitationId) {
    return repository.rejectInvitation(invitationId);
  }
}
