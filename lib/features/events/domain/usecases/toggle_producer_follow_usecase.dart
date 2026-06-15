import 'package:youpass/features/favorites/domain/repositories/favorites_repository.dart';

class ToggleProducerFollowUseCase {
  const ToggleProducerFollowUseCase(this.repository);

  final FavoritesRepository repository;

  Future<void> call({
    required String producerId,
    required bool isFollowing,
  }) {
    if (isFollowing) {
      return repository.unfollowProducer(producerId);
    }
    return repository.followProducer(producerId);
  }
}
