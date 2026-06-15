import 'package:youpass/features/invitations/domain/entities/invitations_feed_entity.dart';
import 'package:youpass/features/invitations/domain/repositories/invitations_repository.dart';

class FetchInvitationsFeedUseCase {
  FetchInvitationsFeedUseCase(this.repository);

  final InvitationsRepository repository;

  Future<InvitationsFeedEntity> call() {
    return repository.fetchInvitationsFeed();
  }
}
