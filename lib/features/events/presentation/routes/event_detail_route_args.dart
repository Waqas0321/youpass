import 'package:youpass/features/events/domain/entities/event_entity.dart';

class EventDetailRouteArgs {
  const EventDetailRouteArgs({
    required this.eventId,
    this.previewEvent,
  });

  final String eventId;
  final EventEntity? previewEvent;
}
