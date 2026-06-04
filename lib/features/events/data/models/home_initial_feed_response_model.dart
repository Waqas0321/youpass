import 'package:youpass/features/events/data/models/event_model.dart';
import 'package:youpass/features/events/data/models/event_type_model.dart';

class HomeInitialFeedResponseModel {
  const HomeInitialFeedResponseModel({
    required this.eventTypes,
    required this.carouselEvents,
    required this.featuredEvents,
  });

  final List<EventTypeModel> eventTypes;
  final List<EventModel> carouselEvents;
  final List<EventModel> featuredEvents;

  factory HomeInitialFeedResponseModel.fromJson(Map<String, dynamic> json) {
    return HomeInitialFeedResponseModel(
      eventTypes: EventTypeModel.listFromJson(json['event_types']),
      carouselEvents: EventModel.listFromJson(json['carousel']),
      featuredEvents: EventModel.listFromJson(json['featured_events']),
    );
  }
}
