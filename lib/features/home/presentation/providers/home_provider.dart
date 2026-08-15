import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:youpass/core/network/analytics_api_service.dart';
import 'package:youpass/core/network/api_exception.dart';
import 'package:youpass/core/services/home_search_history_cache.dart';
import 'package:youpass/core/utils/app_logger.dart';
import 'package:youpass/features/events/domain/entities/event_entity.dart';
import 'package:youpass/features/events/domain/entities/home_events_query.dart';
import 'package:youpass/features/home/domain/entities/event_category_entity.dart';
import 'package:youpass/features/home/domain/entities/home_feed_entity.dart';
import 'package:youpass/features/home/domain/entities/home_feed_meta_entity.dart';
import 'package:youpass/features/home/domain/entities/home_search_filters_entity.dart';
import 'package:youpass/features/home/domain/usecases/get_filtered_home_events_usecase.dart';
import 'package:youpass/features/home/domain/usecases/get_home_feed_usecase.dart';
import 'package:youpass/features/home/domain/usecases/search_home_events_usecase.dart';
import 'package:youpass/core/services/user_location_service.dart';
import 'package:youpass/features/home/domain/usecases/get_upcoming_home_events_usecase.dart';
import 'package:youpass/features/home/domain/usecases/toggle_event_favorite_usecase.dart';
import 'package:youpass/core/theme/presentation/providers/app_theme_provider.dart';
import 'package:youpass/features/home/presentation/utils/home_country_category_helper.dart';

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
  bool showPartyModeBanner = false;
  bool partyModeEligible = false;
  String? get partyModeEventId => homeFeed?.partyMode?.eventId;
  String? get partyModeEventTitle => homeFeed?.partyMode?.eventTitle;
  List<HomePartyModeEligibleEventEntity> get partyModeEligibleEvents =>
      homeFeed?.partyMode?.eligibleEvents ?? const [];
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
  Timer? _filterPreviewDebounce;
  int _filterPreviewGeneration = 0;

  List<EventEntity> upcomingEvents = const [];
  int upcomingPage = 1;
  bool upcomingHasMore = false;
  bool isLoadingUpcoming = false;
  bool isLoadingMoreUpcoming = false;
  bool isRefreshingHome = false;
  bool nearMeEnabled = false;
  bool draftNearMeEnabled = false;
  bool isNearMeLoading = false;
  double? userLatitude;
  double? userLongitude;
  double? draftLatitude;
  double? draftLongitude;

  bool get hasActiveLocationContext =>
      nearMeEnabled ||
      (appliedFilters.city != null && appliedFilters.city!.trim().isNotEmpty);

  String get typedLocationQuery => appliedFilters.city?.trim() ?? '';

  List<String> locationSuggestionsFor(String query) {
    final normalized = query.trim().toLowerCase();
    final suggestions = <String>{};

    final configCities = homeFeed?.searchConfig.cities ?? const [];
    for (final city in configCities) {
      final label = city.label.trim();
      if (label.isEmpty) {
        continue;
      }
      if (normalized.isEmpty || label.toLowerCase().contains(normalized)) {
        suggestions.add(label);
      }
    }

    for (final event in [...upcomingEvents, ...searchResults]) {
      final location = event.locationLabel.trim();
      if (location.isEmpty) {
        continue;
      }
      final cityPart = location.contains(',')
          ? location.split(',').last.trim()
          : location;
      if (cityPart.isEmpty) {
        continue;
      }
      if (normalized.isEmpty || cityPart.toLowerCase().contains(normalized)) {
        suggestions.add(cityPart);
      }
    }

    final sorted = suggestions.toList()..sort();
    return sorted.take(8).toList();
  }

  bool isDraftNearMeLoading = false;

  HomeSearchFiltersConfigEntity get _searchConfig =>
      homeFeed?.searchConfig ?? HomeSearchFiltersConfigEntity.defaults;

  bool get isSearchMode =>
      searchQuery.trim().isNotEmpty || _appliedHasActiveSelections();

  bool get showSearchHistory =>
      isSearchFocused &&
      searchQuery.trim().isEmpty &&
      !_appliedHasActiveSelections();

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
      final resolvedCountryCode = (countryCode ?? sessionCountryCode)?.toUpperCase();
      homeFeed = await _fetchHomeFeed(countryCode: resolvedCountryCode);
      homeFeed = _applySessionCountryToFeed(homeFeed, resolvedCountryCode);
      _ensureCountryCategorySelected(homeFeed, forceDefault: true);
      searchHistory = searchHistoryCache.read(
        limit: homeFeed?.searchConfig.historyLimit ?? HomeSearchHistoryCache.defaultLimit,
      );
      status = HomeStatus.loaded;
      _seedUpcomingFromFeed(homeFeed!);
      _applyPartyModePresentation(homeFeed!);
      if (_shouldRefetchForSelectedCategory()) {
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
      final resolvedCountryCode = sessionCountryCode?.toUpperCase();
      final feed = await _fetchHomeFeed(countryCode: resolvedCountryCode);
      homeFeed = _applySessionCountryToFeed(feed, resolvedCountryCode);
      _ensureCountryCategorySelected(homeFeed, forceDefault: true);
      searchHistory = searchHistoryCache.read(
        limit: homeFeed!.searchConfig.historyLimit,
      );
      status = HomeStatus.loaded;
      errorMessage = null;
      _applyPartyModePresentation(homeFeed!);

      if (selectedCategoryId != null && homeFeed != null) {
        final category = _categoryForFilter(homeFeed!, selectedCategoryId!);
        if (category != null) {
          final filtered = await getFilteredHomeEventsUseCase(category);
          homeFeed = homeFeed!.copyWith(
            carouselEvents: filtered.carouselEvents,
            mainBannerCarouselConfig:
                filtered.mainBannerCarouselConfig ?? homeFeed!.mainBannerCarouselConfig,
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
    if (nearMeEnabled) {
      await clearLocationContext();
      return;
    }
    await enableNearMeLocation();
  }

  Future<void> enableNearMeLocation() async {
    if (isNearMeLoading) {
      return;
    }

    isNearMeLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final position = await userLocationService.getCurrentPosition();
      nearMeEnabled = true;
      userLatitude = position.latitude;
      userLongitude = position.longitude;
      appliedFilters = appliedFilters.copyWith(clearCity: true, clearZone: true);
      draftFilters = appliedFilters;
      draftNearMeEnabled = true;
      draftLatitude = userLatitude;
      draftLongitude = userLongitude;
      notifyListeners();

      if (searchQuery.trim().isNotEmpty || _appliedHasActiveSelections()) {
        await _runSearch(saveHistory: false);
      } else {
        await _loadUpcomingEvents(reset: true);
      }
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

  Future<void> applyTypedCityLocation(String city) async {
    final trimmed = city.trim();
    if (trimmed.isEmpty) {
      return;
    }

    nearMeEnabled = false;
    userLatitude = null;
    userLongitude = null;
    draftNearMeEnabled = false;
    draftLatitude = null;
    draftLongitude = null;
    appliedFilters = appliedFilters.copyWith(
      city: trimmed,
      clearZone: true,
    );
    draftFilters = appliedFilters;
    notifyListeners();

    if (searchQuery.trim().isNotEmpty || _appliedHasActiveSelections()) {
      await _runSearch(saveHistory: false);
    } else {
      await _loadUpcomingEvents(reset: true);
    }
  }

  Future<void> clearLocationContext() async {
    nearMeEnabled = false;
    userLatitude = null;
    userLongitude = null;
    draftNearMeEnabled = false;
    draftLatitude = null;
    draftLongitude = null;
    appliedFilters = appliedFilters.copyWith(clearCity: true, clearZone: true);
    draftFilters = appliedFilters;
    notifyListeners();

    if (searchQuery.trim().isNotEmpty || _appliedHasActiveSelections()) {
      await _runSearch(saveHistory: false);
    } else {
      await _loadUpcomingEvents(reset: true);
    }
  }

  Future<void> loadHomeDataIfNeeded() async {
    if (homeFeed != null && status == HomeStatus.loaded) {
      _ensureCountryCategorySelected(homeFeed);
      await refreshPartyModeEligibility();
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
    if (value.trim().isEmpty && !_appliedHasActiveSelections()) {
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
    if (_appliedHasActiveSelections()) {
      _runSearch(saveHistory: false);
    }
  }

  void beginFilterEditing() {
    draftFilters = _normalizePriceFilters(appliedFilters);
    draftNearMeEnabled = nearMeEnabled;
    draftLatitude = userLatitude;
    draftLongitude = userLongitude;
    filterPreviewCount = null;
    notifyListeners();
    _refreshDraftPreview();
  }

  void updateDraftFilters(HomeEventsFiltersEntity filters) {
    draftFilters = _normalizePriceFilters(filters);
    notifyListeners();
    _refreshDraftPreview();
  }

  Future<void> applyDraftFilters() async {
    appliedFilters = draftFilters;
    nearMeEnabled = draftNearMeEnabled;
    userLatitude = draftNearMeEnabled ? draftLatitude : null;
    userLongitude = draftNearMeEnabled ? draftLongitude : null;
    filterPreviewCount = null;
    notifyListeners();

    if (searchQuery.trim().isNotEmpty || _appliedHasActiveSelections()) {
      await _runSearch(saveHistory: searchQuery.trim().isNotEmpty);
      return;
    }

    searchResults = const [];
    searchResultTotal = 0;
    await _loadUpcomingEvents(reset: true);
  }

  Future<void> clearAllFilters() async {
    appliedFilters = HomeEventsFiltersEntity.empty;
    draftFilters = HomeEventsFiltersEntity.empty;
    nearMeEnabled = false;
    draftNearMeEnabled = false;
    userLatitude = null;
    userLongitude = null;
    draftLatitude = null;
    draftLongitude = null;
    filterPreviewCount = null;
    notifyListeners();

    if (searchQuery.trim().isNotEmpty || isSearchFocused) {
      await _runSearch(saveHistory: false);
      return;
    }

    searchResults = const [];
    searchResultTotal = 0;
    await _loadUpcomingEvents(reset: true);
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
      case 'near_me':
        nearMeEnabled = false;
        userLatitude = null;
        userLongitude = null;
        break;
      default:
        return;
    }
    draftFilters = appliedFilters;
    draftNearMeEnabled = nearMeEnabled;
    draftLatitude = userLatitude;
    draftLongitude = userLongitude;
    notifyListeners();
    if (_appliedHasActiveSelections() || searchQuery.trim().isNotEmpty) {
      await _runSearch(saveHistory: false);
    } else {
      await _loadUpcomingEvents(reset: true);
    }
  }

  List<HomeActiveFilterChip> activeFilterChips({
    String? freeOnlyLabel,
    String? customRangeLabel,
    String? nearMeLabel,
  }) {
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
    } else if (_isPriceFilterActive(appliedFilters)) {
      final currency = config.priceRange.currency;
      final min = appliedFilters.minPrice?.round() ?? config.priceRange.min.round();
      final max = appliedFilters.maxPrice?.round() ?? config.priceRange.max.round();
      chips.add(HomeActiveFilterChip(id: 'price', label: '$currency $min – $max'));
    }

    if (nearMeEnabled) {
      chips.add(HomeActiveFilterChip(
        id: 'near_me',
        label: nearMeLabel ?? 'Near me',
      ));
    }

    return chips;
  }

  bool get draftHasActiveSelections => _draftHasActiveSelections();

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
    final normalized = countryCode.toUpperCase();
    sessionCountryCode = normalized;
    selectedCategoryId = 'country:$normalized';
    appliedFilters = HomeEventsFiltersEntity.empty;
    draftFilters = HomeEventsFiltersEntity.empty;
    await loadHomeData(countryCode: normalized);
  }

  void seedSessionCountry(String? countryCode) {
    if (sessionCountryCode != null && sessionCountryCode!.isNotEmpty) {
      return;
    }

    final normalized = countryCode?.trim().toUpperCase();
    if (normalized == null || normalized.isEmpty) {
      return;
    }

    sessionCountryCode = normalized;
    selectedCategoryId = 'country:$normalized';
  }

  String? resolveSessionCountryCode() {
    if (sessionCountryCode != null && sessionCountryCode!.isNotEmpty) {
      return sessionCountryCode!.toUpperCase();
    }

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

    return null;
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
      return _fetchHomeFeed(feedContext: 'post_register');
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
    homeFeed = _applySessionCountryToFeed(homeFeed, sessionCountryCode);
    _ensureCountryCategorySelected(homeFeed, forceDefault: true);
    status = HomeStatus.loaded;
    errorMessage = null;
    _seedUpcomingFromFeed(feed);
    _applyPostRegistrationPresentation(
      feed,
      highlightInvitation: highlightInvitation,
    );
    await refreshPartyModeEligibility();
    if (_shouldRefetchForSelectedCategory()) {
      await _applyCategoryFilter();
    }
  }

  void _applyPostRegistrationPresentation(
    HomeFeedEntity feed, {
    bool? highlightInvitation,
  }) {
    _applyPartyModePresentation(feed);
    final invitations = feed.invitations;
    highlightPendingInvitation =
        highlightInvitation ?? invitations?.highlight ?? highlightPendingInvitation;
    highlightedInvitationCount = invitations?.pendingCount ?? 0;
    highlightedInvitationTitle = invitations?.featured?.eventTitle;
    highlightedInvitationId = invitations?.featured?.id;
  }

  void _applyPartyModePresentation(HomeFeedEntity feed) {
    final partyMode = feed.partyMode;
    partyModeEligible = partyMode?.bannerVisible ?? false;
    showPartyModeBanner = partyModeEligible;
  }

  Future<void> syncPartyModeTheme(AppThemeProvider themeProvider) async {
    // Visual Party Mode is user-toggled from the home header. Eligibility
    // still gates party features without forcing the theme off.
  }

  Future<void> refreshPartyModeEligibility() async {
    if (homeFeed == null) {
      return;
    }

    try {
      final coords = await _resolvePartyModeCoordinates();
      final feed = await getHomeFeedUseCase.getHomeFeed(
        countryCode: sessionCountryCode?.toUpperCase(),
        lat: coords.lat,
        lng: coords.lng,
      );
      homeFeed = homeFeed!.copyWith(partyMode: feed.partyMode);
      _applyPartyModePresentation(homeFeed!);
      notifyListeners();
    } catch (_) {
      // Keep the current feed if the party-mode refresh fails.
    }
  }

  Future<HomeFeedEntity> _fetchHomeFeed({
    String? countryCode,
    String? feedContext,
  }) async {
    final coords = await _resolvePartyModeCoordinates();
    return getHomeFeedUseCase.getHomeFeed(
      countryCode: countryCode,
      feedContext: feedContext,
      lat: coords.lat,
      lng: coords.lng,
    );
  }

  Future<({double? lat, double? lng})> _resolvePartyModeCoordinates() async {
    try {
      final position = await userLocationService.getCurrentPosition();
      return (lat: position.latitude, lng: position.longitude);
    } catch (_) {
      return (lat: null, lng: null);
    }
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

  String resolveSelectedCategoryId() {
    final feed = homeFeed;
    final current = selectedCategoryId;
    if (feed == null) {
      return current ?? '';
    }

    if (current == null ||
        current == 'all' ||
        _findCategory(feed, current) == null) {
      return _defaultCategoryId(feed) ?? '';
    }

    return current;
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
    showPartyModeBanner = false;
    partyModeEligible = false;
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
    draftNearMeEnabled = false;
    isNearMeLoading = false;
    isDraftNearMeLoading = false;
    userLatitude = null;
    userLongitude = null;
    draftLatitude = null;
    draftLongitude = null;
    _searchDebounce?.cancel();
    _filterPreviewDebounce?.cancel();
    notifyListeners();
  }

  Future<void> toggleDraftNearMeFilter() async {
    if (isDraftNearMeLoading) {
      return;
    }

    if (draftNearMeEnabled) {
      draftNearMeEnabled = false;
      draftLatitude = null;
      draftLongitude = null;
      notifyListeners();
      _refreshDraftPreview();
      return;
    }

    isDraftNearMeLoading = true;
    notifyListeners();

    try {
      final position = await userLocationService.getCurrentPosition();
      draftNearMeEnabled = true;
      draftLatitude = position.latitude;
      draftLongitude = position.longitude;
      notifyListeners();
      _refreshDraftPreview();
    } on UserLocationException catch (error) {
      errorMessage = error.message;
      notifyListeners();
    } catch (error) {
      errorMessage = error.toString();
      notifyListeners();
    } finally {
      isDraftNearMeLoading = false;
      notifyListeners();
    }
  }

  void _refreshDraftPreview() {
    if (!_draftHasActiveSelections()) {
      _filterPreviewDebounce?.cancel();
      filterPreviewCount = null;
      isFilterPreviewLoading = false;
      notifyListeners();
      return;
    }

    _filterPreviewDebounce?.cancel();
    _filterPreviewDebounce = Timer(
      Duration(milliseconds: _searchConfig.debounceMs),
      _previewDraftFilters,
    );
  }

  Future<void> _previewDraftFilters() async {
    final generation = ++_filterPreviewGeneration;
    isFilterPreviewLoading = true;
    notifyListeners();

    try {
      final result = await searchHomeEventsUseCase(
        _buildEventsQuery(
          filters: draftFilters,
          limit: 1,
          useDraftLocation: true,
        ),
      );
      if (generation == _filterPreviewGeneration) {
        filterPreviewCount = result.total;
      }
    } catch (_) {
      if (generation == _filterPreviewGeneration) {
        filterPreviewCount = null;
      }
    }

    if (generation == _filterPreviewGeneration) {
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
    if (trimmed.isEmpty && !_appliedHasActiveSelections()) {
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
    bool useDraftLocation = false,
  }) {
    final feed = homeFeed;
    final category = feed == null
        ? null
        : _categoryForFilter(feed, selectedCategoryId ?? '');

    final useNearMe = useDraftLocation ? draftNearMeEnabled : nearMeEnabled;
    final latitude = useDraftLocation ? draftLatitude : userLatitude;
    final longitude = useDraftLocation ? draftLongitude : userLongitude;

    return HomeEventsQuery(
      countryCode: category?.countryCode ?? resolveSessionCountryCode(),
      eventTypeSlug: category?.eventTypeSlug,
      searchQuery: searchQuery.trim().isEmpty ? null : searchQuery.trim(),
      filters: filters ?? appliedFilters,
      page: 1,
      limit: limit,
      nearMe: useNearMe,
      latitude: latitude,
      longitude: longitude,
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
      final result = await getUpcomingHomeEventsUseCase(
        _buildUpcomingQuery(page: reset ? 1 : upcomingPage),
      );
      upcomingEvents = reset ? result.events : [...upcomingEvents, ...result.events];
      upcomingPage = result.page;
      upcomingHasMore = result.hasMore;
      if (reset) {
        homeFeed = feed.copyWith(featuredEvents: result.events);
      }
    } catch (error) {
      errorMessage = error.toString();
      if (reset) {
        upcomingEvents = const [];
        upcomingHasMore = false;
      }
    } finally {
      isLoadingUpcoming = false;
      isLoadingMoreUpcoming = false;
      notifyListeners();
    }
  }

  bool _shouldRefetchForSelectedCategory() {
    final categoryId = selectedCategoryId;
    if (categoryId == null || categoryId.isEmpty) {
      return false;
    }

    return !isCountryCategory(categoryId);
  }

  HomeEventsQuery _buildUpcomingQuery({required int page}) {
    final feed = homeFeed;
    final category = feed == null
        ? null
        : _categoryForFilter(feed, selectedCategoryId ?? '');

    return HomeEventsQuery(
      countryCode: category?.countryCode ?? resolveSessionCountryCode(),
      eventTypeSlug: category?.eventTypeSlug,
      page: page,
      limit: 20,
      filters: appliedFilters,
      nearMe: nearMeEnabled,
      latitude: userLatitude,
      longitude: userLongitude,
    );
  }

  String? _defaultCategoryId(HomeFeedEntity? feed) {
    if (feed == null || feed.categories.isEmpty) {
      return null;
    }

    for (final category in feed.categories) {
      if (isCountryCategory(category.id)) {
        return category.id;
      }
    }

    return feed.categories.first.id;
  }

  void _ensureCountryCategorySelected(
    HomeFeedEntity? feed, {
    bool forceDefault = false,
  }) {
    final countryId = sessionCountryCode == null || sessionCountryCode!.isEmpty
        ? _defaultCategoryId(feed)
        : 'country:${sessionCountryCode!.toUpperCase()}';
    if (countryId == null) {
      return;
    }

    final current = selectedCategoryId;
    if (forceDefault ||
        current == null ||
        current == 'all' ||
        (feed != null && _findCategory(feed, current) == null)) {
      selectedCategoryId = countryId;
    }
  }

  HomeFeedEntity? _applySessionCountryToFeed(
    HomeFeedEntity? feed,
    String? countryCode,
  ) {
    if (feed == null) {
      return null;
    }

    final normalized = countryCode?.trim().toUpperCase();
    if (normalized == null || normalized.isEmpty) {
      String? fromChip;
      for (final category in feed.categories) {
        if (isCountryCategory(category.id) &&
            category.countryCode != null &&
            category.countryCode!.isNotEmpty) {
          fromChip = category.countryCode!.toUpperCase();
          break;
        }
      }
      if (fromChip != null) {
        sessionCountryCode = fromChip;
        return HomeCountryCategoryHelper.applySessionCountry(feed, fromChip);
      }
      return feed;
    }

    sessionCountryCode = normalized;
    return HomeCountryCategoryHelper.applySessionCountry(feed, normalized);
  }

  EventCategoryEntity? _categoryForFilter(HomeFeedEntity feed, String categoryId) {
    final category = _findCategory(feed, categoryId);
    if (category == null) {
      return null;
    }

    if (isCountryCategory(category.id)) {
      final code = sessionCountryCode ?? category.countryCode;
      if (code != null && code.isNotEmpty) {
        return HomeCountryCategoryHelper.fromCountryCode(code);
      }
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
      leadingEmoji: category.leadingEmoji,
      showLeadingIcon: category.showLeadingIcon,
      countryCode: countryCode,
      eventTypeSlug: category.eventTypeSlug,
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

  bool _appliedHasActiveSelections() {
    return appliedFilters.hasActiveFiltersFor(_searchConfig.priceRange) ||
        nearMeEnabled;
  }

  bool _draftHasActiveSelections() {
    return draftFilters.hasActiveFiltersFor(_searchConfig.priceRange) ||
        draftNearMeEnabled;
  }

  bool _isPriceFilterActive(HomeEventsFiltersEntity filters) {
    return filters.hasActiveFiltersFor(_searchConfig.priceRange) &&
        !filters.freeOnly &&
        ((filters.minPrice != null && filters.minPrice! > _searchConfig.priceRange.min) ||
            (filters.maxPrice != null &&
                filters.maxPrice! < _searchConfig.priceRange.max));
  }

  HomeEventsFiltersEntity _normalizePriceFilters(HomeEventsFiltersEntity filters) {
    if (_isPriceFilterActive(filters)) {
      return filters;
    }
    return filters.copyWith(clearMinPrice: true, clearMaxPrice: true);
  }
}

class HomeActiveFilterChip {
  const HomeActiveFilterChip({required this.id, required this.label});

  final String id;
  final String label;
}
