import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youpass/features/home/data/repositories/home_repository_impl.dart';

import '../../mocks/mock_home_remote_datasource.dart';
import '../../../../helpers/test_fixtures.dart';

void main() {
  late MockHomeRemoteDataSource mockRemoteDataSource;
  late HomeRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockHomeRemoteDataSource();
    repository = HomeRepositoryImpl(mockRemoteDataSource);
  });

  test('getHomeData delegates to remote datasource', () async {
    when(() => mockRemoteDataSource.fetchHomeData())
        .thenAnswer((_) async => TestFixtures.testHome);

    final result = await repository.getHomeData();

    expect(result, TestFixtures.testHome);
    verify(() => mockRemoteDataSource.fetchHomeData()).called(1);
  });
}
