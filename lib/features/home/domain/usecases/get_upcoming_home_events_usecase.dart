import 'package:youpass/features/events/domain/entities/home_events_query.dart';
import 'package:youpass/features/events/domain/repositories/events_repository.dart';

class GetUpcomingHomeEventsUseCase {
  GetUpcomingHomeEventsUseCase(this.repository);

  final EventsRepository repository;

  Future<UpcomingEventsPageResult> call(HomeEventsQuery query) {
    return repository.fetchUpcomingEvents(query);
  }
}
