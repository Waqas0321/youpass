import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youpass/features/auth/data/repositories/auth_repository_impl.dart';
import '../../mocks/mock_auth_local_datasource.dart';
import '../../mocks/mock_auth_remote_datasource.dart';
import '../../../../helpers/test_fixtures.dart';

void main() {
  late MockAuthRemoteDataSource mockRemoteDataSource;
  late MockAuthLocalDataSource mockLocalDataSource;
  late AuthRepositoryImpl repository;

  setUpAll(() {
    registerFallbackValue(TestFixtures.testUser);
  });

  setUp(() {
    mockRemoteDataSource = MockAuthRemoteDataSource();
    mockLocalDataSource = MockAuthLocalDataSource();
    repository = AuthRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  group('login', () {
    test('fetches user, caches user and token', () async {
      when(
        () => mockRemoteDataSource.login(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => TestFixtures.testUser);
      when(() => mockLocalDataSource.cacheUser(any())).thenAnswer((_) async {});
      when(() => mockLocalDataSource.cacheToken(any())).thenAnswer((_) async {});

      final result = await repository.login(
        email: TestFixtures.testEmail,
        password: TestFixtures.testPassword,
      );

      expect(result, TestFixtures.testUser);
      verify(() => mockLocalDataSource.cacheUser(TestFixtures.testUser)).called(1);
      verify(() => mockLocalDataSource.cacheToken(TestFixtures.testToken)).called(1);
    });
  });

  group('logout', () {
    test('clears local cache', () async {
      when(() => mockLocalDataSource.clearCache()).thenAnswer((_) async {});

      await repository.logout();

      verify(() => mockLocalDataSource.clearCache()).called(1);
    });
  });

  group('sendVerificationCode', () {
    test('delegates to remote datasource', () async {
      when(
        () => mockRemoteDataSource.sendVerificationCode(
          countryCode: any(named: 'countryCode'),
          phoneNumber: any(named: 'phoneNumber'),
        ),
      ).thenAnswer((_) async {});

      await repository.sendVerificationCode(
        countryCode: '56',
        phoneNumber: '912345678',
      );

      verify(
        () => mockRemoteDataSource.sendVerificationCode(
          countryCode: '56',
          phoneNumber: '912345678',
        ),
      ).called(1);
    });
  });

  group('getCurrentUser', () {
    test('returns cached user from local datasource', () async {
      when(() => mockLocalDataSource.getCachedUser())
          .thenAnswer((_) async => TestFixtures.testUser);

      final result = await repository.getCurrentUser();

      expect(result, TestFixtures.testUser);
    });
  });
}
