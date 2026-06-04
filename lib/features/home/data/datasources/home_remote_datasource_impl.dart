import 'package:youpass/features/events/domain/repositories/events_repository.dart';
import 'package:youpass/features/home/data/datasources/home_remote_datasource.dart';
import 'package:youpass/features/home/domain/entities/event_category_entity.dart';
import 'package:youpass/features/home/domain/entities/home_feed_entity.dart';

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  HomeRemoteDataSourceImpl({
    required this.eventsRepository,
  });

  final EventsRepository eventsRepository;

  @override
  Future<HomeFeedEntity> fetchHomeFeed() {
    return eventsRepository.fetchHomeFeed();
  }

  @override
  Future<HomeFeedEventsUpdate> fetchFilteredEvents(
    EventCategoryEntity category,
  ) {
    return eventsRepository.fetchFilteredEvents(category);
  }

  @override
  Future<void> toggleEventFavorite({
    required String eventId,
    required bool isFavorite,
  }) {
    if (isFavorite) {
      return eventsRepository.removeEventFavorite(eventId);
    }

    return eventsRepository.addEventFavorite(eventId);
  }
}
