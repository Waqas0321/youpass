import 'package:youpass/core/network/models/config_category_model.dart';
import 'package:youpass/core/utils/json_readers.dart';
import 'package:youpass/features/events/data/mappers/home_layout_mapper.dart';
import 'package:youpass/features/events/data/models/event_model.dart';
import 'package:youpass/features/events/data/models/event_type_model.dart';
import 'package:youpass/features/home/domain/entities/home_feed_meta_entity.dart';
import 'package:youpass/features/home/domain/entities/home_search_filters_entity.dart';
import 'package:youpass/features/home/domain/entities/main_banner_carousel_config_entity.dart';

class HomeInitialFeedResponseModel {
  const HomeInitialFeedResponseModel({
    required this.eventTypes,
    required this.carouselEvents,
    required this.featuredEvents,
    this.categories = const [],
    this.layoutCategories = const [],
    this.countryCode,
    this.greeting,
    this.headerGreeting,
    this.upcomingSectionTitle,
    this.upcomingHasMore = false,
    this.searchPlaceholder,
    this.searchFiltersConfig,
    this.partyMode,
    this.invitations,
    this.postRegistration = false,
    this.mainBannerCarouselConfig,
  });

  final List<EventTypeModel> eventTypes;
  final List<EventModel> carouselEvents;
  final List<EventModel> featuredEvents;
  final List<ConfigCategoryModel> categories;
  final List<ConfigCategoryModel> layoutCategories;
  final String? countryCode;
  final HomeGreetingEntity? greeting;
  final String? headerGreeting;
  final String? upcomingSectionTitle;
  final bool upcomingHasMore;
  final String? searchPlaceholder;
  final HomeSearchFiltersConfigEntity? searchFiltersConfig;
  final HomePartyModeEntity? partyMode;
  final HomeInvitationsMetaEntity? invitations;
  final bool postRegistration;
  final MainBannerCarouselConfigEntity? mainBannerCarouselConfig;

  factory HomeInitialFeedResponseModel.fromJson(Map<String, dynamic> json) {
    final categoriesRaw = json['categories'];
    final categories = categoriesRaw is List
        ? ConfigCategoryModel.listFromRawData(categoriesRaw)
        : const <ConfigCategoryModel>[];

    final layout = HomeLayoutMapper.fromJson(json['layout']);
    final legacyGreeting = _parseGreeting(json['greeting']);
    final legacyCarousel = EventModel.listFromJson(json['carousel']);
    final legacyFeatured = EventModel.listFromJson(json['featured_events']);

    return HomeInitialFeedResponseModel(
      eventTypes: EventTypeModel.listFromJson(json['event_types']),
      carouselEvents: _firstNonEmpty(
        layout?.carouselEvents ?? const [],
        legacyCarousel,
      ),
      featuredEvents: _firstNonEmpty(
        layout?.upcomingEvents ?? const [],
        legacyFeatured,
      ),
      categories: categories,
      layoutCategories: layout?.layoutCategories ?? const [],
      countryCode: json['country_code']?.toString() ?? json['countryCode']?.toString(),
      greeting: layout?.greeting ?? legacyGreeting,
      headerGreeting: layout?.headerGreeting,
      upcomingSectionTitle: layout?.upcomingSectionTitle,
      upcomingHasMore: layout?.upcomingHasMore ?? false,
      searchPlaceholder: layout?.searchPlaceholder,
      searchFiltersConfig: layout?.searchFiltersConfig,
      partyMode: _parsePartyMode(json['party_mode'] ?? json['partyMode']),
      invitations: _parseInvitations(json['invitations']),
      postRegistration: JsonReaders.boolean(json, 'post_registration', fallback: false) ||
          JsonReaders.boolean(json, 'postRegistration', fallback: false),
      mainBannerCarouselConfig: layout?.mainBannerCarouselConfig,
    );
  }

  static List<EventModel> _firstNonEmpty(
    List<EventModel> primary,
    List<EventModel> fallback,
  ) {
    if (primary.isNotEmpty) {
      return primary;
    }
    return fallback;
  }

