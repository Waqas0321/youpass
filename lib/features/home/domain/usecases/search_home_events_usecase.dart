import 'package:youpass/features/events/domain/entities/home_events_query.dart';
import 'package:youpass/features/events/domain/repositories/events_repository.dart';

class SearchHomeEventsUseCase {
  SearchHomeEventsUseCase(this.repository);

  final EventsRepository repository;

  Future<EventsQueryResult> call(HomeEventsQuery query) {
    return repository.queryEvents(query);
  }
}
