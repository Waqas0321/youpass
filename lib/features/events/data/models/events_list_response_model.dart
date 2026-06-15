import 'package:youpass/features/events/data/models/event_model.dart';

class EventsListResponseModel {
  const EventsListResponseModel({
    required this.events,
    this.total = 0,
  });

  final List<EventModel> events;
  final int total;

  factory EventsListResponseModel.fromJson(Map<String, dynamic> json) {
    final pagination = json['pagination'];
    var total = 0;
    if (pagination is Map<String, dynamic>) {
      final raw = pagination['total'];
      if (raw is int) {
        total = raw;
      } else if (raw is num) {
        total = raw.toInt();
      }
    }

    return EventsListResponseModel(
      events: EventModel.listFromJson(json['events']),
      total: total,
    );
  }
}
