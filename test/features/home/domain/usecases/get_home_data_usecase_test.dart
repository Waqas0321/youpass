import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youpass/features/home/domain/usecases/get_home_data_usecase.dart';

import '../../mocks/mock_home_repository.dart';
import '../../../../helpers/test_fixtures.dart';

void main() {
  late MockHomeRepository mockHomeRepository;
  late GetHomeDataUseCase getHomeDataUseCase;

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    getHomeDataUseCase = GetHomeDataUseCase(mockHomeRepository);
  });

  test('calls repository getHomeData', () async {
    when(() => mockHomeRepository.getHomeData())
        .thenAnswer((_) async => TestFixtures.testHome);

    final result = await getHomeDataUseCase();

    expect(result, TestFixtures.testHome);
    verify(() => mockHomeRepository.getHomeData()).called(1);
  });
}
