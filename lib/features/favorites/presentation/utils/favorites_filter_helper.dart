import 'package:youpass/features/events/domain/entities/event_entity.dart';
import 'package:youpass/features/favorites/domain/entities/favorite_producer_entity.dart';
import 'package:youpass/features/favorites/domain/entities/favorites_filter.dart';

class FavoritesFilterHelper {
  FavoritesFilterHelper._();

  static bool _matchesSearch(String query, String primary, [String? secondary]) {
    if (query.isEmpty) {
      return true;
    }

    final normalized = query.trim().toLowerCase();
    if (normalized.isEmpty) {
      return true;
    }

    if (primary.toLowerCase().contains(normalized)) {
      return true;
    }

    final extra = secondary?.toLowerCase() ?? '';
    return extra.contains(normalized);
  }

  static bool _isUpcoming(DateTime? startsAt) {
    if (startsAt == null) {
      return true;
    }
    return startsAt.isAfter(DateTime.now());
  }

  static bool _isParties(String? slug) {
    final normalized = slug?.toLowerCase() ?? '';
    return normalized == 'parties' || normalized == 'fiestas';
  }

  static bool _isVip(String? slug) {
    final normalized = slug?.toLowerCase() ?? '';
    return normalized == 'vip';
  }

  static List<FavoriteProducerEntity> filterProducers({
    required List<FavoriteProducerEntity> producers,
    required String searchQuery,
    required FavoritesFilter filter,
  }) {
    return producers.where((producer) {
      if (!_matchesSearch(
        searchQuery,
        producer.name,
        producer.description,
      )) {
        return false;
      }

      // Promoter follows are always shown for active filters except when
      // search excludes them. Event-type filters apply to saved events only.
      return true;
    }).toList();
  }

  static List<EventEntity> filterEvents({
    required List<EventEntity> events,
    required String searchQuery,
    required FavoritesFilter filter,
  }) {
    return events.where((event) {
      if (!_matchesSearch(
        searchQuery,
        event.title,
        event.locationLabel,
      )) {
        return false;
      }

      switch (filter) {
        case FavoritesFilter.all:
          return true;
        case FavoritesFilter.upcoming:
          return _isUpcoming(event.startsAt);
        case FavoritesFilter.parties:
          return _isParties(event.eventTypeSlug);
        case FavoritesFilter.vip:
          return _isVip(event.eventTypeSlug);
      }
    }).toList();
  }
}