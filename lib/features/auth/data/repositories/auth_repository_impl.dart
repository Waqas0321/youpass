import 'package:youpass/core/auth/auth_token_store.dart';
import 'package:youpass/core/network/api_exception.dart';
import 'package:youpass/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:youpass/features/auth/data/models/auth_session_model.dart';
import 'package:youpass/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:youpass/features/auth/data/models/user_model.dart';
import 'package:youpass/features/auth/data/models/user_profile_model.dart';
import 'package:youpass/features/auth/domain/entities/auth_session_entity.dart';
import 'package:youpass/features/auth/domain/entities/delete_account_result_entity.dart';
import 'package:youpass/features/auth/domain/entities/otp_delivery_result_entity.dart';
import 'package:youpass/features/auth/domain/entities/otp_purpose.dart';
import 'package:youpass/features/auth/domain/entities/register_request_entity.dart';
import 'package:youpass/features/auth/domain/entities/send_code_result_entity.dart';
import 'package:youpass/features/auth/domain/entities/user_entity.dart';
import 'package:youpass/features/auth/domain/entities/user_profile_entity.dart';
import 'package:youpass/features/auth/domain/entities/whatsapp_check_result_entity.dart';
import 'package:youpass/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  @override
  Future<WhatsAppCheckResultEntity> checkWhatsApp({
    required String phone,
    required String countryIsoCode,
    required OtpPurpose purpose,
  }) {
    return remoteDataSource.checkWhatsApp(
      phone: phone,
      countryIsoCode: countryIsoCode,
      purpose: purpose,
    );
  }

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
  Future<AuthSessionEntity> loginWithPhone({
    required String phone,
    required String countryIsoCode,
    required String code,
  }) async {
    final session = await remoteDataSource.loginWithPhone(
      phone: phone,
      countryIsoCode: countryIsoCode,
      code: code,
    );
    await persistSession(session);
    return session;
  }

  @override
  Future<AuthSessionEntity> registerAccount(RegisterRequestEntity request) async {
    final session = await remoteDataSource.registerAccount(request);
    await persistSession(session);
    final profile = UserProfileModel.fromRegisterRequest(
      user: UserModel.fromEntity(session.user),
      request: request,
    );
    await localDataSource.cacheUserProfile(profile);
    return session;
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
  Future<UserProfileEntity?> getCachedUserProfile() async {
    return localDataSource.getCachedUserProfile();
  }

  @override
  Future<UserProfileEntity> refreshUserProfile() async {
    final profile = await remoteDataSource.fetchUserProfile();
    if (profile is UserProfileModel) {
      await localDataSource.cacheUserProfile(profile);
    }
    return profile;
  }

  @override
  Future<String?> getAccessToken() async {
    return localDataSource.getCachedToken();
  }

  @override
  Future<OtpDeliveryResultEntity> requestDeleteAccount() {
    return remoteDataSource.requestDeleteAccount();
  }

  @override
  Future<DeleteAccountResultEntity> confirmDeleteAccount({
    required String code,
  }) async {
    final result = await remoteDataSource.confirmDeleteAccount(code: code);
    await localDataSource.clearCache();
    return result;
  }

  Future<void> persistSession(AuthSessionEntity session) async {
    final token = session.accessToken.trim();
    if (token.isEmpty) {
      throw ApiException(
        code: 'MISSING_ACCESS_TOKEN',
        message: 'Login response did not include a valid access token',
        statusCode: 500,
      );
    }

    AuthTokenStore.setSession(
      accessToken: token,
      sessionId: session.sessionId,
    );

    final user = UserModel.fromEntity(session.user);
    await localDataSource.cacheUser(user);
    await localDataSource.cacheToken(token);

    final sessionId = session.sessionId?.trim();
    if (sessionId != null && sessionId.isNotEmpty) {
      await localDataSource.cacheSessionId(sessionId);
    }

    if (session is AuthSessionModel && session.loginUserJson != null) {
      final profile = UserProfileModel.fromJson(session.loginUserJson!);
      await localDataSource.cacheUserProfile(profile);
    }
  }
}
