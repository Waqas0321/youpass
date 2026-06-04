import 'package:youpass/features/events/data/services/events_api_service.dart';
import 'package:youpass/features/events/domain/entities/event_entity.dart';
import 'package:youpass/features/events/domain/entities/home_events_query.dart';
import 'package:youpass/features/events/domain/repositories/events_repository.dart';
import 'package:youpass/features/home/domain/entities/event_category_entity.dart';

class GetAllEventsUseCase {
  GetAllEventsUseCase(this.repository);

  final EventsRepository repository;

  Future<List<EventEntity>> call({
    EventCategoryEntity? category,
    int page = 1,
    int limit = EventsApiService.defaultPageSize,
  }) {
    final query = category == null
        ? HomeEventsQuery(page: page, limit: limit)
        : HomeEventsQuery(
            countryCode: category.countryCode,
            eventTypeSlug: category.eventTypeSlug,
            page: page,
            limit: limit,
          );

    return repository.fetchAllEvents(query);
  }
}
