import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:youpass/core/constants/app_constants.dart';
import 'package:youpass/core/network/analytics_api_service.dart';
import 'package:youpass/core/network/api_exception.dart';
import 'package:youpass/core/services/home_search_history_cache.dart';
import 'package:youpass/core/utils/app_logger.dart';
import 'package:youpass/features/events/domain/entities/event_entity.dart';
import 'package:youpass/features/events/domain/entities/home_events_query.dart';
import 'package:youpass/features/home/domain/entities/event_category_entity.dart';
import 'package:youpass/features/home/domain/entities/home_feed_entity.dart';
import 'package:youpass/features/home/domain/entities/home_search_filters_entity.dart';
import 'package:youpass/features/home/domain/usecases/get_filtered_home_events_usecase.dart';
import 'package:youpass/features/home/domain/usecases/get_home_feed_usecase.dart';
import 'package:youpass/features/home/domain/usecases/search_home_events_usecase.dart';
import 'package:youpass/core/services/user_location_service.dart';
import 'package:youpass/features/home/domain/usecases/get_upcoming_home_events_usecase.dart';
import 'package:youpass/features/home/domain/usecases/toggle_event_favorite_usecase.dart';

enum HomeStatus { initial, loading, loaded, error }

class HomeProvider extends ChangeNotifier {
  HomeProvider({
    required this.getHomeFeedUseCase,
    required this.getFilteredHomeEventsUseCase,
    required this.getUpcomingHomeEventsUseCase,
    required this.searchHomeEventsUseCase,
    required this.toggleEventFavoriteUseCase,
    required this.searchHistoryCache,
    required this.userLocationService,
    AnalyticsApiService? analyticsApiService,
  }) : _analyticsApiService = analyticsApiService;

  final GetHomeFeedUseCase getHomeFeedUseCase;
  final GetFilteredHomeEventsUseCase getFilteredHomeEventsUseCase;
  final GetUpcomingHomeEventsUseCase getUpcomingHomeEventsUseCase;
  final SearchHomeEventsUseCase searchHomeEventsUseCase;
  final ToggleEventFavoriteUseCase toggleEventFavoriteUseCase;
  final HomeSearchHistoryCache searchHistoryCache;
  final UserLocationService userLocationService;
  final AnalyticsApiService? _analyticsApiService;

  HomeStatus status = HomeStatus.initial;
  HomeFeedEntity? homeFeed;
  String? errorMessage;
  String? selectedCategoryId;
  String? sessionCountryCode;
  bool isFilteringEvents = false;
  bool showPartyModeBanner = true;
  bool highlightPendingInvitation = false;
  String? highlightedInvitationTitle;
  String? highlightedInvitationId;
  int highlightedInvitationCount = 0;
  bool _trackRegistrationAnalytics = false;
  int? _registrationStartedAtMs;
  String _registrationAnalyticsSource = 'organic';
  final Set<String> _favoritePendingIds = {};

  String searchQuery = '';
  bool isSearchFocused = false;
  bool isSearchLoading = false;
  List<EventEntity> searchResults = const [];
  int searchResultTotal = 0;
  List<String> searchHistory = const [];
  HomeEventsFiltersEntity appliedFilters = HomeEventsFiltersEntity.empty;
  HomeEventsFiltersEntity draftFilters = HomeEventsFiltersEntity.empty;
  int? filterPreviewCount;
  bool isFilterPreviewLoading = false;
  Timer? _searchDebounce;

  List<EventEntity> upcomingEvents = const [];
  int upcomingPage = 1;
  bool upcomingHasMore = false;
  bool isLoadingUpcoming = false;
  bool isLoadingMoreUpcoming = false;
  bool isRefreshingHome = false;
  bool nearMeEnabled = false;
  bool isNearMeLoading = false;
  double? userLatitude;
  double? userLongitude;

  bool get isSearchMode =>
      searchQuery.trim().isNotEmpty || appliedFilters.hasActiveFilters;

