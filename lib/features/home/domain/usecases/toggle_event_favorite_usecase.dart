import 'package:youpass/features/home/domain/repositories/home_repository.dart';

class ToggleEventFavoriteUseCase {
  ToggleEventFavoriteUseCase(this.repository);

  final HomeRepository repository;

  Future<void> call({
    required String eventId,
    required bool isFavorite,
  }) {
    return repository.toggleEventFavorite(
      eventId: eventId,
      isFavorite: isFavorite,
    );
  }
}
