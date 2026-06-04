import 'package:youpass/features/events/data/models/event_model.dart';

class EventsListResponseModel {
  const EventsListResponseModel({required this.events});

  final List<EventModel> events;

  factory EventsListResponseModel.fromJson(Map<String, dynamic> json) {
    return EventsListResponseModel(
      events: EventModel.listFromJson(json['events']),
    );
  }
}