  bool get showSearchHistory =>
      isSearchFocused &&
      searchQuery.trim().isEmpty &&
      !appliedFilters.hasActiveFilters;

  List<String> get autocompleteSuggestions {
    final query = searchQuery.trim().toLowerCase();
    if (query.length < 2) {
      return const [];
    }

    final suggestions = <String>{};
    for (final event in searchResults) {
      if (event.title.toLowerCase().contains(query)) {
        suggestions.add(event.title);
      }
      if (event.locationLabel.toLowerCase().contains(query)) {
        suggestions.add(event.locationLabel);
      }
      if (suggestions.length >= 5) {
        break;
      }
    }

    for (final term in searchHistory) {
      if (term.toLowerCase().contains(query)) {
        suggestions.add(term);
      }
      if (suggestions.length >= 5) {
        break;
      }
    }

    return suggestions.take(5).toList();
  }

  Future<void> loadHomeData({String? countryCode}) async {
    status = HomeStatus.loading;
    errorMessage = null;
    notifyListeners();

    try {
      homeFeed = await getHomeFeedUseCase(countryCode: countryCode ?? sessionCountryCode);
      selectedCategoryId = _defaultCategoryId(homeFeed);
      searchHistory = searchHistoryCache.read(
        limit: homeFeed?.searchConfig.historyLimit ?? HomeSearchHistoryCache.defaultLimit,
      );
      status = HomeStatus.loaded;
      _seedUpcomingFromFeed(homeFeed!);
      if (selectedCategoryId != null) {
        await _applyCategoryFilter();
      }
      if (isSearchMode) {
        await _runSearch(saveHistory: false);
      }
    } catch (error) {
      status = HomeStatus.error;
      errorMessage = error.toString();
    }
    notifyListeners();
  }

  Future<void> refreshHome() async {
    if (isRefreshingHome) {
      return;
    }

    isRefreshingHome = true;
    notifyListeners();

    try {
      final feed = await getHomeFeedUseCase(countryCode: sessionCountryCode);
      homeFeed = feed;
      selectedCategoryId = _defaultCategoryId(feed) ?? selectedCategoryId;
      searchHistory = searchHistoryCache.read(
        limit: feed.searchConfig.historyLimit,
      );
      status = HomeStatus.loaded;
      errorMessage = null;

      if (selectedCategoryId != null) {
        final category = _categoryForFilter(feed, selectedCategoryId!);
        if (category != null) {
          final filtered = await getFilteredHomeEventsUseCase(category);
          homeFeed = feed.copyWith(
            carouselEvents: filtered.carouselEvents,
            mainBannerCarouselConfig:
                filtered.mainBannerCarouselConfig ?? feed.mainBannerCarouselConfig,
          );
        }
      }

      await _loadUpcomingEvents(reset: true);
      if (isSearchMode) {
        await _runSearch(saveHistory: false);
      }
    } catch (error) {
      errorMessage = error.toString();
    } finally {
      isRefreshingHome = false;
      notifyListeners();
    }
  }

  Future<void> loadMoreUpcomingIfNeeded() async {
    if (isLoadingUpcoming || isLoadingMoreUpcoming || !upcomingHasMore || isSearchMode) {
      return;
    }

    isLoadingMoreUpcoming = true;
    notifyListeners();

    try {
      final nextPage = upcomingPage + 1;
      final result = await getUpcomingHomeEventsUseCase(
        _buildUpcomingQuery(page: nextPage),
      );
      upcomingEvents = [...upcomingEvents, ...result.events];
      upcomingPage = result.page;
      upcomingHasMore = result.hasMore;
    } catch (error) {
      errorMessage = error.toString();
    } finally {
      isLoadingMoreUpcoming = false;
      notifyListeners();
    }
  }

