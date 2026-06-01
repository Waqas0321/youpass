import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youpass/features/home/domain/usecases/get_home_data_usecase.dart';
import 'package:youpass/features/home/presentation/providers/home_provider.dart';

import '../../mocks/mock_home_repository.dart';
import '../../../../helpers/test_fixtures.dart';

void main() {
  late MockHomeRepository mockHomeRepository;
  late HomeProvider homeProvider;

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    homeProvider = HomeProvider(GetHomeDataUseCase(mockHomeRepository));
  });

  test('loadHomeData sets loaded state with data', () async {
    when(() => mockHomeRepository.getHomeData())
        .thenAnswer((_) async => TestFixtures.testHome);

    await homeProvider.loadHomeData();

    expect(homeProvider.status, HomeStatus.loaded);
    expect(homeProvider.homeData, TestFixtures.testHome);
    expect(homeProvider.errorMessage, isNull);
  });

  test('loadHomeData sets error state on failure', () async {
    when(() => mockHomeRepository.getHomeData())
        .thenThrow(Exception('Network error'));

    await homeProvider.loadHomeData();

    expect(homeProvider.status, HomeStatus.error);
    expect(homeProvider.homeData, isNull);
    expect(homeProvider.errorMessage, contains('Network error'));
  });
}
