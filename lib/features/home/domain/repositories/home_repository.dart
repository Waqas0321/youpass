import 'package:youpass/features/events/domain/repositories/events_repository.dart';
import 'package:youpass/features/home/domain/entities/event_category_entity.dart';
import 'package:youpass/features/home/domain/entities/home_feed_entity.dart';

abstract class HomeRepository {
  Future<HomeFeedEntity> getHomeFeed({
    String? feedContext,
    String? countryCode,
  });

  Future<HomeFeedEventsUpdate> getFilteredEvents(EventCategoryEntity category);

  Future<void> toggleEventFavorite({
    required String eventId,
    required bool isFavorite,
  });
}
