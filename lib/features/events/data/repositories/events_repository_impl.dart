import 'package:youpass/core/locale/locale_provider.dart';
import 'package:youpass/features/events/data/services/events_api_service.dart';
import 'package:youpass/features/events/domain/entities/event_detail_entity.dart';
import 'package:youpass/features/events/domain/entities/event_entity.dart';
import 'package:youpass/features/events/domain/entities/event_type_entity.dart';
import 'package:youpass/features/events/domain/entities/home_events_query.dart';
import 'package:youpass/features/events/domain/repositories/events_repository.dart';
import 'package:youpass/features/home/data/mappers/event_category_mapper.dart';
import 'package:youpass/features/home/data/models/home_feed_model.dart';
import 'package:youpass/features/home/domain/entities/event_category_entity.dart';
import 'package:youpass/features/home/domain/entities/home_feed_entity.dart';
import 'package:youpass/l10n/app_localizations.dart';

class EventsRepositoryImpl implements EventsRepository {
  EventsRepositoryImpl({
    required this.eventsApiService,
    required this.localeProvider,
  });

  final EventsApiService eventsApiService;
  final LocaleProvider localeProvider;

  AppLocalizations get _l10n => lookupAppLocalizations(localeProvider.locale);

  @override
  Future<HomeFeedEntity> fetchHomeFeed() async {
    final payload = await eventsApiService.fetchInitialFeed();

    return HomeFeedModel(
      categories: EventCategoryMapper.buildCategories(
        eventTypes: payload.eventTypes,
        l10n: _l10n,
      ),
      carouselEvents: payload.carouselEvents,
      featuredEvents: payload.featuredEvents,
    );
  }

  @override
  Future<HomeFeedEventsUpdate> fetchFilteredEvents(
    EventCategoryEntity category,
  ) async {
    final query = HomeEventsQuery.fromCategory(category);
    final payload = await eventsApiService.fetchFeaturedEvents(query: query);

    return HomeFeedEventsUpdate(
      carouselEvents: payload.carouselEvents,
      featuredEvents: payload.featuredEvents,
    );
  }

  @override
  Future<List<EventEntity>> fetchAllEvents(HomeEventsQuery query) {
    return eventsApiService.fetchEvents(query: query);
  }

  @override
  Future<List<EventTypeEntity>> fetchEventTypes() {
    return eventsApiService.fetchEventTypes();
  }

  @override
  Future<List<EventEntity>> fetchFavoriteEvents() {
    return eventsApiService.fetchFavoriteEvents();
  }

  @override
  Future<EventDetailEntity> fetchEventDetail(String eventId) {
    return eventsApiService.fetchEventById(eventId);
  }

  @override
  Future<List<EventCategoryEntity>> fetchBrowseCategories() async {
    final eventTypes = await eventsApiService.fetchEventTypes();
    return buildBrowseCategories(eventTypes: eventTypes);
  }

  @override
  Future<void> addEventFavorite(String eventId) {
    return eventsApiService.addFavorite(eventId);
  }

  @override
  Future<void> removeEventFavorite(String eventId) {
    return eventsApiService.removeFavorite(eventId);
  }

  List<EventCategoryEntity> buildBrowseCategories({
    required List<EventTypeEntity> eventTypes,
  }) {
    return EventCategoryMapper.buildCategories(
      eventTypes: eventTypes,
      l10n: _l10n,
    );
  }
}

EventsRepository createEventsRepository({
  required EventsApiService eventsApiService,
  required LocaleProvider localeProvider,
}) {
  return EventsRepositoryImpl(
    eventsApiService: eventsApiService,
    localeProvider: localeProvider,
  );
}
