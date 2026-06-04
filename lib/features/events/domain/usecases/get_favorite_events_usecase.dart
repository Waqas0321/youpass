import 'package:youpass/features/events/domain/entities/event_entity.dart';
import 'package:youpass/features/events/domain/repositories/events_repository.dart';

class GetFavoriteEventsUseCase {
  GetFavoriteEventsUseCase(this.repository);

  final EventsRepository repository;

  Future<List<EventEntity>> call() {
    return repository.fetchFavoriteEvents();
  }
}
