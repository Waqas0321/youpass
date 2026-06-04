import 'package:youpass/features/events/domain/repositories/events_repository.dart';
import 'package:youpass/features/home/domain/entities/event_category_entity.dart';
import 'package:youpass/features/home/domain/entities/home_feed_entity.dart';

abstract class HomeRemoteDataSource {
  Future<HomeFeedEntity> fetchHomeFeed();

  Future<HomeFeedEventsUpdate> fetchFilteredEvents(EventCategoryEntity category);

  Future<void> toggleEventFavorite({
    required String eventId,
    required bool isFavorite,
  });
}
