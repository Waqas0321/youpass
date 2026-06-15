import 'package:youpass/features/invitations/domain/repositories/invitations_repository.dart';

class CancelInvitationUseCase {
  CancelInvitationUseCase(this.repository);

  final InvitationsRepository repository;

  Future<void> call(String invitationId) {
    return repository.cancelInvitation(invitationId);
  }
}
