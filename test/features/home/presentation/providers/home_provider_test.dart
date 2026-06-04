import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youpass/core/constants/app_constants.dart';
import 'package:youpass/features/home/domain/entities/event_category_entity.dart';
import 'package:youpass/features/home/domain/usecases/get_filtered_home_events_usecase.dart';
import 'package:youpass/features/home/domain/usecases/get_home_feed_usecase.dart';
import 'package:youpass/features/home/domain/usecases/toggle_event_favorite_usecase.dart';
import 'package:youpass/features/home/presentation/providers/home_provider.dart';

import '../../mocks/mock_home_repository.dart';
import '../../../../helpers/test_fixtures.dart';

void main() {
  late MockHomeRepository mockHomeRepository;
  late HomeProvider homeProvider;

  setUpAll(() {
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
    homeProvider = HomeProvider(
      getHomeFeedUseCase: GetHomeFeedUseCase(mockHomeRepository),
      getFilteredHomeEventsUseCase:
          GetFilteredHomeEventsUseCase(mockHomeRepository),
      toggleEventFavoriteUseCase: ToggleEventFavoriteUseCase(mockHomeRepository),
    );
  });

  test('loadHomeData sets loaded state with feed', () async {
    when(() => mockHomeRepository.getHomeFeed())
        .thenAnswer((_) async => TestFixtures.testHomeFeed);

    await homeProvider.loadHomeData();

    expect(homeProvider.status, HomeStatus.loaded);
    expect(homeProvider.homeFeed, TestFixtures.testHomeFeed);
    expect(homeProvider.errorMessage, isNull);
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
    verify(() => mockHomeRepository.getFilteredEvents(any())).called(1);
  });

  test('reset clears feed and restores initial state', () async {
    when(() => mockHomeRepository.getHomeFeed())
        .thenAnswer((_) async => TestFixtures.testHomeFeed);

    await homeProvider.loadHomeData();
    homeProvider.selectCategory(AppConstants.categoryIdConcerts);
    homeProvider.reset();

    expect(homeProvider.status, HomeStatus.initial);
    expect(homeProvider.homeFeed, isNull);
    expect(homeProvider.selectedCategoryId, AppConstants.defaultHomeCategoryId);
  });

  test('loadHomeDataIfNeeded skips duplicate fetch when feed is loaded', () async {
    when(() => mockHomeRepository.getHomeFeed())
        .thenAnswer((_) async => TestFixtures.testHomeFeed);

    await homeProvider.loadHomeDataIfNeeded();
    await homeProvider.loadHomeDataIfNeeded();

    verify(() => mockHomeRepository.getHomeFeed()).called(1);
    expect(homeProvider.status, HomeStatus.loaded);
  });

  test('selectCategory does not notify when same category', () async {
    when(() => mockHomeRepository.getHomeFeed())
        .thenAnswer((_) async => TestFixtures.testHomeFeed);

    await homeProvider.loadHomeData();

    final listener = Listener();
    homeProvider.addListener(listener.call);
    await homeProvider.selectCategory(AppConstants.defaultHomeCategoryId);

    expect(listener.callCount, 0);
    verifyNever(() => mockHomeRepository.getFilteredEvents(any()));
  });
}

class Listener {
  int callCount = 0;

  void call() {
    callCount++;
  }
}
