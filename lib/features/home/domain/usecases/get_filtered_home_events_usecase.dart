import 'package:youpass/features/events/domain/repositories/events_repository.dart';
import 'package:youpass/features/home/domain/entities/event_category_entity.dart';
import 'package:youpass/features/home/domain/repositories/home_repository.dart';

class GetFilteredHomeEventsUseCase {
  GetFilteredHomeEventsUseCase(this.repository);

  final HomeRepository repository;

  Future<HomeFeedEventsUpdate> call(EventCategoryEntity category) {
    return repository.getFilteredEvents(category);
  }
}
