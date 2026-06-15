import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youpass/core/constants/app_constants.dart';
import 'package:youpass/features/home/domain/entities/event_category_entity.dart';
import 'package:youpass/features/home/domain/usecases/get_filtered_home_events_usecase.dart';
import 'package:youpass/features/home/domain/usecases/get_home_feed_usecase.dart';
import 'package:youpass/features/events/domain/entities/home_events_query.dart';
import 'package:youpass/features/home/domain/usecases/search_home_events_usecase.dart';
import 'package:youpass/features/home/domain/usecases/toggle_event_favorite_usecase.dart';
import 'package:youpass/features/home/presentation/providers/home_provider.dart';

import '../../mocks/mock_home_repository.dart';
import '../../mocks/mock_search_dependencies.dart';
import '../../../../helpers/test_fixtures.dart';

void main() {
  late MockHomeRepository mockHomeRepository;
  late MockSearchHomeEventsUseCase mockSearchHomeEventsUseCase;
  late MockGetUpcomingHomeEventsUseCase mockGetUpcomingHomeEventsUseCase;
  late MockHomeSearchHistoryCache mockSearchHistoryCache;
  late MockUserLocationService mockUserLocationService;
  late HomeProvider homeProvider;

  UpcomingEventsPageResult upcomingResult() => UpcomingEventsPageResult(
        events: TestFixtures.testHomeFeed.featuredEvents,
        hasMore: false,
        page: 1,
        total: TestFixtures.testHomeFeed.featuredEvents.length,
      );

  setUpAll(() {
    registerSearchFallbacks();
    registerFallbackValue(
      const EventCategoryEntity(
        id: AppConstants.categoryIdChile,
        label: 'Chile',
        icon: Icons.location_on_outlined,
        countryCode: 'CL',
      ),
    );
  });

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    mockSearchHomeEventsUseCase = MockSearchHomeEventsUseCase();
    mockGetUpcomingHomeEventsUseCase = MockGetUpcomingHomeEventsUseCase();
    mockSearchHistoryCache = MockHomeSearchHistoryCache();
    mockUserLocationService = MockUserLocationService();
    when(() => mockSearchHistoryCache.read(limit: any(named: 'limit')))
        .thenReturn(const []);
    when(() => mockGetUpcomingHomeEventsUseCase(any()))
        .thenAnswer((_) async => upcomingResult());
    homeProvider = HomeProvider(
      getHomeFeedUseCase: GetHomeFeedUseCase(mockHomeRepository),
      getFilteredHomeEventsUseCase:
          GetFilteredHomeEventsUseCase(mockHomeRepository),
      getUpcomingHomeEventsUseCase: mockGetUpcomingHomeEventsUseCase,
      searchHomeEventsUseCase: mockSearchHomeEventsUseCase,
      toggleEventFavoriteUseCase: ToggleEventFavoriteUseCase(mockHomeRepository),
      searchHistoryCache: mockSearchHistoryCache,
      userLocationService: mockUserLocationService,
    );
  });

  test('loadHomeData sets loaded state with feed', () async {
    when(() => mockHomeRepository.getHomeFeed())
        .thenAnswer((_) async => TestFixtures.testHomeFeed);
    when(() => mockHomeRepository.getFilteredEvents(any())).thenAnswer(
      (_) async => TestFixtures.testFilteredHomeEvents,
    );

    await homeProvider.loadHomeData();

    expect(homeProvider.status, HomeStatus.loaded);
    expect(homeProvider.upcomingEvents,
        TestFixtures.testHomeFeed.featuredEvents);
    expect(homeProvider.homeFeed?.carouselEvents,
        TestFixtures.testHomeFeed.carouselEvents);
    expect(homeProvider.errorMessage, isNull);
    verify(() => mockHomeRepository.getFilteredEvents(any())).called(1);
    verify(() => mockGetUpcomingHomeEventsUseCase(any())).called(1);
  });

  test('loadHomeData sets error state on failure', () async {
    when(() => mockHomeRepository.getHomeFeed())
        .thenThrow(Exception('Network error'));

    await homeProvider.loadHomeData();

    expect(homeProvider.status, HomeStatus.error);
    expect(homeProvider.homeFeed, isNull);
    expect(homeProvider.errorMessage, contains('Network error'));
  });

  test('selectCategory updates selected category id and reloads events', () async {
    when(() => mockHomeRepository.getHomeFeed())
        .thenAnswer((_) async => TestFixtures.testHomeFeed);
    when(() => mockHomeRepository.getFilteredEvents(any())).thenAnswer(
      (_) async => TestFixtures.testFilteredHomeEvents,
    );

    await homeProvider.loadHomeData();
    await homeProvider.selectCategory(AppConstants.categoryIdConcerts);

    expect(homeProvider.selectedCategoryId, AppConstants.categoryIdConcerts);
    verify(() => mockHomeRepository.getFilteredEvents(any())).called(2);
    verify(() => mockGetUpcomingHomeEventsUseCase(any())).called(2);
  });

  test('reset clears feed and restores initial state', () async {
    when(() => mockHomeRepository.getHomeFeed())
        .thenAnswer((_) async => TestFixtures.testHomeFeed);

    await homeProvider.loadHomeData();
    homeProvider.selectCategory(AppConstants.categoryIdConcerts);
    homeProvider.reset();

    expect(homeProvider.status, HomeStatus.initial);
    expect(homeProvider.homeFeed, isNull);
    expect(homeProvider.selectedCategoryId, isNull);
    expect(homeProvider.upcomingEvents, isEmpty);
  });

  test('loadHomeDataIfNeeded skips duplicate fetch when feed is loaded', () async {
    when(() => mockHomeRepository.getHomeFeed())
        .thenAnswer((_) async => TestFixtures.testHomeFeed);
    when(() => mockHomeRepository.getFilteredEvents(any())).thenAnswer(
      (_) async => TestFixtures.testFilteredHomeEvents,
    );

    await homeProvider.loadHomeDataIfNeeded();
    await homeProvider.loadHomeDataIfNeeded();

    verify(() => mockHomeRepository.getHomeFeed()).called(1);
    verify(() => mockHomeRepository.getFilteredEvents(any())).called(1);
    expect(homeProvider.status, HomeStatus.loaded);
  });

  test('selectCategory does not notify when same category', () async {
    when(() => mockHomeRepository.getHomeFeed())
        .thenAnswer((_) async => TestFixtures.testHomeFeed);
    when(() => mockHomeRepository.getFilteredEvents(any())).thenAnswer(
      (_) async => TestFixtures.testFilteredHomeEvents,
    );

    await homeProvider.loadHomeData();

    final listener = Listener();
    homeProvider.addListener(listener.call);
    await homeProvider.selectCategory(AppConstants.categoryIdAll);

    expect(listener.callCount, 0);
    verify(() => mockHomeRepository.getFilteredEvents(any())).called(1);
  });
  test('clearing search query exits search mode and restores default listing', () async {
    when(() => mockHomeRepository.getHomeFeed())
        .thenAnswer((_) async => TestFixtures.testHomeFeed);
    when(() => mockHomeRepository.getFilteredEvents(any())).thenAnswer(
      (_) async => TestFixtures.testFilteredHomeEvents,
    );
    when(() => mockSearchHomeEventsUseCase(any())).thenAnswer(
      (_) async => const EventsQueryResult(events: [], total: 0),
    );

    await homeProvider.loadHomeData();
    homeProvider.isSearchFocused = true;
    homeProvider.onSearchQueryChanged('rock');

    await Future<void>.delayed(const Duration(milliseconds: 350));

    expect(homeProvider.isSearchMode, isTrue);

    homeProvider.onSearchQueryChanged('');

    expect(homeProvider.isSearchMode, isFalse);
    expect(homeProvider.searchResults, isEmpty);
    expect(homeProvider.showSearchHistory, isTrue);
    expect(homeProvider.upcomingEvents, isNotEmpty);
  });
}

class Listener {
  int callCount = 0;

  void call() {
    callCount++;
  }
}
