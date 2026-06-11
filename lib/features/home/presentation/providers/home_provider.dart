import 'package:flutter/foundation.dart';
import 'package:youpass/core/constants/app_constants.dart';
import 'package:youpass/core/network/analytics_api_service.dart';
import 'package:youpass/core/network/api_exception.dart';
import 'package:youpass/core/utils/app_logger.dart';
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
    AnalyticsApiService? analyticsApiService,
  }) : _analyticsApiService = analyticsApiService;

  final GetHomeFeedUseCase getHomeFeedUseCase;
  final GetFilteredHomeEventsUseCase getFilteredHomeEventsUseCase;
  final ToggleEventFavoriteUseCase toggleEventFavoriteUseCase;
  final AnalyticsApiService? _analyticsApiService;

  HomeStatus status = HomeStatus.initial;
  HomeFeedEntity? homeFeed;
  String? errorMessage;
  String selectedCategoryId = AppConstants.defaultHomeCategoryId;
  bool isFilteringEvents = false;
  bool showPartyModeBanner = true;
  bool highlightPendingInvitation = false;
  String? highlightedInvitationTitle;
  int highlightedInvitationCount = 0;
  bool _trackRegistrationAnalytics = false;
  int? _registrationStartedAtMs;
  String _registrationAnalyticsSource = 'organic';
  final Set<String> _favoritePendingIds = {};

  Future<void> loadHomeData() async {
    status = HomeStatus.loading;
    errorMessage = null;
    notifyListeners();

    try {
      homeFeed = await getHomeFeedUseCase();
      selectedCategoryId = AppConstants.defaultHomeCategoryId;
      status = HomeStatus.loaded;
      await _applyCategoryFilter();
    } catch (error) {
      status = HomeStatus.error;
      errorMessage = error.toString();
    }
    notifyListeners();
  }

  Future<void> loadHomeDataIfNeeded() async {
    if (homeFeed != null && status == HomeStatus.loaded) {
      if (!_hasVisibleEvents(homeFeed!) && !isFilteringEvents) {
        await _applyCategoryFilter();
      }
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
    selectedCategoryId = AppConstants.defaultHomeCategoryId;
    status = HomeStatus.loaded;
    errorMessage = null;
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

  /// Pre-formatted header greeting from API (`layout.header.greeting` or legacy `greeting.message`).
  String? resolveHeaderGreetingFromApi() => resolveGreetingMessage();

  String? resolveUpcomingSectionTitle() {
    final title = homeFeed?.upcomingSectionTitle?.trim();
    if (title != null && title.isNotEmpty) {
      return title;
    }
    return null;
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

  void reset() {
    status = HomeStatus.initial;
    homeFeed = null;
    errorMessage = null;
    selectedCategoryId = AppConstants.defaultHomeCategoryId;
    isFilteringEvents = false;
    showPartyModeBanner = true;
    highlightPendingInvitation = false;
    highlightedInvitationTitle = null;
    highlightedInvitationCount = 0;
    _trackRegistrationAnalytics = false;
    _registrationStartedAtMs = null;
    _registrationAnalyticsSource = 'organic';
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

  bool _hasVisibleEvents(HomeFeedEntity feed) {
    return feed.featuredEvents.isNotEmpty || feed.carouselEvents.isNotEmpty;
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
