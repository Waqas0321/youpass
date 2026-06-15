import 'package:youpass/features/favorites/data/services/favorites_api_service.dart';
import 'package:youpass/features/favorites/domain/entities/favorites_snapshot_entity.dart';
import 'package:youpass/features/favorites/domain/repositories/favorites_repository.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  FavoritesRepositoryImpl(this.apiService);

  final FavoritesApiService apiService;

  @override
  Future<FavoritesSnapshotEntity> fetchAllFavorites() {
    return apiService.fetchAllFavorites();
  }

  @override
  Future<ProducerCalendarSnapshot> fetchProducerUpcomingEvents(
    String producerId,
  ) {
    return apiService.fetchProducerUpcomingEvents(producerId);
  }

  @override
  Future<void> unfollowProducer(String producerId) {
    return apiService.unfollowProducer(producerId);
  }

  @override
  Future<void> followProducer(String producerId) {
    return apiService.followProducer(producerId);
  }

  @override
  Future<void> removeSavedEvent(String eventId) {
    return apiService.removeSavedEvent(eventId);
  }
}
