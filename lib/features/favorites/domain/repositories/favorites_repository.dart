import 'package:youpass/features/favorites/domain/entities/favorite_producer_entity.dart';
import 'package:youpass/features/favorites/domain/entities/favorites_snapshot_entity.dart';
import 'package:youpass/features/favorites/domain/entities/producer_calendar_event_entity.dart';

class ProducerCalendarSnapshot {
  const ProducerCalendarSnapshot({
    required this.producer,
    required this.events,
    this.isFollower = false,
  });

  final FavoriteProducerEntity producer;
  final List<ProducerCalendarEventEntity> events;
  final bool isFollower;
}

abstract class FavoritesRepository {
  Future<FavoritesSnapshotEntity> fetchAllFavorites();

  Future<ProducerCalendarSnapshot> fetchProducerUpcomingEvents(String producerId);

  Future<void> unfollowProducer(String producerId);

  Future<void> followProducer(String producerId);

  Future<void> removeSavedEvent(String eventId);
}
