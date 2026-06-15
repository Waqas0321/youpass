import 'package:youpass/features/events/domain/repositories/events_repository.dart';
import 'package:youpass/features/home/data/datasources/home_remote_datasource.dart';
import 'package:youpass/features/home/domain/entities/event_category_entity.dart';
import 'package:youpass/features/home/domain/entities/home_feed_entity.dart';
import 'package:youpass/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl(this.remoteDataSource);

  final HomeRemoteDataSource remoteDataSource;

  @override
  Future<HomeFeedEntity> getHomeFeed({
    String? feedContext,
    String? countryCode,
  }) {
    return remoteDataSource.fetchHomeFeed(
      feedContext: feedContext,
      countryCode: countryCode,
    );
  }

  @override
  Future<HomeFeedEventsUpdate> getFilteredEvents(
    EventCategoryEntity category,
  ) {
    return remoteDataSource.fetchFilteredEvents(category);
  }

  @override
  Future<void> toggleEventFavorite({
    required String eventId,
    required bool isFavorite,
  }) {
    return remoteDataSource.toggleEventFavorite(
      eventId: eventId,
      isFavorite: isFavorite,
    );
  }
}
