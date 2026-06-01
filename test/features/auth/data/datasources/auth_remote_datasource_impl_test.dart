import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youpass/features/auth/data/datasources/auth_remote_datasource_impl.dart';
import 'package:youpass/features/auth/data/models/auth_session_model.dart';
import 'package:youpass/features/auth/data/services/auth_api_service.dart';
import 'package:youpass/features/auth/domain/entities/otp_purpose.dart';
import '../../../../helpers/auth_test_helper.dart';
import '../../../../helpers/test_fixtures.dart';

class MockAuthApiService extends Mock implements AuthApiService {}

void main() {
  late MockAuthApiService mockAuthApiService;
  late AuthRemoteDataSourceImpl dataSource;

  setUpAll(AuthTestHelper.registerFallbacks);

  setUp(() {
    mockAuthApiService = MockAuthApiService();
    dataSource = AuthRemoteDataSourceImpl(mockAuthApiService);
  });

  test('sendVerificationCode delegates to auth api service', () async {
    when(
      () => mockAuthApiService.sendCode(
        phone: any(named: 'phone'),
        countryIsoCode: any(named: 'countryIsoCode'),
        purpose: any(named: 'purpose'),
      ),
    ).thenAnswer((_) async => TestFixtures.testSendCodeResult);

    final result = await dataSource.sendVerificationCode(
      phone: TestFixtures.testPhone,
      countryIsoCode: 'CL',
      purpose: OtpPurpose.login,
    );

    expect(result, TestFixtures.testSendCodeResult);
  });

  test('loginWithPhone delegates to auth api service', () async {
    const session = AuthSessionModel(
      accessToken: TestFixtures.testToken,
      user: TestFixtures.testUser,
    );

    when(
      () => mockAuthApiService.login(
        phone: any(named: 'phone'),
        countryIsoCode: any(named: 'countryIsoCode'),
        code: any(named: 'code'),
      ),
    ).thenAnswer((_) async => session);

    final result = await dataSource.loginWithPhone(
      phone: TestFixtures.testPhone,
      countryIsoCode: 'CL',
      code: '123456',
    );

    expect(result.accessToken, TestFixtures.testToken);
  });
}
