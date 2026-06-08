import 'package:youpass/features/events/domain/entities/event_detail_entity.dart';
import 'package:youpass/features/events/domain/repositories/events_repository.dart';

class GetEventDetailUseCase {
  GetEventDetailUseCase(this.repository);

  final EventsRepository repository;

  Future<EventDetailEntity> call(String eventId) {
    return repository.fetchEventDetail(eventId);
  }
}
