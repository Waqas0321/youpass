import 'package:youpass/features/events/domain/entities/event_detail_entity.dart';
import 'package:youpass/features/events/domain/entities/event_entity.dart';
import 'package:youpass/features/events/domain/entities/event_type_entity.dart';
import 'package:youpass/features/events/domain/entities/home_events_query.dart';
import 'package:youpass/features/home/domain/entities/event_category_entity.dart';
import 'package:youpass/features/home/domain/entities/home_feed_entity.dart';
import 'package:youpass/features/home/domain/entities/main_banner_carousel_config_entity.dart';

abstract class EventsRepository {
  Future<HomeFeedEntity> fetchHomeFeed({
    String? countryCode,
    String? feedContext,
    double? lat,
    double? lng,
  });

  Future<HomeFeedEventsUpdate> fetchFilteredEvents(EventCategoryEntity category);

  Future<List<EventEntity>> fetchAllEvents(HomeEventsQuery query);

  Future<EventsQueryResult> queryEvents(HomeEventsQuery query);

  Future<UpcomingEventsPageResult> fetchUpcomingEvents(HomeEventsQuery query);

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
    this.mainBannerCarouselConfig,
  });

  final List<EventEntity> carouselEvents;
  final List<EventEntity> featuredEvents;
  final MainBannerCarouselConfigEntity? mainBannerCarouselConfig;
}