  Future<void> toggleNearMeFilter() async {
    if (isNearMeLoading) {
      return;
    }

    if (nearMeEnabled) {
      nearMeEnabled = false;
      userLatitude = null;
      userLongitude = null;
      notifyListeners();
      await _loadUpcomingEvents(reset: true);
      return;
    }

    isNearMeLoading = true;
    notifyListeners();

    try {
      final position = await userLocationService.getCurrentPosition();
      nearMeEnabled = true;
      userLatitude = position.latitude;
      userLongitude = position.longitude;
      notifyListeners();
      await _loadUpcomingEvents(reset: true);
    } on UserLocationException catch (error) {
      errorMessage = error.message;
      notifyListeners();
    } catch (error) {
      errorMessage = error.toString();
      notifyListeners();
    } finally {
      isNearMeLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadHomeDataIfNeeded() async {
    if (homeFeed != null && status == HomeStatus.loaded) {
      if (!_hasVisibleEvents(homeFeed!) && !isFilteringEvents && !isSearchMode) {
        await _applyCategoryFilter();
      }
      return;
    }
    if (status == HomeStatus.loading) {
      return;
    }
    await loadHomeData();
  }

  void setSearchFocused(bool focused) {
    if (isSearchFocused == focused) {
      return;
    }
    isSearchFocused = focused;
    notifyListeners();
  }

  void onSearchQueryChanged(String value) {
    searchQuery = value;
    if (value.trim().isEmpty && !appliedFilters.hasActiveFilters) {
      searchResults = const [];
      searchResultTotal = 0;
      isSearchLoading = false;
    }
    notifyListeners();
    _searchDebounce?.cancel();
    final debounceMs = homeFeed?.searchConfig.debounceMs ?? 300;
    _searchDebounce = Timer(Duration(milliseconds: debounceMs), () {
      _runSearch(saveHistory: false);
    });
  }

  Future<void> submitSearch([String? value]) async {
    final term = (value ?? searchQuery).trim();
    if (term.isEmpty) {
      return;
    }
    searchQuery = term;
    notifyListeners();
    await _runSearch(saveHistory: true);
  }

  Future<void> selectHistoryTerm(String term) async {
    searchQuery = term;
    notifyListeners();
    await _runSearch(saveHistory: true);
  }

  Future<void> clearSearchHistory() async {
    await searchHistoryCache.clear();
    searchHistory = const [];
    notifyListeners();
  }

  void clearSearchQuery() {
    searchQuery = '';
    searchResults = const [];
    searchResultTotal = 0;
    notifyListeners();
    if (appliedFilters.hasActiveFilters) {
      _runSearch(saveHistory: false);
    }
  }

  void beginFilterEditing() {
    draftFilters = appliedFilters;
    filterPreviewCount = searchResultTotal;
    notifyListeners();
    _previewDraftFilters();
  }

  void updateDraftFilters(HomeEventsFiltersEntity filters) {
    draftFilters = filters;
    notifyListeners();
    _previewDraftFilters();
  }

  Future<void> applyDraftFilters() async {
    appliedFilters = draftFilters;
    notifyListeners();
    await _runSearch(saveHistory: searchQuery.trim().isNotEmpty);
  }

  Future<void> clearAllFilters() async {
    appliedFilters = HomeEventsFiltersEntity.empty;
    draftFilters = HomeEventsFiltersEntity.empty;
    filterPreviewCount = null;
    notifyListeners();
    if (searchQuery.trim().isNotEmpty || isSearchFocused) {
      await _runSearch(saveHistory: false);
    } else {
      searchResults = const [];
      searchResultTotal = 0;
      notifyListeners();
    }
  }

  Future<void> removeFilterChip(String chipId) async {
    switch (chipId) {
      case 'date':
        appliedFilters = appliedFilters.copyWith(clearDatePreset: true, clearDateFrom: true, clearDateTo: true);
        break;
      case 'city':
        appliedFilters = appliedFilters.copyWith(clearCity: true, clearZone: true);
        break;
      case 'zone':
        appliedFilters = appliedFilters.copyWith(clearZone: true);
        break;
      case 'venue':
        appliedFilters = appliedFilters.copyWith(clearVenueKind: true);
        break;
      case 'price':
        appliedFilters = appliedFilters.copyWith(
          freeOnly: false,
          clearMinPrice: true,
          clearMaxPrice: true,
        );
        break;
      case 'free':
        appliedFilters = appliedFilters.copyWith(freeOnly: false);
        break;
      default:
        return;
    }
    draftFilters = appliedFilters;
    notifyListeners();
    await _runSearch(saveHistory: false);
  }

  List<HomeActiveFilterChip> activeFilterChips({String? freeOnlyLabel, String? customRangeLabel}) {
    final chips = <HomeActiveFilterChip>[];
    final config = homeFeed?.searchConfig ?? HomeSearchFiltersConfigEntity.defaults;
    final freeLabel = freeOnlyLabel ?? 'Free events only';
    final customLabel = customRangeLabel ?? 'Custom range';

    if (appliedFilters.datePreset != null && appliedFilters.datePreset!.isNotEmpty) {
      final label = _labelForOption(config.datePresets, appliedFilters.datePreset!) ??
          appliedFilters.datePreset!;
      chips.add(HomeActiveFilterChip(id: 'date', label: label));
    } else if (appliedFilters.dateFrom != null || appliedFilters.dateTo != null) {
      chips.add(HomeActiveFilterChip(id: 'date', label: customLabel));
    }

    if (appliedFilters.city != null && appliedFilters.city!.isNotEmpty) {
      chips.add(HomeActiveFilterChip(id: 'city', label: appliedFilters.city!));
    }
    if (appliedFilters.zone != null && appliedFilters.zone!.isNotEmpty) {
      chips.add(HomeActiveFilterChip(id: 'zone', label: appliedFilters.zone!));
    }
    if (appliedFilters.venueKind != null && appliedFilters.venueKind!.isNotEmpty) {
      final label = _labelForOption(config.venueTypes, appliedFilters.venueKind!) ??
          appliedFilters.venueKind!;
      chips.add(HomeActiveFilterChip(id: 'venue', label: label));
    }
    if (appliedFilters.freeOnly) {
      chips.add(HomeActiveFilterChip(id: 'free', label: freeLabel));
    } else if (appliedFilters.minPrice != null || appliedFilters.maxPrice != null) {
      final currency = config.priceRange.currency;
      final min = appliedFilters.minPrice?.round() ?? config.priceRange.min.round();
      final max = appliedFilters.maxPrice?.round() ?? config.priceRange.max.round();
      chips.add(HomeActiveFilterChip(id: 'price', label: '$currency $min – $max'));
    }

    return chips;
  }

  String? _labelForOption(List<HomeFilterOptionEntity> options, String id) {
    for (final option in options) {
      if (option.id == id) {
        return option.label;
      }
    }
    return null;
  }

  Future<void> selectCategory(String categoryId) async {
    if (selectedCategoryId == categoryId || homeFeed == null) {
      return;
    }

    selectedCategoryId = categoryId;
    notifyListeners();
    await _applyCategoryFilter();
    if (isSearchMode) {
      await _runSearch(saveHistory: false);
    }
  }

  Future<void> changeSessionCountry(String countryCode) async {
    sessionCountryCode = countryCode.toUpperCase();
    appliedFilters = HomeEventsFiltersEntity.empty;
    draftFilters = HomeEventsFiltersEntity.empty;
    await loadHomeData(countryCode: sessionCountryCode);
  }

  String? resolveSessionCountryCode() {
    final feed = homeFeed;
    if (feed != null) {
      final selectedId = selectedCategoryId;
      if (selectedId != null && selectedId.startsWith('country:')) {
        return selectedId.substring('country:'.length).toUpperCase();
      }

      for (final category in feed.categories) {
        if (category.countryCode != null && category.countryCode!.isNotEmpty) {
          return category.countryCode!.toUpperCase();
        }
      }
    }

    return sessionCountryCode?.toUpperCase();
  }

  bool isCountryCategory(String categoryId) => categoryId.startsWith('country:');

  Future<void> toggleFavorite(String eventId) async {
    final feed = homeFeed;
    if (feed == null || _favoritePendingIds.contains(eventId)) {
      return;
    }

    final current = _findEvent(feed, eventId) ?? _findInList(searchResults, eventId);
    if (current == null) {
      return;
    }

    final nextFavorite = !current.isFavorite;
    _favoritePendingIds.add(eventId);
    final previousUpcoming = upcomingEvents;
    homeFeed = feed.copyWithEventFavorite(
      eventId: eventId,
      isFavorite: nextFavorite,
    );
    searchResults = searchResults
        .map(
          (event) => event.id == eventId
              ? event.copyWith(isFavorite: nextFavorite)
              : event,
        )
        .toList();
    upcomingEvents = upcomingEvents
        .map(
          (event) => event.id == eventId
              ? event.copyWith(isFavorite: nextFavorite)
              : event,
        )
        .toList();
    notifyListeners();

    try {
      await toggleEventFavoriteUseCase(
        eventId: eventId,
        isFavorite: current.isFavorite,
      );
    } on ApiException catch (error) {
      homeFeed = feed;
      upcomingEvents = previousUpcoming;
      searchResults = searchResults
          .map(
            (event) => event.id == eventId
                ? event.copyWith(isFavorite: current.isFavorite)
                : event,
          )
          .toList();
      errorMessage = error.message;
    } catch (error) {
      homeFeed = feed;
      upcomingEvents = previousUpcoming;
      errorMessage = error.toString();
    } finally {
      _favoritePendingIds.remove(eventId);
      notifyListeners();
    }
  }

  bool isFavoritePending(String eventId) {
    return _favoritePendingIds.contains(eventId);
  }

  void beginPostRegistrationSession({
    required int? registrationStartedAtMs,
    String analyticsSource = 'organic',
    bool highlightInvitation = false,
  }) {
    _trackRegistrationAnalytics = true;
    _registrationStartedAtMs = registrationStartedAtMs;
    _registrationAnalyticsSource = analyticsSource;
    highlightPendingInvitation = highlightInvitation;
  }

  Future<HomeFeedEntity?> preloadPostRegistrationFeed() async {
    try {
      return await getHomeFeedUseCase(feedContext: 'post_register');
    } catch (error, stackTrace) {
      AppLogger.error(
        'Failed to preload post-registration home feed',
        tag: 'Home',
        error: error,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  Future<void> applyPreloadedFeed(
    HomeFeedEntity feed, {
    bool? highlightInvitation,
  }) async {
    homeFeed = feed;
    selectedCategoryId = _defaultCategoryId(feed);
    status = HomeStatus.loaded;
    errorMessage = null;
    _seedUpcomingFromFeed(feed);
    _applyPostRegistrationPresentation(
      feed,
      highlightInvitation: highlightInvitation,
    );
    await _applyCategoryFilter();
  }

  void _applyPostRegistrationPresentation(
    HomeFeedEntity feed, {
    bool? highlightInvitation,
  }) {
    if (feed.postRegistration) {
      showPartyModeBanner = feed.partyMode?.bannerVisible ?? false;
    } else if (feed.partyMode != null) {
      showPartyModeBanner = feed.partyMode!.bannerVisible;
    }
    final invitations = feed.invitations;
    highlightPendingInvitation =
        highlightInvitation ?? invitations?.highlight ?? highlightPendingInvitation;
    highlightedInvitationCount = invitations?.pendingCount ?? 0;
    highlightedInvitationTitle = invitations?.featured?.eventTitle;
    highlightedInvitationId = invitations?.featured?.id;
  }

  String? resolveGreetingMessage() {
    final header = homeFeed?.headerGreeting?.trim();
    if (header != null && header.isNotEmpty) {
      return header;
    }

    final message = homeFeed?.greeting?.message.trim();
    if (message != null && message.isNotEmpty) {
      return message;
    }

    return null;
  }

  String? resolveHeaderGreetingFromApi() => resolveGreetingMessage();

  String? resolveUpcomingSectionTitle() {
    final title = homeFeed?.upcomingSectionTitle?.trim();
    if (title != null && title.isNotEmpty) {
      return title;
    }
    return null;
  }

  String resolveSearchEmptyMessage() {
    return homeFeed?.searchConfig.emptyMessage ?? '';
  }

  Future<void> trackRegistrationCompletedIfNeeded() async {
    if (!_trackRegistrationAnalytics || _registrationStartedAtMs == null) {
      return;
    }

    _trackRegistrationAnalytics = false;
    final analytics = _analyticsApiService;
    if (analytics == null) {
      return;
    }

    final elapsed = DateTime.now().millisecondsSinceEpoch - _registrationStartedAtMs!;
    try {
      await analytics.trackRegistrationCompleted(
        source: _registrationAnalyticsSource,
        timeToHomeMs: elapsed,
      );
    } catch (error, stackTrace) {
      AppLogger.error(
        'registration-completed analytics failed',
        tag: 'Analytics',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    super.dispose();
  }

  void reset() {
    status = HomeStatus.initial;
    homeFeed = null;
    errorMessage = null;
    selectedCategoryId = null;
    isFilteringEvents = false;
    showPartyModeBanner = true;
    highlightPendingInvitation = false;
    highlightedInvitationTitle = null;
    highlightedInvitationId = null;
    highlightedInvitationCount = 0;
    _trackRegistrationAnalytics = false;
    _registrationStartedAtMs = null;
    _registrationAnalyticsSource = 'organic';
    _favoritePendingIds.clear();
    searchQuery = '';
    isSearchFocused = false;
    isSearchLoading = false;
    searchResults = const [];
    searchResultTotal = 0;
    appliedFilters = HomeEventsFiltersEntity.empty;
    draftFilters = HomeEventsFiltersEntity.empty;
    filterPreviewCount = null;
    upcomingEvents = const [];
    upcomingPage = 1;
    upcomingHasMore = false;
    isLoadingUpcoming = false;
    isLoadingMoreUpcoming = false;
    isRefreshingHome = false;
    nearMeEnabled = false;
    isNearMeLoading = false;
    userLatitude = null;
    userLongitude = null;
    _searchDebounce?.cancel();
    notifyListeners();
  }

  Future<void> _previewDraftFilters() async {
    isFilterPreviewLoading = true;
    notifyListeners();

    try {
      final result = await searchHomeEventsUseCase(
        _buildEventsQuery(filters: draftFilters, limit: 1),
      );
      filterPreviewCount = result.total;
    } catch (_) {
      filterPreviewCount = null;
    } finally {
      isFilterPreviewLoading = false;
      notifyListeners();
    }
  }

  Future<void> _runSearch({required bool saveHistory}) async {
    final feed = homeFeed;
    if (feed == null) {
      return;
    }

    final trimmed = searchQuery.trim();
    if (trimmed.isEmpty && !appliedFilters.hasActiveFilters) {
      searchResults = const [];
      searchResultTotal = 0;
      isSearchLoading = false;
      notifyListeners();
      return;
    }

    isSearchLoading = true;
    notifyListeners();

    try {
      final result = await searchHomeEventsUseCase(_buildEventsQuery());
      searchResults = result.events;
      searchResultTotal = result.total;
      if (saveHistory && trimmed.isNotEmpty) {
        await searchHistoryCache.addTerm(
          trimmed,
          limit: feed.searchConfig.historyLimit,
        );
        searchHistory = searchHistoryCache.read(limit: feed.searchConfig.historyLimit);
      }
    } catch (error) {
      errorMessage = error.toString();
      searchResults = const [];
      searchResultTotal = 0;
    } finally {
      isSearchLoading = false;
      notifyListeners();
    }
  }

  HomeEventsQuery _buildEventsQuery({
    HomeEventsFiltersEntity? filters,
    int limit = 20,
  }) {
    final feed = homeFeed;
    final category = feed == null
        ? null
        : _categoryForFilter(feed, selectedCategoryId ?? '');

    return HomeEventsQuery(
      countryCode: category?.countryCode ?? resolveSessionCountryCode(),
      eventTypeSlug: category?.eventTypeSlug,
      searchQuery: searchQuery.trim().isEmpty ? null : searchQuery.trim(),
      filters: filters ?? appliedFilters,
      page: 1,
      limit: limit,
    );
  }

  Future<void> _applyCategoryFilter() async {
    final feed = homeFeed;
    if (feed == null) {
      return;
    }

    final category = _categoryForFilter(feed, selectedCategoryId ?? '');
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
        mainBannerCarouselConfig:
            filtered.mainBannerCarouselConfig ?? feed.mainBannerCarouselConfig,
      );
      await _loadUpcomingEvents(reset: true);
    } catch (error) {
      errorMessage = error.toString();
    } finally {
      isFilteringEvents = false;
      notifyListeners();
    }
  }

  bool _hasVisibleEvents(HomeFeedEntity feed) {
    return upcomingEvents.isNotEmpty || feed.carouselEvents.isNotEmpty;
  }

  void _seedUpcomingFromFeed(HomeFeedEntity feed) {
    upcomingEvents = feed.featuredEvents;
    upcomingPage = 1;
    upcomingHasMore = feed.upcomingHasMore;
  }

  Future<void> _loadUpcomingEvents({required bool reset}) async {
    final feed = homeFeed;
    if (feed == null) {
      return;
    }

    if (reset) {
      isLoadingUpcoming = true;
      upcomingPage = 1;
      notifyListeners();
    }

    try {
      final result = await getUpcomingHomeEventsUseCase(_buildUpcomingQuery(page: 1));
      upcomingEvents = result.events;
      upcomingPage = result.page;
      upcomingHasMore = result.hasMore;
      homeFeed = feed.copyWith(featuredEvents: result.events);
    } catch (error) {
      errorMessage = error.toString();
      if (reset) {
        upcomingEvents = const [];
        upcomingHasMore = false;
      }
    } finally {
      isLoadingUpcoming = false;
      notifyListeners();
    }
  }

  HomeEventsQuery _buildUpcomingQuery({required int page}) {
    final feed = homeFeed;
    final category = feed == null
        ? null
        : _categoryForFilter(feed, selectedCategoryId ?? '');

    final bannerIds = feed?.carouselEvents.map((event) => event.id).toList() ?? const [];

    return HomeEventsQuery(
      countryCode: category?.countryCode ?? resolveSessionCountryCode(),
      eventTypeSlug: category?.eventTypeSlug,
      page: page,
      limit: 20,
      nearMe: nearMeEnabled,
      latitude: userLatitude,
      longitude: userLongitude,
      excludeIds: bannerIds,
    );
  }

  String? _defaultCategoryId(HomeFeedEntity? feed) {
    if (feed == null || feed.categories.isEmpty) {
      return null;
    }

    for (final category in feed.categories) {
      if (category.id == AppConstants.categoryIdAll) {
        return category.id;
      }
    }

    return feed.categories.first.id;
  }

  EventCategoryEntity? _categoryForFilter(HomeFeedEntity feed, String categoryId) {
    final category = _findCategory(feed, categoryId);
    if (category == null) {
      return null;
    }

    if (isCountryCategory(category.id)) {
      return category;
    }

    final countryCode = resolveSessionCountryCode();
    if (countryCode == null || countryCode.isEmpty) {
      return category;
    }

    return EventCategoryEntity(
      id: category.id,
      label: category.label,
      icon: category.icon,
      countryCode: countryCode,
      eventTypeSlug: category.id == AppConstants.categoryIdAll
          ? null
          : category.eventTypeSlug,
    );
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
    for (final event in upcomingEvents) {
      if (event.id == eventId) {
        return event;
      }
    }
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

  EventEntity? _findInList(List<EventEntity> events, String eventId) {
    for (final event in events) {
      if (event.id == eventId) {
        return event;
      }
    }
    return null;
  }
}

class HomeActiveFilterChip {
  const HomeActiveFilterChip({required this.id, required this.label});

  final String id;
  final String label;
}
