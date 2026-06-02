import 'package:youpass/features/invitations/domain/entities/invitation_entity.dart';
import 'package:youpass/features/invitations/domain/repositories/invitations_repository.dart';

class RejectInvitationUseCase {
  RejectInvitationUseCase(this.repository);

  final InvitationsRepository repository;

  Future<InvitationEntity> call(String invitationId) {
    return repository.rejectInvitation(invitationId);
  }
}
