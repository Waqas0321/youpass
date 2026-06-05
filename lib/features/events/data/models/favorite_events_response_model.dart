import 'package:youpass/features/events/data/models/event_model.dart';

class FavoriteEventsResponseModel {
  const FavoriteEventsResponseModel({required this.events});

  final List<EventModel> events;

  factory FavoriteEventsResponseModel.fromRawData(Object? data) {
    if (data is Map<String, dynamic>) {
      return FavoriteEventsResponseModel(
        events: EventModel.listFromJson(data['events'] ?? data['items']),
      );
    }

    return FavoriteEventsResponseModel(
      events: EventModel.listFromJson(data),
    );
  }
}
