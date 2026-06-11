import 'package:youpass/core/network/models/config_category_model.dart';
import 'package:youpass/core/utils/json_readers.dart';
import 'package:youpass/features/events/data/models/event_model.dart';
import 'package:youpass/features/home/domain/entities/home_feed_meta_entity.dart';

class HomeLayoutParseResult {
  const HomeLayoutParseResult({
    this.headerGreeting,
    this.layoutCategories = const [],
    this.carouselEvents = const [],
    this.upcomingEvents = const [],
    this.upcomingSectionTitle,
    this.searchPlaceholder,
    this.greeting,
  });

  final String? headerGreeting;
  final List<ConfigCategoryModel> layoutCategories;
  final List<EventModel> carouselEvents;
  final List<EventModel> upcomingEvents;
  final String? upcomingSectionTitle;
  final String? searchPlaceholder;
  final HomeGreetingEntity? greeting;

  bool get hasData =>
      headerGreeting != null ||
      layoutCategories.isNotEmpty ||
      carouselEvents.isNotEmpty ||
      upcomingEvents.isNotEmpty ||
      upcomingSectionTitle != null ||
      searchPlaceholder != null ||
      greeting != null;
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

    String? headerGreeting;
    if (header is Map<String, dynamic>) {
      headerGreeting = JsonReaders.nullableString(header, 'greeting');
    }

    return HomeLayoutParseResult(
      headerGreeting: headerGreeting,
      layoutCategories: _parseLayoutCategories(categories),
      carouselEvents: _parseSlides(mainBanner),
      upcomingEvents: _parseUpcomingItems(upcoming),
      upcomingSectionTitle: upcoming is Map<String, dynamic>
          ? JsonReaders.nullableString(upcoming, 'title')
          : null,
      searchPlaceholder:
          search is Map<String, dynamic> ? JsonReaders.nullableString(search, 'placeholder') : null,
      greeting: _greetingFromHeader(headerGreeting),
    );
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
            label: JsonReaders.string(country, 'label',
                fallback: JsonReaders.string(country, 'name', fallback: code)),
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

  static List<EventModel> _parseSlides(Object? value) {
    if (value is! Map<String, dynamic>) {
      return const [];
    }

    return EventModel.listFromJson(value['slides']);
  }

  static List<EventModel> _parseUpcomingItems(Object? value) {
    if (value is! Map<String, dynamic>) {
      return const [];
    }

    return EventModel.listFromJson(value['items']);
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
