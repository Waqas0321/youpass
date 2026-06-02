import 'package:youpass/features/invitations/domain/entities/invitation_entity.dart';
import 'package:youpass/features/invitations/domain/repositories/invitations_repository.dart';

class ConfirmInvitationUseCase {
  ConfirmInvitationUseCase(this.repository);

  final InvitationsRepository repository;

  Future<InvitationEntity> call(String invitationId) {
    return repository.confirmInvitation(invitationId);
  }
}
