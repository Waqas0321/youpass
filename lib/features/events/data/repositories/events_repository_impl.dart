import 'package:youpass/core/constants/app_constants.dart';
import 'package:youpass/core/network/models/config_category_model.dart';
import 'package:youpass/core/services/event_categories_cache.dart';
import 'package:youpass/core/locale/locale_provider.dart';
import 'package:youpass/core/network/config_api_service.dart';
import 'package:youpass/features/events/data/models/event_availability_model.dart';
import 'package:youpass/features/events/data/models/event_detail_model.dart';
import 'package:youpass/features/events/data/services/events_api_service.dart';
import 'package:youpass/features/events/domain/entities/event_detail_entity.dart';
import 'package:youpass/features/events/domain/entities/event_entity.dart';
import 'package:youpass/features/events/domain/entities/event_type_entity.dart';
import 'package:youpass/features/events/domain/entities/home_events_query.dart';
import 'package:youpass/features/events/domain/repositories/events_repository.dart';
import 'package:youpass/features/home/data/mappers/config_category_mapper.dart';
import 'package:youpass/features/home/data/mappers/event_category_mapper.dart';
import 'package:youpass/features/home/data/models/home_feed_model.dart';
import 'package:youpass/features/home/domain/entities/event_category_entity.dart';
import 'package:youpass/features/home/domain/entities/home_feed_entity.dart';
import 'package:youpass/l10n/app_localizations.dart';

class EventsRepositoryImpl implements EventsRepository {
  EventsRepositoryImpl({
    required this.eventsApiService,
    required this.configApiService,
    required this.localeProvider,
    required this.eventCategoriesCache,
  });

  final EventsApiService eventsApiService;
  final ConfigApiService configApiService;
  final LocaleProvider localeProvider;
  final EventCategoriesCache eventCategoriesCache;

  AppLocalizations get _l10n => lookupAppLocalizations(localeProvider.locale);

  @override
  Future<HomeFeedEntity> fetchHomeFeed({
    String? countryCode,
    String? feedContext,
  }) async {
    final payload = await eventsApiService.fetchInitialFeed(
      countryCode: countryCode,
      feedContext: feedContext,
    );

    final categories = await _resolveCategories(
      feedCategories: payload.categories,
      layoutCategories: payload.layoutCategories,
      eventTypes: payload.eventTypes,
    );

    return HomeFeedModel(
      categories: categories,
      carouselEvents: payload.carouselEvents,
      featuredEvents: payload.featuredEvents,
      greeting: payload.greeting,
      partyMode: payload.partyMode,
      invitations: payload.invitations,
      postRegistration: payload.postRegistration,
      headerGreeting: payload.headerGreeting,
      upcomingSectionTitle: payload.upcomingSectionTitle,
      upcomingHasMore: payload.upcomingHasMore,
      searchPlaceholder: payload.searchPlaceholder,
      searchFiltersConfig: payload.searchFiltersConfig,
      mainBannerCarouselConfig: payload.mainBannerCarouselConfig,
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
      mainBannerCarouselConfig: payload.mainBannerCarouselConfig,
    );
  }

  @override
  Future<List<EventEntity>> fetchAllEvents(HomeEventsQuery query) {
    return eventsApiService.fetchEvents(query: query);
  }

  @override
  Future<EventsQueryResult> queryEvents(HomeEventsQuery query) async {
    final response = await eventsApiService.queryEvents(query: query);
    return EventsQueryResult(events: response.events, total: response.total);
  }

  @override
  Future<UpcomingEventsPageResult> fetchUpcomingEvents(HomeEventsQuery query) async {
    final response = await eventsApiService.fetchUpcomingEvents(query: query);
    return UpcomingEventsPageResult(
      events: response.events,
      hasMore: response.hasMore,
      page: response.page,
      total: response.total,
    );
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
  Future<EventDetailEntity> fetchEventDetail(String eventId) async {
    final results = await Future.wait([
      eventsApiService.fetchEventById(eventId),
      eventsApiService.fetchEventAvailability(eventId),
    ]);

    final detail = results[0] as EventDetailModel;
    final availability = results[1] as EventAvailabilityModel;
    return detail.withAvailability(availability);
  }

  @override
  Future<List<EventCategoryEntity>> fetchBrowseCategories() async {
    final apiCategories = await configApiService.fetchCategories();
    if (apiCategories.isNotEmpty) {
      return ConfigCategoryMapper.toEntities(apiCategories);
    }

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

  Future<List<EventCategoryEntity>> _resolveCategories({
    required List<ConfigCategoryModel> feedCategories,
    required List<ConfigCategoryModel> layoutCategories,
    required List<EventTypeEntity> eventTypes,
  }) async {
    if (layoutCategories.isNotEmpty) {
      return _withAllTab(ConfigCategoryMapper.toEntities(layoutCategories));
    }

    if (feedCategories.isNotEmpty) {
      return _withAllTab(ConfigCategoryMapper.toEntities(feedCategories));
    }

    final apiCategories = await configApiService.fetchCategories();
    if (apiCategories.isNotEmpty) {
      return _withAllTab(ConfigCategoryMapper.toEntities(apiCategories));
    }

    final cachedCategories = eventCategoriesCache.readCached();
    if (cachedCategories.isNotEmpty) {
      return _withAllTab(ConfigCategoryMapper.toEntities(cachedCategories));
    }

    if (eventTypes.isNotEmpty) {
      return _withAllTab(
        EventCategoryMapper.buildCategories(
          eventTypes: eventTypes,
          l10n: _l10n,
        ),
      );
    }

    return const [];
  }

  List<EventCategoryEntity> _withAllTab(List<EventCategoryEntity> categories) {
    EventCategoryEntity? countryTab;
    final eventTypes = <EventCategoryEntity>[];

    for (final category in categories) {
      if (category.countryCode != null &&
          category.countryCode!.isNotEmpty &&
          category.id.startsWith('country:')) {
        countryTab ??= category;
        continue;
      }
      if (category.id == AppConstants.categoryIdAll) {
        continue;
      }
      eventTypes.add(category);
    }

    if (countryTab != null) {
      return [countryTab, ...eventTypes];
    }

    return eventTypes;
  }
}

EventsRepository createEventsRepository({
  required EventsApiService eventsApiService,
  required ConfigApiService configApiService,
  required LocaleProvider localeProvider,
  required EventCategoriesCache eventCategoriesCache,
}) {
  return EventsRepositoryImpl(
    eventsApiService: eventsApiService,
    configApiService: configApiService,
    localeProvider: localeProvider,
    eventCategoriesCache: eventCategoriesCache,
  );
}
