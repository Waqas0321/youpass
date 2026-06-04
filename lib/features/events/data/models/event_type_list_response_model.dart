import 'package:youpass/features/events/data/models/event_type_model.dart';

class EventTypeListResponseModel {
  const EventTypeListResponseModel({required this.eventTypes});

  final List<EventTypeModel> eventTypes;

  factory EventTypeListResponseModel.fromRawData(Object? data) {
    return EventTypeListResponseModel(
      eventTypes: EventTypeModel.listFromJson(data),
    );
  }
}
