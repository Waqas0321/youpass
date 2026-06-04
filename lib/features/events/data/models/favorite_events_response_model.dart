import 'package:youpass/features/events/data/models/event_model.dart';

class FavoriteEventsResponseModel {
  const FavoriteEventsResponseModel({required this.events});

  final List<EventModel> events;

  factory FavoriteEventsResponseModel.fromRawData(Object? data) {
    return FavoriteEventsResponseModel(
      events: EventModel.listFromJson(data),
    );
  }
}