  static HomeGreetingEntity? _parseGreeting(Object? value) {
    if (value is! Map<String, dynamic>) {
      return null;
    }

    final message = JsonReaders.string(value, 'message');
    if (message.isEmpty) {
      final fullName = JsonReaders.string(value, 'full_name',
          fallback: JsonReaders.string(value, 'fullName'));
      if (fullName.isEmpty) {
        return null;
      }

      return HomeGreetingEntity(
        firstName: JsonReaders.string(value, 'first_name',
            fallback: JsonReaders.string(value, 'firstName')),
        fullName: fullName,
        message: 'Hi, $fullName!',
        category: JsonReaders.nullableString(value, 'category'),
      );
    }

    return HomeGreetingEntity(
      firstName: JsonReaders.string(value, 'first_name',
          fallback: JsonReaders.string(value, 'firstName')),
      fullName: JsonReaders.string(value, 'full_name',
          fallback: JsonReaders.string(value, 'fullName')),
      message: message,
      category: JsonReaders.nullableString(value, 'category'),
    );
  }

  static HomePartyModeEntity? _parsePartyMode(Object? value) {
    if (value is! Map<String, dynamic>) {
      return null;
    }

    final eligibleRaw =
        value['eligible_events'] ?? value['eligibleEvents'];
    final eligibleEvents = <HomePartyModeEligibleEventEntity>[];
    if (eligibleRaw is List) {
      for (final item in eligibleRaw) {
        if (item is! Map<String, dynamic>) {
          continue;
        }
        final eventId = JsonReaders.nullableString(item, 'event_id') ??
            JsonReaders.nullableString(item, 'eventId');
        if (eventId == null || eventId.isEmpty) {
          continue;
        }
        eligibleEvents.add(
          HomePartyModeEligibleEventEntity(
            eventId: eventId,
            eventTitle: JsonReaders.string(
              item,
              'event_title',
              fallback: JsonReaders.string(item, 'eventTitle'),
            ),
            startsAt: JsonReaders.dateTime(item, 'starts_at') ??
                JsonReaders.dateTime(item, 'startsAt'),
            endsAt: JsonReaders.dateTime(item, 'ends_at') ??
                JsonReaders.dateTime(item, 'endsAt'),
          ),
        );
      }
    }

    return HomePartyModeEntity(
      enabled: JsonReaders.boolean(value, 'enabled', fallback: false),
      bannerVisible: JsonReaders.boolean(
        value,
        'banner_visible',
        fallback: JsonReaders.boolean(value, 'bannerVisible', fallback: true),
      ),
      eventId: JsonReaders.nullableString(value, 'event_id') ??
          JsonReaders.nullableString(value, 'eventId'),
      eventTitle: JsonReaders.nullableString(value, 'event_title') ??
          JsonReaders.nullableString(value, 'eventTitle'),
      eligibleEvents: eligibleEvents,
    );
  }

  static HomeInvitationsMetaEntity? _parseInvitations(Object? value) {
    if (value is! Map<String, dynamic>) {
      return null;
    }

    final featuredRaw = value['featured'];
    HomeFeaturedInvitationEntity? featured;
    if (featuredRaw is Map<String, dynamic>) {
      featured = HomeFeaturedInvitationEntity(
        id: JsonReaders.string(featuredRaw, 'id'),
        eventTitle: JsonReaders.string(
          featuredRaw,
          'event_title',
          fallback: JsonReaders.string(featuredRaw, 'eventTitle'),
        ),
        status: JsonReaders.nullableString(featuredRaw, 'status'),
      );
    }

    return HomeInvitationsMetaEntity(
      highlight: JsonReaders.boolean(value, 'highlight', fallback: false),
      pendingCount: JsonReaders.integer(
        value,
        'pending_count',
        fallback: JsonReaders.integer(value, 'pendingCount'),
      ),
      featured: featured,
    );
  }
}
