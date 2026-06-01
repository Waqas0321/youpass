import 'package:youpass/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:youpass/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:youpass/features/auth/data/models/user_model.dart';
import 'package:youpass/features/auth/domain/entities/auth_session_entity.dart';
import 'package:youpass/features/auth/domain/entities/otp_purpose.dart';
import 'package:youpass/features/auth/domain/entities/register_request_entity.dart';
import 'package:youpass/features/auth/domain/entities/send_code_result_entity.dart';
import 'package:youpass/features/auth/domain/entities/user_entity.dart';
import 'package:youpass/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  @override
  Future<SendCodeResultEntity> sendVerificationCode({
    required String phone,
    required String countryIsoCode,
    required OtpPurpose purpose,
  }) {
    return remoteDataSource.sendVerificationCode(
      phone: phone,
      countryIsoCode: countryIsoCode,
      purpose: purpose,
    );
  }

  @override
  Future<SendCodeResultEntity> resendVerificationCode({
    required String phone,
    required String countryIsoCode,
    required OtpPurpose purpose,
  }) {
    return remoteDataSource.resendVerificationCode(
      phone: phone,
      countryIsoCode: countryIsoCode,
      purpose: purpose,
    );
  }

  @override
  Future<UserEntity> loginWithPhone({
    required String phone,
    required String countryIsoCode,
    required String code,
  }) async {
    final session = await remoteDataSource.loginWithPhone(
      phone: phone,
      countryIsoCode: countryIsoCode,
      code: code,
    );
    return persistSession(session);
  }

  @override
  Future<UserEntity> registerAccount(RegisterRequestEntity request) async {
    final session = await remoteDataSource.registerAccount(request);
    return persistSession(session);
  }

  @override
  Future<void> logout({bool notifyServer = true}) async {
    if (notifyServer) {
      try {
        await remoteDataSource.logoutRemote();
      } catch (_) {
        // Clear local session even if server logout fails.
      }
    }
    await localDataSource.clearCache();
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    return localDataSource.getCachedUser();
  }

  @override
  Future<String?> getAccessToken() async {
    return localDataSource.getCachedToken();
  }

  Future<UserEntity> persistSession(AuthSessionEntity session) async {
    final user = UserModel.fromEntity(session.user);
    await localDataSource.cacheUser(user);
    await localDataSource.cacheToken(session.accessToken);
    return user;
  }
}
