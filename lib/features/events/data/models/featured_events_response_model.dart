import 'package:youpass/features/events/data/models/event_model.dart';

class FeaturedEventsResponseModel {
  const FeaturedEventsResponseModel({
    required this.carouselEvents,
    required this.featuredEvents,
  });

  final List<EventModel> carouselEvents;
  final List<EventModel> featuredEvents;

  factory FeaturedEventsResponseModel.fromJson(Map<String, dynamic> json) {
    return FeaturedEventsResponseModel(
      carouselEvents: EventModel.listFromJson(json['carousel']),
      featuredEvents: EventModel.listFromJson(json['events']),
    );
  }
}
