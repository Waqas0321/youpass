import 'package:youpass/features/events/domain/entities/event_detail_entity.dart';
import 'package:youpass/features/events/domain/entities/event_entity.dart';
import 'package:youpass/features/events/domain/entities/event_type_entity.dart';
import 'package:youpass/features/events/domain/entities/home_events_query.dart';
import 'package:youpass/features/home/domain/entities/event_category_entity.dart';
import 'package:youpass/features/home/domain/entities/home_feed_entity.dart';

abstract class EventsRepository {
  Future<HomeFeedEntity> fetchHomeFeed({
    String? countryCode,
    String? feedContext,
  });

  Future<HomeFeedEventsUpdate> fetchFilteredEvents(EventCategoryEntity category);

  Future<List<EventEntity>> fetchAllEvents(HomeEventsQuery query);

  Future<List<EventTypeEntity>> fetchEventTypes();

  Future<List<EventEntity>> fetchFavoriteEvents();

  Future<EventDetailEntity> fetchEventDetail(String eventId);

  Future<List<EventCategoryEntity>> fetchBrowseCategories();

  Future<void> addEventFavorite(String eventId);

  Future<void> removeEventFavorite(String eventId);
}

class HomeFeedEventsUpdate {
  const HomeFeedEventsUpdate({
    required this.carouselEvents,
    required this.featuredEvents,
  });

  final List<EventEntity> carouselEvents;
  final List<EventEntity> featuredEvents;
}
