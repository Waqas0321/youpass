import 'package:youpass/core/network/models/config_category_model.dart';
import 'package:youpass/core/utils/json_readers.dart';
import 'package:youpass/features/events/data/models/event_model.dart';
import 'package:youpass/features/home/domain/entities/home_feed_meta_entity.dart';
import 'package:youpass/features/home/domain/entities/home_search_filters_entity.dart';
import 'package:youpass/features/home/domain/entities/main_banner_carousel_config_entity.dart';
import 'package:youpass/features/home/data/mappers/home_search_filters_mapper.dart';

class HomeLayoutParseResult {
  const HomeLayoutParseResult({
    this.headerGreeting,
    this.layoutCategories = const [],
    this.carouselEvents = const [],
    this.upcomingEvents = const [],
    this.upcomingSectionTitle,
    this.upcomingHasMore = false,
    this.searchPlaceholder,
    this.searchFiltersConfig,
    this.greeting,
    this.mainBannerCarouselConfig,
    this.mainBannerTitle,
    this.mainBannerCuratedBy,
  });

  final String? headerGreeting;
  final List<ConfigCategoryModel> layoutCategories;
  final List<EventModel> carouselEvents;
  final List<EventModel> upcomingEvents;
  final String? upcomingSectionTitle;
  final bool upcomingHasMore;
  final String? searchPlaceholder;
  final HomeSearchFiltersConfigEntity? searchFiltersConfig;
  final HomeGreetingEntity? greeting;
  final MainBannerCarouselConfigEntity? mainBannerCarouselConfig;
  final String? mainBannerTitle;
  final String? mainBannerCuratedBy;

  bool get hasData =>
      headerGreeting != null ||
      layoutCategories.isNotEmpty ||
      carouselEvents.isNotEmpty ||
      upcomingEvents.isNotEmpty ||
      upcomingSectionTitle != null ||
      searchPlaceholder != null ||
      searchFiltersConfig != null ||
      greeting != null ||
      mainBannerCarouselConfig != null;
}

class HomeLayoutMapper {
  HomeLayoutMapper._();

  static HomeLayoutParseResult? fromJson(Object? value) {
    if (value is! Map<String, dynamic>) {
      return null;
    }

    final header = value['header'];
    final categories = value['categories'];
    final mainBanner = value['main_banner'] ?? value['mainBanner'];
    final search = value['search'];
    final upcoming = value['upcoming_events'] ?? value['upcomingEvents'];
    final upcomingParsed = _parseUpcomingItems(upcoming);

    String? headerGreeting;
    if (header is Map<String, dynamic>) {
      headerGreeting = JsonReaders.nullableString(header, 'greeting');
    }

    return HomeLayoutParseResult(
      headerGreeting: headerGreeting,
      layoutCategories: _parseLayoutCategories(categories),
      carouselEvents: _parseSlides(mainBanner),
      upcomingEvents: upcomingParsed.items,
      upcomingSectionTitle: upcoming is Map<String, dynamic>
          ? JsonReaders.nullableString(upcoming, 'title')
          : null,
      upcomingHasMore: upcomingParsed.hasMore,
      searchPlaceholder:
          search is Map<String, dynamic> ? JsonReaders.nullableString(search, 'placeholder') : null,
      searchFiltersConfig:
          search is Map<String, dynamic> ? HomeSearchFiltersMapper.fromJson(search) : null,
      greeting: _greetingFromHeader(headerGreeting),
      mainBannerCarouselConfig: _parseCarouselConfig(mainBanner),
      mainBannerTitle: mainBanner is Map<String, dynamic>
          ? JsonReaders.nullableString(mainBanner, 'title')
          : null,
      mainBannerCuratedBy: mainBanner is Map<String, dynamic>
          ? JsonReaders.nullableString(mainBanner, 'curated_by')
          : null,
    );
  }

  static MainBannerCarouselConfigEntity? _parseCarouselConfig(Object? value) {
    if (value is! Map<String, dynamic>) {
      return null;
    }
    final carousel = value['carousel'];
    if (carousel == null) {
      return MainBannerCarouselConfigEntity.defaults;
    }
    return MainBannerCarouselConfigEntity.fromJson(carousel);
  }

  static List<ConfigCategoryModel> _parseLayoutCategories(Object? value) {
    if (value is! Map<String, dynamic>) {
      return const [];
    }

    final categories = <ConfigCategoryModel>[];
    final country = value['country'];
    if (country is Map<String, dynamic>) {
      final code = JsonReaders.string(country, 'code');
      if (code.isNotEmpty) {
        categories.add(
          ConfigCategoryModel(
            id: 'country:$code',
            label: _countryTabLabel(country, code),
            countryCode: code,
          ),
        );
      }
    }

    final typesRaw = value['event_types'] ?? value['eventTypes'];
    if (typesRaw is List) {
      for (final item in typesRaw) {
        if (item is! Map<String, dynamic>) {
          continue;
        }
        final slug = JsonReaders.string(item, 'slug');
        if (slug.isEmpty) {
          continue;
        }
        categories.add(
          ConfigCategoryModel(
            id: slug,
            label: JsonReaders.string(item, 'label',
                fallback: JsonReaders.string(item, 'name', fallback: slug)),
            eventTypeSlug: slug,
          ),
        );
      }
    }

    return categories;
  }

  static String _countryTabLabel(Map<String, dynamic> country, String code) {
    final label = JsonReaders.string(country, 'label',
        fallback: JsonReaders.string(country, 'name', fallback: code));
    final prefix = JsonReaders.string(country, 'prefix_icon', fallback: '📍');
    return '$prefix $label';
  }

  static List<EventModel> _parseSlides(Object? value) {
    if (value is! Map<String, dynamic>) {
      return const [];
    }

    return EventModel.listFromJson(value['slides']);
  }

  static ({List<EventModel> items, bool hasMore}) _parseUpcomingItems(Object? value) {
    if (value is! Map<String, dynamic>) {
      return (items: const [], hasMore: false);
    }

    var hasMore = false;
    final pagination = value['pagination'];
    if (pagination is Map<String, dynamic>) {
      hasMore = JsonReaders.boolean(pagination, 'has_more', fallback: false) ||
          JsonReaders.boolean(pagination, 'hasMore', fallback: false);
    }

    return (
      items: EventModel.listFromJson(value['items']),
      hasMore: hasMore,
    );
  }

  static HomeGreetingEntity? _greetingFromHeader(String? greeting) {
    if (greeting == null || greeting.trim().isEmpty) {
      return null;
    }

    return HomeGreetingEntity(
      firstName: '',
      fullName: '',
      message: greeting.trim(),
    );
  }
}
