import 'package:youpass/features/events/domain/entities/event_entity.dart';

class EventBrowseFavoriteHelper {
  EventBrowseFavoriteHelper._();

  static List<EventEntity> replaceFavorite(
    List<EventEntity> events,
    String eventId,
    bool isFavorite,
  ) {
    return events
        .map(
          (event) =>
              event.id == eventId ? event.copyWith(isFavorite: isFavorite) : event,
        )
        .toList();
  }
}
