import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youpass/core/constants/app_constants.dart';
import 'package:youpass/features/home/domain/usecases/get_home_feed_usecase.dart';
import 'package:youpass/features/home/presentation/providers/home_provider.dart';

import '../../mocks/mock_home_repository.dart';
import '../../../../helpers/test_fixtures.dart';

void main() {
  late MockHomeRepository mockHomeRepository;
  late HomeProvider homeProvider;

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    homeProvider = HomeProvider(GetHomeFeedUseCase(mockHomeRepository));
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

  test('setHomeFeed updates feed without calling repository', () {
    homeProvider.setHomeFeed(TestFixtures.testHomeFeed);

    expect(homeProvider.status, HomeStatus.loaded);
    expect(homeProvider.homeFeed, TestFixtures.testHomeFeed);
    verifyNever(() => mockHomeRepository.getHomeFeed());
  });

  test('selectCategory updates selected category id', () {
    homeProvider.selectCategory(AppConstants.categoryIdConcerts);

    expect(homeProvider.selectedCategoryId, AppConstants.categoryIdConcerts);
  });

  test('selectCategory does not notify when same category', () {
    homeProvider.selectCategory(AppConstants.categoryIdChile);
    final listener = Listener();
    homeProvider.addListener(listener.call);
    homeProvider.selectCategory(AppConstants.categoryIdChile);

    expect(listener.callCount, 0);
  });
}

class Listener {
  int callCount = 0;

  void call() {
    callCount++;
  }
}
