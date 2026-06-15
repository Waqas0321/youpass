import 'package:youpass/core/auth/auth_token_store.dart';
import 'package:youpass/core/auth/jwt_utils.dart';
import 'package:youpass/core/auth/session_establish_retry.dart';
import 'package:youpass/core/network/api_exception.dart';
import 'package:youpass/core/utils/app_logger.dart';
import 'package:youpass/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:youpass/features/auth/data/models/auth_session_model.dart';
import 'package:youpass/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:youpass/features/auth/data/models/user_model.dart';
import 'package:youpass/features/auth/data/models/user_profile_model.dart';
import 'package:youpass/features/auth/domain/entities/auth_session_entity.dart';
import 'package:youpass/features/auth/domain/entities/change_phone_result_entity.dart';
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
    final token = AuthTokenStore.accessToken ?? await localDataSource.getCachedToken();

    if (notifyServer && token != null && token.isNotEmpty) {
      try {
        await remoteDataSource.logoutRemote(accessTokenOverride: token);
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
  Future<UserProfileEntity> refreshUserProfile({
    String? accessTokenOverride,
  }) async {
    return withSessionEstablishRetry(() async {
      final token = _resolveAccessToken(accessTokenOverride);
      final profile = await remoteDataSource.fetchUserProfile(
        accessTokenOverride: token,
      );
      if (profile is UserProfileModel) {
        await localDataSource.cacheUserProfile(profile);
      }
      return profile;
    });
  }

  @override
  Future<UserProfileEntity> uploadProfilePhoto(
    String filePath, {
    String? accessTokenOverride,
  }) async {
    return withSessionEstablishRetry(() async {
      final token = _resolveAccessToken(accessTokenOverride);
      final profile = await remoteDataSource.uploadProfilePhoto(
        filePath,
        accessTokenOverride: token,
      );
      if (profile is UserProfileModel) {
        await localDataSource.cacheUserProfile(profile);
      }
      return profile;
    });
  }

  @override
  Future<String?> getAccessToken() async {
    return AuthTokenStore.accessToken ?? await localDataSource.getCachedToken();
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
    if (!result.isPendingDeletion) {
      await localDataSource.clearCache();
    }
    return result;
  }

  @override
  Future<OtpDeliveryResultEntity> requestChangePhone({
    required String newPhone,
    required String newCountryCode,
  }) {
    return remoteDataSource.requestChangePhone(
      newPhone: newPhone,
      newCountryCode: newCountryCode,
    );
  }

  @override
  Future<ChangePhoneResultEntity> verifyChangePhone({
    required String newPhone,
    required String newCountryCode,
    required String code,
  }) async {
    final result = await remoteDataSource.verifyChangePhone(
      newPhone: newPhone,
      newCountryCode: newCountryCode,
      code: code,
    );
    final profile = result.profile;
    if (profile is UserProfileModel) {
      await localDataSource.cacheUserProfile(profile);
    }
    return result;
  }

  Future<void> persistSession(AuthSessionEntity session) async {
    final token = AuthTokenStore.normalizeToken(session.accessToken);
    if (token == null || token.isEmpty) {
      throw ApiException(
        code: 'MISSING_ACCESS_TOKEN',
        message: 'MISSING_ACCESS_TOKEN',
        statusCode: 500,
      );
    }

    AuthTokenStore.setSession(
      accessToken: token,
      sessionId: AuthTokenStore.normalizeSessionId(session.sessionId) ??
          JwtUtils.readSessionId(token),
    );
    AuthTokenStore.markEstablished();

    AppLogger.auth(
      'Session persisted tokenPrefix=${token.substring(0, token.length.clamp(0, 20))}...',
    );

    final user = UserModel.fromEntity(session.user);
    await localDataSource.cacheUser(user);
    await localDataSource.cacheToken(token);

    if (session is AuthSessionModel && session.cachedLoginProfile != null) {
      await localDataSource.cacheUserProfile(session.cachedLoginProfile!);
      AppLogger.auth('Cached profile from login/register user payload');
    }
  }

  String _resolveAccessToken(String? accessTokenOverride) {
    final token = AuthTokenStore.normalizeToken(accessTokenOverride) ??
        AuthTokenStore.accessToken;
    if (token == null || token.isEmpty) {
      throw ApiException(
        code: 'UNAUTHORIZED',
        message: 'UNAUTHORIZED',
        statusCode: 401,
      );
    }
    return token;
  }
}
