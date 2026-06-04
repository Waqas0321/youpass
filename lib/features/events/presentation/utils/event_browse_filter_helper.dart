import 'package:youpass/core/constants/app_constants.dart';
import 'package:youpass/features/events/domain/entities/event_entity.dart';
import 'package:youpass/features/home/domain/entities/event_category_entity.dart';

class EventBrowseFilterHelper {
  EventBrowseFilterHelper._();

  static List<EventEntity> filter({
    required List<EventEntity> events,
    required String searchQuery,
    required String selectedCategoryId,
    required List<EventCategoryEntity> categories,
  }) {
    final category = findCategory(categories, selectedCategoryId);
    final query = searchQuery.trim().toLowerCase();

    return events.where((event) {
      if (!_matchesCategory(event, category)) {
        return false;
      }
      if (query.isEmpty) {
        return true;
      }
      return event.title.toLowerCase().contains(query) ||
          event.locationLabel.toLowerCase().contains(query);
    }).toList();
  }

  static EventCategoryEntity? findCategory(
    List<EventCategoryEntity> categories,
    String categoryId,
  ) {
    if (categoryId == AppConstants.categoryIdAll) {
      return null;
    }

    for (final category in categories) {
      if (category.id == categoryId) {
        return category;
      }
    }
    return null;
  }

  static bool _matchesCategory(
    EventEntity event,
    EventCategoryEntity? category,
  ) {
    if (category == null) {
      return true;
    }

    final countryCode = category.countryCode;
    if (countryCode != null && countryCode.isNotEmpty) {
      return event.countryCode?.toUpperCase() == countryCode.toUpperCase();
    }

    final eventTypeSlug = category.eventTypeSlug;
    if (eventTypeSlug != null && eventTypeSlug.isNotEmpty) {
      return event.eventTypeSlug == eventTypeSlug;
    }

    return true;
  }
}
