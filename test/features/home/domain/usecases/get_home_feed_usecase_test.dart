import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youpass/features/home/domain/usecases/get_home_feed_usecase.dart';

import '../../mocks/mock_home_repository.dart';
import '../../../../helpers/test_fixtures.dart';

void main() {
  late MockHomeRepository mockHomeRepository;
  late GetHomeFeedUseCase getHomeFeedUseCase;

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    getHomeFeedUseCase = GetHomeFeedUseCase(mockHomeRepository);
  });

  test('call returns home feed from repository', () async {
    when(() => mockHomeRepository.getHomeFeed())
        .thenAnswer((_) async => TestFixtures.testHomeFeed);

    final result = await getHomeFeedUseCase();

    expect(result, TestFixtures.testHomeFeed);
    verify(() => mockHomeRepository.getHomeFeed()).called(1);
  });
}
