import 'package:youpass/features/ticket_assignment/domain/entities/invitation_claim_entity.dart';
import 'package:youpass/features/ticket_assignment/domain/repositories/ticket_assignment_repository.dart';

class FetchInvitationClaimUseCase {
  FetchInvitationClaimUseCase(this.repository);

  final TicketAssignmentRepository repository;

  Future<InvitationClaimEntity> call(String token) {
    return repository.fetchInvitationClaim(token);
  }
}
