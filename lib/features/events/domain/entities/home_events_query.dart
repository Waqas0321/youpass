import 'package:youpass/features/events/domain/entities/event_entity.dart';
import 'package:youpass/features/home/domain/entities/event_category_entity.dart';
import 'package:youpass/features/home/domain/entities/home_search_filters_entity.dart';

class HomeEventsQuery {
  const HomeEventsQuery({
    this.countryCode,
    this.eventTypeSlug,
    this.searchQuery,
    this.page,
    this.limit,
    this.filters = HomeEventsFiltersEntity.empty,
    this.nearMe = false,
    this.latitude,
    this.longitude,
    this.excludeIds = const [],
  });

  final String? countryCode;
  final String? eventTypeSlug;
  final String? searchQuery;
  final int? page;
  final int? limit;
  final HomeEventsFiltersEntity filters;
  final bool nearMe;
  final double? latitude;
  final double? longitude;
  final List<String> excludeIds;

  factory HomeEventsQuery.fromCategory(
    EventCategoryEntity category, {
    String? searchQuery,
    HomeEventsFiltersEntity filters = HomeEventsFiltersEntity.empty,
    int? page,
    int? limit,
  }) {
    return HomeEventsQuery(
      countryCode: category.countryCode,
      eventTypeSlug: category.eventTypeSlug,
      searchQuery: searchQuery,
      filters: filters,
      page: page,
      limit: limit,
    );
  }

  Map<String, String> toQueryParameters() {
    final params = <String, String>{};
    if (countryCode != null && countryCode!.isNotEmpty) {
      params['country_code'] = countryCode!;
    }
    if (eventTypeSlug != null && eventTypeSlug!.isNotEmpty) {
      params['event_type'] = eventTypeSlug!;
    }
    if (searchQuery != null && searchQuery!.trim().isNotEmpty) {
      params['q'] = searchQuery!.trim();
    }
    if (page != null) {
      params['page'] = page.toString();
    }
    if (limit != null) {
      params['limit'] = limit.toString();
    }
    if (nearMe) {
      params['near_me'] = 'true';
    }
    if (latitude != null) {
      params['lat'] = latitude.toString();
    }
    if (longitude != null) {
      params['lng'] = longitude.toString();
    }
    if (excludeIds.isNotEmpty) {
      params['exclude_ids'] = excludeIds.join(',');
    }

    final f = filters;
    if (f.datePreset != null && f.datePreset!.isNotEmpty && f.datePreset != 'custom') {
      params['date_preset'] = f.datePreset!;
    }
    if (f.dateFrom != null) {
      final from = DateTime.utc(
        f.dateFrom!.year,
        f.dateFrom!.month,
        f.dateFrom!.day,
      );
      params['date_from'] = from.toIso8601String();
    }
    if (f.dateTo != null) {
      final to = DateTime.utc(
        f.dateTo!.year,
        f.dateTo!.month,
        f.dateTo!.day,
        23,
        59,
        59,
        999,
      );
      params['date_to'] = to.toIso8601String();
    }
    if (f.city != null && f.city!.isNotEmpty) {
      params['city'] = f.city!;
    }
    if (f.zone != null && f.zone!.isNotEmpty) {
      params['zone'] = f.zone!;
    }
    if (f.venueKind != null && f.venueKind!.isNotEmpty) {
      params['venue_kind'] = f.venueKind!;
    }
    if (f.freeOnly) {
      params['free_only'] = 'true';
    } else {
      if (f.minPrice != null) {
        params['min_price'] = f.minPrice!.round().toString();
      }
      if (f.maxPrice != null) {
        params['max_price'] = f.maxPrice!.round().toString();
      }
    }

    return params;
  }
}

class EventsQueryResult {
  const EventsQueryResult({
    required this.events,
    required this.total,
  });

  final List<EventEntity> events;
  final int total;
}

class UpcomingEventsPageResult {
  const UpcomingEventsPageResult({
    required this.events,
    required this.hasMore,
    required this.page,
    required this.total,
  });

  final List<EventEntity> events;
  final bool hasMore;
  final int page;
  final int total;
}
