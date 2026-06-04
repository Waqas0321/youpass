import 'package:youpass/features/events/domain/repositories/events_repository.dart';

class ToggleEventFavoriteUseCase {
  ToggleEventFavoriteUseCase(this.repository);

  final EventsRepository repository;

  Future<void> call({
    required String eventId,
    required bool isFavorite,
  }) {
    if (isFavorite) {
      return repository.removeEventFavorite(eventId);
    }

    return repository.addEventFavorite(eventId);
  }
}
