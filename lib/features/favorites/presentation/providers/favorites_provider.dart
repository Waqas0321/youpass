import 'package:flutter/foundation.dart';
import 'package:youpass/features/events/domain/entities/event_entity.dart';
import 'package:youpass/features/favorites/domain/entities/favorite_producer_entity.dart';
import 'package:youpass/features/favorites/domain/entities/favorites_filter.dart';
import 'package:youpass/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:youpass/features/favorites/presentation/utils/favorites_filter_helper.dart';

class FavoritesProvider extends ChangeNotifier {
  FavoritesProvider({required this.repository});

  final FavoritesRepository repository;

  List<FavoriteProducerEntity> _allProducers = [];
  List<EventEntity> _allEvents = [];
  List<FavoriteProducerEntity> _visibleProducers = [];
  List<EventEntity> _visibleEvents = [];

  FavoritesFilter selectedFilter = FavoritesFilter.all;
  String searchQuery = '';
  bool isLoading = true;
  String? errorMessage;
  int producersCount = 0;
  int eventsCount = 0;

  final Set<String> _producerPendingIds = {};
  final Set<String> _eventPendingIds = {};

  List<FavoriteProducerEntity> get visibleProducers => _visibleProducers;
  List<EventEntity> get visibleEvents => _visibleEvents;
  Set<String> get producerPendingIds => _producerPendingIds;
  Set<String> get eventPendingIds => _eventPendingIds;

  // Saved events and followed promoters.
  bool get isEmpty => _allEvents.isEmpty && _allProducers.isEmpty;
  bool get hasVisibleResults =>
      _visibleEvents.isNotEmpty || _visibleProducers.isNotEmpty;

  Future<void> loadFavorites() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final snapshot = await repository.fetchAllFavorites();
      _allProducers = snapshot.producers;
      _allEvents = snapshot.events
          .map((event) => event.copyWith(isFavorite: true))
          .toList();
      producersCount = snapshot.producersCount > 0
          ? snapshot.producersCount
          : _allProducers.length;
      eventsCount =
          snapshot.eventsCount > 0 ? snapshot.eventsCount : _allEvents.length;
      isLoading = false;
      _applyFilters();
    } catch (error) {
      isLoading = false;
      errorMessage = error.toString();
      notifyListeners();
    }
  }

  void setFilter(FavoritesFilter filter) {
    if (selectedFilter == filter) {
      return;
    }
    selectedFilter = filter;
    _applyFilters();
  }

  void setSearchQuery(String value) {
    searchQuery = value;
    _applyFilters();
  }

  void _applyFilters() {
    _visibleProducers = FavoritesFilterHelper.filterProducers(
      producers: _allProducers,
      searchQuery: searchQuery,
      filter: selectedFilter,
    );
    _visibleEvents = FavoritesFilterHelper.filterEvents(
      events: _allEvents,
      searchQuery: searchQuery,
      filter: selectedFilter,
    );
    notifyListeners();
  }

  Future<bool> removeSavedEvent(String eventId) async {
    if (_eventPendingIds.contains(eventId)) {
      return false;
    }

    _eventPendingIds.add(eventId);
    notifyListeners();

    try {
      await repository.removeSavedEvent(eventId);
      _allEvents = _allEvents.where((event) => event.id != eventId).toList();
      eventsCount = _allEvents.length;
      _applyFilters();
      return true;
    } catch (error) {
      errorMessage = error.toString();
      notifyListeners();
      return false;
    } finally {
      _eventPendingIds.remove(eventId);
      notifyListeners();
    }
  }

  Future<bool> unfollowProducer(String producerId) async {
    if (_producerPendingIds.contains(producerId)) {
      return false;
    }

    _producerPendingIds.add(producerId);
    notifyListeners();

    try {
      await repository.unfollowProducer(producerId);
      _allProducers =
          _allProducers.where((producer) => producer.id != producerId).toList();
      producersCount = _allProducers.length;
      _applyFilters();
      return true;
    } catch (error) {
      errorMessage = error.toString();
      notifyListeners();
      return false;
    } finally {
      _producerPendingIds.remove(producerId);
      notifyListeners();
    }
  }
}
