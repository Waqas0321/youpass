import 'package:youpass/features/invitations/domain/entities/invitation_entity.dart';
import 'package:youpass/features/invitations/domain/repositories/invitations_repository.dart';

class FetchInvitationsUseCase {
  FetchInvitationsUseCase(this.repository);

  final InvitationsRepository repository;

  Future<List<InvitationEntity>> call() {
    return repository.fetchInvitations();
  }
}
