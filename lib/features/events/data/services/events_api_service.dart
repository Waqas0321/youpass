import 'package:youpass/core/network/api_endpoints.dart';
import 'package:youpass/core/network/base_api_service.dart';
import 'package:youpass/features/events/data/models/event_availability_model.dart';
import 'package:youpass/features/events/data/models/event_detail_model.dart';
import 'package:youpass/features/events/data/models/event_model.dart';
import 'package:youpass/features/events/data/models/event_type_list_response_model.dart';
import 'package:youpass/features/events/data/models/event_type_model.dart';
import 'package:youpass/features/events/data/models/events_list_response_model.dart';
import 'package:youpass/features/events/data/models/favorite_events_response_model.dart';
import 'package:youpass/features/events/data/models/featured_events_response_model.dart';
import 'package:youpass/features/events/data/models/upcoming_events_response_model.dart';
import 'package:youpass/features/events/data/models/home_initial_feed_response_model.dart';
import 'package:youpass/features/events/domain/entities/home_events_query.dart';

class EventsApiService extends BaseApiService {
  EventsApiService(super.apiClient);

  static const int defaultPageSize = 20;

  Future<HomeInitialFeedResponseModel> fetchInitialFeed({
    bool includeAuth = true,
    String? countryCode,
    String? feedContext,
    String? eventType,
  }) {
    final params = <String, String>{};
    if (countryCode != null && countryCode.isNotEmpty) {
      params['country_code'] = countryCode;
    }
    if (feedContext != null && feedContext.isNotEmpty) {
      params['context'] = feedContext;
    }
    if (eventType != null && eventType.isNotEmpty) {
      params['event_type'] = eventType;
    }

    final endpoint = params.isEmpty
        ? ApiEndpoints.homeInitialFeed
        : '${ApiEndpoints.homeInitialFeed}?${Uri(queryParameters: params).query}';

    return getModel(
      endpoint,
      fromJson: HomeInitialFeedResponseModel.fromJson,
      authenticated: includeAuth,
    );
  }

  Future<List<EventTypeModel>> fetchEventTypes() async {
    final response = await getRawModel(
      ApiEndpoints.eventTypes,
      fromRawData: EventTypeListResponseModel.fromRawData,
    );
    return response.eventTypes;
  }

  Future<FeaturedEventsResponseModel> fetchFeaturedEvents({
    required HomeEventsQuery query,
    bool includeAuth = true,
  }) {
    return getModel(
      _withQuery(ApiEndpoints.eventsFeatured, query),
      fromJson: FeaturedEventsResponseModel.fromJson,
      authenticated: includeAuth,
    );
  }

  Future<List<EventModel>> fetchEvents({
    required HomeEventsQuery query,
    bool includeAuth = true,
  }) async {
    final response = await queryEvents(query: query, includeAuth: includeAuth);
    return response.events;
  }

  Future<EventsListResponseModel> queryEvents({
    required HomeEventsQuery query,
    bool includeAuth = true,
  }) {
    return getModel(
      _withQuery(ApiEndpoints.events, query),
      fromJson: EventsListResponseModel.fromJson,
      authenticated: includeAuth,
    );
  }

  Future<UpcomingEventsResponseModel> fetchUpcomingEvents({
    required HomeEventsQuery query,
    bool includeAuth = true,
  }) {
    return getModel(
      _withQuery(ApiEndpoints.homeUpcomingEvents, query),
      fromJson: UpcomingEventsResponseModel.fromJson,
      authenticated: includeAuth,
    );
  }

  Future<List<EventModel>> fetchFavoriteEvents() async {
    final response = await getRawModel(
      ApiEndpoints.favoriteEvents,
      fromRawData: FavoriteEventsResponseModel.fromRawData,
      authenticated: true,
    );
    return response.events;
  }

  Future<void> addFavorite(String eventId) {
    return postVoid(
      ApiEndpoints.favoriteEvent(eventId),
      authenticated: true,
      body: null,
    );
  }

  Future<void> removeFavorite(String eventId) {
    return deleteVoid(
      ApiEndpoints.favoriteEvent(eventId),
      authenticated: true,
    );
  }

  Future<EventDetailModel> fetchEventById(String eventId) {
    return getModel(
      ApiEndpoints.eventById(eventId),
      fromJson: EventDetailModel.fromJson,
      authenticated: true,
    );
  }

  Future<EventAvailabilityModel> fetchEventAvailability(String eventId) {
    return getModel(
      ApiEndpoints.eventAvailability(eventId),
      fromJson: EventAvailabilityModel.fromJson,
      authenticated: true,
    );
  }

  String _withQuery(String endpoint, HomeEventsQuery query) {
    final params = query.toQueryParameters();
    if (params.isEmpty) {
      return endpoint;
    }

    return '$endpoint?${Uri(queryParameters: params).query}';
  }
}
