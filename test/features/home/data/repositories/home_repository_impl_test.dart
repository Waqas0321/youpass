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

  test('getHomeFeed delegates to remote datasource', () async {
    when(() => mockRemoteDataSource.fetchHomeFeed())
        .thenAnswer((_) async => TestFixtures.testHomeFeed);

    final result = await repository.getHomeFeed();

    expect(result, TestFixtures.testHomeFeed);
    verify(() => mockRemoteDataSource.fetchHomeFeed()).called(1);
  });
}
