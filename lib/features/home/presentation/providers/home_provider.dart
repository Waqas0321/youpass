import 'package:flutter/foundation.dart';
import 'package:youpass/core/constants/app_constants.dart';
import 'package:youpass/core/network/api_exception.dart';
import 'package:youpass/features/events/domain/entities/event_entity.dart';
import 'package:youpass/features/home/domain/entities/event_category_entity.dart';
import 'package:youpass/features/home/domain/entities/home_feed_entity.dart';
import 'package:youpass/features/home/domain/usecases/get_filtered_home_events_usecase.dart';
import 'package:youpass/features/home/domain/usecases/get_home_feed_usecase.dart';
import 'package:youpass/features/home/domain/usecases/toggle_event_favorite_usecase.dart';

enum HomeStatus { initial, loading, loaded, error }

class HomeProvider extends ChangeNotifier {
  HomeProvider({
    required this.getHomeFeedUseCase,
    required this.getFilteredHomeEventsUseCase,
    required this.toggleEventFavoriteUseCase,
  });

  final GetHomeFeedUseCase getHomeFeedUseCase;
  final GetFilteredHomeEventsUseCase getFilteredHomeEventsUseCase;
  final ToggleEventFavoriteUseCase toggleEventFavoriteUseCase;

  HomeStatus status = HomeStatus.initial;
  HomeFeedEntity? homeFeed;
  String? errorMessage;
  String selectedCategoryId = AppConstants.defaultHomeCategoryId;
  bool isFilteringEvents = false;
  final Set<String> _favoritePendingIds = {};

  Future<void> loadHomeData() async {
    status = HomeStatus.loading;
    errorMessage = null;
    notifyListeners();

    try {
      homeFeed = await getHomeFeedUseCase();
      selectedCategoryId = AppConstants.defaultHomeCategoryId;
      status = HomeStatus.loaded;
    } catch (error) {
      status = HomeStatus.error;
      errorMessage = error.toString();
    }
    notifyListeners();
  }

  Future<void> loadHomeDataIfNeeded() async {
    if (homeFeed != null && status == HomeStatus.loaded) {
      return;
    }
    if (status == HomeStatus.loading) {
      return;
    }
    await loadHomeData();
  }

  Future<void> selectCategory(String categoryId) async {
    if (selectedCategoryId == categoryId || homeFeed == null) {
      return;
    }

    selectedCategoryId = categoryId;
    notifyListeners();
    await _applyCategoryFilter();
  }

  Future<void> toggleFavorite(String eventId) async {
    final feed = homeFeed;
    if (feed == null || _favoritePendingIds.contains(eventId)) {
      return;
    }

    final current = _findEvent(feed, eventId);
    if (current == null) {
      return;
    }

    final nextFavorite = !current.isFavorite;
    _favoritePendingIds.add(eventId);
    homeFeed = feed.copyWithEventFavorite(
      eventId: eventId,
      isFavorite: nextFavorite,
    );
    notifyListeners();

    try {
      await toggleEventFavoriteUseCase(
        eventId: eventId,
        isFavorite: current.isFavorite,
      );
    } on ApiException catch (error) {
      homeFeed = feed;
      errorMessage = error.message;
    } catch (error) {
      homeFeed = feed;
      errorMessage = error.toString();
    } finally {
      _favoritePendingIds.remove(eventId);
      notifyListeners();
    }
  }

  bool isFavoritePending(String eventId) {
    return _favoritePendingIds.contains(eventId);
  }

  void reset() {
    status = HomeStatus.initial;
    homeFeed = null;
    errorMessage = null;
    selectedCategoryId = AppConstants.defaultHomeCategoryId;
    isFilteringEvents = false;
    _favoritePendingIds.clear();
    notifyListeners();
  }

  Future<void> _applyCategoryFilter() async {
    final feed = homeFeed;
    if (feed == null) {
      return;
    }

    final category = _findCategory(feed, selectedCategoryId);
    if (category == null) {
      return;
    }

    isFilteringEvents = true;
    errorMessage = null;
    notifyListeners();

    try {
      final filtered = await getFilteredHomeEventsUseCase(category);
      homeFeed = feed.copyWith(
        carouselEvents: filtered.carouselEvents,
        featuredEvents: filtered.featuredEvents,
      );
    } catch (error) {
      errorMessage = error.toString();
    } finally {
      isFilteringEvents = false;
      notifyListeners();
    }
  }

  EventCategoryEntity? _findCategory(HomeFeedEntity feed, String categoryId) {
    for (final category in feed.categories) {
      if (category.id == categoryId) {
        return category;
      }
    }
    return null;
  }

  EventEntity? _findEvent(HomeFeedEntity feed, String eventId) {
    for (final event in feed.featuredEvents) {
      if (event.id == eventId) {
        return event;
      }
    }
    for (final event in feed.carouselEvents) {
      if (event.id == eventId) {
        return event;
      }
    }
    return null;
  }
}
