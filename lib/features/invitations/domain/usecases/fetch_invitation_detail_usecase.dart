import 'package:youpass/features/invitations/domain/entities/invitation_entity.dart';
import 'package:youpass/features/invitations/domain/repositories/invitations_repository.dart';

class FetchInvitationDetailUseCase {
  FetchInvitationDetailUseCase(this.repository);

  final InvitationsRepository repository;

  Future<InvitationEntity> call(String invitationId) {
    return repository.fetchInvitationDetail(invitationId);
  }
}
