import 'package:youpass/core/network/api_endpoints.dart';
import 'package:youpass/core/network/base_api_service.dart';
import 'package:youpass/features/favorites/data/models/favorites_combined_response_model.dart';
import 'package:youpass/features/favorites/data/models/producer_calendar_response_model.dart';

class FavoritesApiService extends BaseApiService {
  FavoritesApiService(super.apiClient);

  Future<FavoritesCombinedResponseModel> fetchAllFavorites() {
    return getRawModel(
      ApiEndpoints.favoritesCombined,
      fromRawData: FavoritesCombinedResponseModel.fromRawData,
      authenticated: true,
    );
  }

  Future<ProducerCalendarResponseModel> fetchProducerUpcomingEvents(
    String producerId,
  ) {
    return getRawModel(
      ApiEndpoints.producerUpcomingEvents(producerId),
      fromRawData: ProducerCalendarResponseModel.fromRawData,
      authenticated: true,
    );
  }

  Future<void> unfollowProducer(String producerId) {
    return deleteVoid(
      ApiEndpoints.favoriteProducer(producerId),
      authenticated: true,
    );
  }

  Future<void> followProducer(String producerId) {
    return postVoid(
      ApiEndpoints.favoriteProducer(producerId),
      authenticated: true,
    );
  }

  Future<void> removeSavedEvent(String eventId) {
    return deleteVoid(
      ApiEndpoints.favoriteEvent(eventId),
      authenticated: true,
    );
  }
}
