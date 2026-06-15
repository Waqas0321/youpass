import 'package:youpass/features/invitations/domain/entities/confirm_invitation_params.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_entity.dart';
import 'package:youpass/features/invitations/domain/repositories/invitations_repository.dart';

class ConfirmInvitationUseCase {
  ConfirmInvitationUseCase(this.repository);

  final InvitationsRepository repository;

  Future<InvitationEntity> call(
    String invitationId, {
    ConfirmInvitationParams params = const ConfirmInvitationParams(),
  }) {
    return repository.confirmInvitation(invitationId, params: params);
  }
}
