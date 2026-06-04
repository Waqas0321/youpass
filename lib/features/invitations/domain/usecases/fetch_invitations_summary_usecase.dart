import 'package:youpass/features/invitations/domain/entities/invitations_summary_entity.dart';
import 'package:youpass/features/invitations/domain/repositories/invitations_repository.dart';

class FetchInvitationsSummaryUseCase {
  FetchInvitationsSummaryUseCase(this.repository);

  final InvitationsRepository repository;

  Future<InvitationsSummaryEntity> call() {
    return repository.fetchSummary();
  }
}
