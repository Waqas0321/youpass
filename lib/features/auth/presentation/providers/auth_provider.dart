import 'package:flutter/foundation.dart';
import 'package:youpass/core/auth/auth_token_store.dart';
import 'package:youpass/core/auth/jwt_utils.dart';
import 'package:youpass/core/network/api_exception.dart';
import 'package:youpass/core/constants/app_constants.dart';
import 'package:youpass/core/l10n/auth_message_localizer.dart';
import 'package:youpass/core/utils/app_logger.dart';
import 'package:youpass/features/auth/domain/entities/auth_session_entity.dart';
import 'package:youpass/features/auth/domain/entities/otp_delivery_result_entity.dart';
import 'package:youpass/features/auth/domain/entities/otp_purpose.dart';
import 'package:youpass/features/auth/domain/entities/register_request_entity.dart';
import 'package:youpass/features/auth/domain/entities/send_code_result_entity.dart';
import 'package:youpass/features/auth/domain/entities/user_entity.dart';
import 'package:youpass/features/auth/domain/entities/user_profile_entity.dart';
import 'package:youpass/features/auth/domain/entities/welcome_entity.dart';
import 'package:youpass/features/auth/domain/entities/whatsapp_check_result_entity.dart';
import 'package:youpass/features/auth/domain/repositories/auth_repository.dart';
import 'package:youpass/features/auth/domain/usecases/check_whatsapp_usecase.dart';
import 'package:youpass/features/auth/domain/usecases/confirm_delete_account_usecase.dart';
import 'package:youpass/features/auth/domain/usecases/get_user_profile_usecase.dart';
import 'package:youpass/features/auth/domain/usecases/login_usecase.dart';
import 'package:youpass/features/auth/domain/usecases/logout_usecase.dart';
import 'package:youpass/features/auth/domain/usecases/register_usecase.dart';
import 'package:youpass/features/auth/domain/usecases/request_delete_account_usecase.dart';
import 'package:youpass/features/auth/domain/usecases/resend_code_usecase.dart';
import 'package:youpass/features/auth/domain/usecases/send_code_usecase.dart';
import 'package:youpass/features/auth/domain/usecases/upload_profile_photo_usecase.dart';
import 'package:youpass/core/providers/session_providers_reset.dart';
import 'package:youpass/dependency_injection/injection_container.dart';
import 'package:youpass/features/home/presentation/providers/home_provider.dart';
import 'package:youpass/features/invitations/presentation/providers/invitations_provider.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthProvider extends ChangeNotifier {
  AuthProvider({
    required this.sendCodeUseCase,
    required this.resendCodeUseCase,
    required this.checkWhatsAppUseCase,
    required this.loginUseCase,
    required this.registerUseCase,
    required this.logoutUseCase,
    required this.getUserProfileUseCase,
    required this.requestDeleteAccountUseCase,
    required this.confirmDeleteAccountUseCase,
    required this.uploadProfilePhotoUseCase,
    required this.authRepository,
  });

  final SendCodeUseCase sendCodeUseCase;
  final ResendCodeUseCase resendCodeUseCase;
  final CheckWhatsAppUseCase checkWhatsAppUseCase;
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final LogoutUseCase logoutUseCase;
  final GetUserProfileUseCase getUserProfileUseCase;
  final RequestDeleteAccountUseCase requestDeleteAccountUseCase;
  final ConfirmDeleteAccountUseCase confirmDeleteAccountUseCase;
  final UploadProfilePhotoUseCase uploadProfilePhotoUseCase;
  final AuthRepository authRepository;

  AuthStatus status = AuthStatus.initial;
  UserEntity? currentUser;
  UserProfileEntity? userProfile;
  WelcomeEntity? pendingWelcome;
  String? errorMessage;
  String? errorCode;
  bool isSubmitting = false;
  bool isUploadingProfilePhoto = false;
  int? lastRetryAfterSeconds;
  String? _pinnedAccessToken;

  Future<void> checkAuthStatus() async {
    AppLogger.auth('Checking auth status');
    status = AuthStatus.loading;
    notifyListeners();

    final token = await authRepository.getAccessToken();
    if (token == null || token.isEmpty) {
      await _setUnauthenticated();
      return;
    }

    if (JwtUtils.isExpired(token)) {
      AppLogger.auth('Stored access token expired — clearing session');
      await authRepository.logout(notifyServer: false);
      await _setUnauthenticated();
      return;
    }

    userProfile = await authRepository.getCachedUserProfile();
    currentUser = userProfile?.toUserEntity() ??
        await authRepository.getCurrentUser();

    try {
      userProfile = await getUserProfileUseCase(
        accessTokenOverride: await _resolveAccessToken(),
      );
      currentUser = userProfile!.toUserEntity();
      await _setAuthenticated();
    } on ApiException catch (error) {
      if (_isSessionInvalid(error)) {
        AppLogger.auth('Session no longer valid — clearing stored credentials');
        await authRepository.logout(notifyServer: false);
        await _setUnauthenticated();
        return;
      }

      if (currentUser != null) {
        await _setAuthenticated();
        return;
      }

      errorCode = error.code;
      errorMessage = error.message;
      status = AuthStatus.unauthenticated;
      notifyListeners();
    } catch (error, stackTrace) {
      AppLogger.error(
        'checkAuthStatus failed',
        tag: 'Auth',
        error: error,
        stackTrace: stackTrace,
      );

      if (currentUser != null) {
        await _setAuthenticated();
        return;
      }

      await _setUnauthenticated();
    }
  }

  WelcomeEntity? consumePendingWelcome() {
    final welcome = pendingWelcome;
    pendingWelcome = null;
    return welcome;
  }

  Future<WhatsAppCheckResultEntity?> checkWhatsApp({
    required String phone,
    required String countryIsoCode,
    required OtpPurpose purpose,
  }) async {
    return runAuthAction(
      actionName: 'check-whatsapp',
      action: () => checkWhatsAppUseCase(
        phone: phone,
        countryIsoCode: countryIsoCode,
        purpose: purpose,
      ),
      logContext: 'purpose=${purpose.apiValue} country=$countryIsoCode phone=$phone',
    );
  }

  Future<SendCodeResultEntity?> sendVerificationCode({
    required String phone,
    required String countryIsoCode,
    required OtpPurpose purpose,
  }) async {
    return runAuthAction(
      actionName: 'send-code',
      action: () => sendCodeUseCase(
        phone: phone,
        countryIsoCode: countryIsoCode,
        purpose: purpose,
      ),
      logContext:
          'purpose=${purpose.apiValue} country=$countryIsoCode phone=$phone',
    );
  }

  Future<SendCodeResultEntity?> resendVerificationCode({
    required String phone,
    required String countryIsoCode,
    required OtpPurpose purpose,
  }) async {
    return runAuthAction(
      actionName: 'resend-code',
      action: () => resendCodeUseCase(
        phone: phone,
        countryIsoCode: countryIsoCode,
        purpose: purpose,
      ),
      logContext:
          'purpose=${purpose.apiValue} country=$countryIsoCode phone=$phone',
    );
  }

  Future<bool> bypassLoginForTesting() async {
    currentUser = const UserEntity(
      id: 'dev-bypass-user',
      email: 'dev@youpass.com',
      name: 'Dev Tester',
    );
    status = AuthStatus.authenticated;
    errorMessage = null;
    errorCode = null;
    isSubmitting = false;
    AppLogger.auth('Login bypass (dev) — API skipped');
    notifyListeners();
    return true;
  }

  Future<bool> loginWithPhone({
    required String phone,
    required String countryIsoCode,
    required String code,
  }) async {
    if (AppConstants.devBypassLoginApi) {
      return bypassLoginForTesting();
    }

    final session = await runAuthAction(
      actionName: 'one-time-login',
      action: () => loginUseCase(
        phone: phone,
        countryIsoCode: countryIsoCode,
        code: code,
      ),
      logContext: 'country=$countryIsoCode phone=$phone code=******',
    );

    if (session == null) {
      return false;
    }

    return _completeAuthSession(session, logLabel: 'One-time login');
  }

  Future<bool> registerAccount(RegisterRequestEntity request) async {
    final session = await runAuthAction(
      actionName: 'register',
      action: () => registerUseCase(request),
      logContext:
          'country=${request.countryIsoCode} phone=${request.phone} email=${request.email}',
    );

    if (session == null) {
      return false;
    }

    return _completeAuthSession(session, logLabel: 'Register');
  }

  Future<bool> _completeAuthSession(
    AuthSessionEntity session, {
    required String logLabel,
  }) async {
    currentUser = session.user;
    pendingWelcome = session.welcome;
    status = AuthStatus.authenticated;

    final token = AuthTokenStore.accessToken ??
        AuthTokenStore.normalizeToken(session.accessToken);
    if (token != null && token.isNotEmpty) {
      _pinnedAccessToken = token;
      AppLogger.auth(
        'Pinned login token tokenPrefix=${token.substring(0, token.length.clamp(0, 20))}...',
      );
    }

    await _refreshProfileSilently(
      accessTokenOverride: token,
    );
    AppLogger.auth('$logLabel success userId=${session.user.id}');
    notifyListeners();
    return true;
  }

  Future<void> hydrateCachedUserProfile() async {
    if (userProfile != null) {
      return;
    }

    final cached = await authRepository.getCachedUserProfile();
    if (cached == null) {
      return;
    }

    userProfile = cached;
    currentUser = cached.toUserEntity();
    notifyListeners();
  }

  Future<UserProfileEntity?> refreshUserProfile() async {
    final accessToken = await _resolveAccessToken();
    final profile = await runAuthAction(
      actionName: 'get-profile',
      action: () => getUserProfileUseCase(
        accessTokenOverride: accessToken,
      ),
    );

    if (profile != null) {
      userProfile = profile;
      currentUser = profile.toUserEntity();
      if (status != AuthStatus.authenticated) {
        status = AuthStatus.authenticated;
      }
      notifyListeners();
      return profile;
    }

    if (errorCode == 'SESSION_INVALID' || errorCode == 'UNAUTHORIZED') {
      await authRepository.logout(notifyServer: false);
      await _setUnauthenticated();
      return null;
    }

    final cached = await authRepository.getCachedUserProfile();
    if (cached != null) {
      userProfile = cached;
      currentUser = cached.toUserEntity();
      notifyListeners();
      return cached;
    }

    return null;
  }

  Future<OtpDeliveryResultEntity?> requestDeleteAccount() async {
    return runAuthAction(
      actionName: 'delete-account-request',
      action: () => requestDeleteAccountUseCase(),
    );
  }

  Future<bool> confirmDeleteAccount(String code) async {
    final result = await runAuthAction(
      actionName: 'delete-account-verify',
      action: () => confirmDeleteAccountUseCase(code),
      logContext: 'code=******',
    );

    if (result == null) {
      return false;
    }

    await _setUnauthenticated();
    AppLogger.auth('Account deleted');
    return true;
  }

  Future<bool> uploadProfilePhoto(String filePath) async {
    isUploadingProfilePhoto = true;
    errorMessage = null;
    errorCode = null;
    notifyListeners();

    try {
      final token = await _resolveAccessToken();
      final profile = await uploadProfilePhotoUseCase(
        filePath,
        accessTokenOverride: token,
      );
      userProfile = profile;
      currentUser = profile.toUserEntity();
      AppLogger.auth('Profile photo updated');
      return true;
    } on ApiException catch (error) {
      errorCode = error.code;
      errorMessage = error.message;
      AppLogger.warning(
        'upload-profile-photo failed: ${error.code}',
        tag: 'Auth',
      );
      if (_isSessionInvalid(error)) {
        await authRepository.logout(notifyServer: false);
        await _setUnauthenticated();
      }
      return false;
    } catch (error, stackTrace) {
      errorMessage = error.toString();
      AppLogger.error(
        'upload-profile-photo failed',
        tag: 'Auth',
        error: error,
        stackTrace: stackTrace,
      );
      return false;
    } finally {
      isUploadingProfilePhoto = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    AppLogger.auth('Logout');
    status = AuthStatus.loading;
    notifyListeners();

    await logoutUseCase();
    await _setUnauthenticated();
    AppLogger.auth('Logout complete');
  }

  void clearError() {
    errorMessage = null;
    errorCode = null;
    notifyListeners();
  }

  Future<T?> runAuthAction<T>({
    required Future<T> Function() action,
    String? actionName,
    String? logContext,
  }) async {
    if (actionName != null) {
      final details = logContext == null ? '' : ' ($logContext)';
      AppLogger.auth('→ $actionName$details');
    }

    isSubmitting = true;
    errorMessage = null;
    errorCode = null;
    lastRetryAfterSeconds = null;
    notifyListeners();

    try {
      final result = await action();
      if (actionName != null) {
        AppLogger.auth('✓ $actionName succeeded');
      }
      return result;
    } on ApiException catch (error) {
      errorCode = error.code;
      errorMessage = error.message;
      lastRetryAfterSeconds = error.retryAfterSeconds;
      AppLogger.warning(
        '${actionName ?? 'auth'} failed: ${error.code} — '
        '${AuthMessageLocalizer.forDebugLog(
          code: error.code,
          fallbackMessage: error.message,
          retryAfterSeconds: error.retryAfterSeconds,
        )}',
        tag: 'Auth',
      );
      return null;
    } catch (error, stackTrace) {
      errorMessage = error.toString();
      AppLogger.error(
        '${actionName ?? 'auth'} failed',
        tag: 'Auth',
        error: error,
        stackTrace: stackTrace,
      );
      return null;
    } finally {
      isSubmitting = false;
      notifyListeners();
    }
  }

  Future<void> _refreshProfileSilently({String? accessTokenOverride}) async {
    final cached = await authRepository.getCachedUserProfile();
    if (cached != null) {
      userProfile = cached;
      currentUser = cached.toUserEntity();
      AppLogger.auth('Using profile cached from login/register response');
      return;
    }

    try {
      userProfile = await getUserProfileUseCase(
        accessTokenOverride: accessTokenOverride,
      );
      currentUser = userProfile!.toUserEntity();
    } on ApiException catch (error) {
      if (_isSessionInvalid(error)) {
        AppLogger.auth(
          'Profile refresh after login failed with ${error.code} — '
          'using cached login profile',
        );
      }
      final cached = await authRepository.getCachedUserProfile();
      if (cached != null) {
        userProfile = cached;
        currentUser = cached.toUserEntity();
      }
    } catch (_) {
      final cached = await authRepository.getCachedUserProfile();
      if (cached != null) {
        userProfile = cached;
        currentUser = cached.toUserEntity();
      }
    }
  }

  Future<void> _setAuthenticated() async {
    status = AuthStatus.authenticated;
    errorMessage = null;
    errorCode = null;
    notifyListeners();
  }

  Future<void> _setUnauthenticated() async {
    _pinnedAccessToken = null;
    if (sl.isRegistered<HomeProvider>() &&
        sl.isRegistered<InvitationsProvider>()) {
      resetSessionProviders(
        homeProvider: sl<HomeProvider>(),
        invitationsProvider: sl<InvitationsProvider>(),
      );
    }
    currentUser = null;
    userProfile = null;
    pendingWelcome = null;
    status = AuthStatus.unauthenticated;
    errorMessage = null;
    errorCode = null;
    notifyListeners();
  }

  bool _isSessionInvalid(ApiException error) {
    return error.code == 'SESSION_INVALID' || error.code == 'UNAUTHORIZED';
  }

  Future<String> _resolveAccessToken() async {
    final pinned = AuthTokenStore.normalizeToken(_pinnedAccessToken);
    if (pinned != null && pinned.isNotEmpty) {
      return pinned;
    }

    final memory = AuthTokenStore.accessToken;
    if (memory != null && memory.isNotEmpty) {
      return memory;
    }

    final disk = await authRepository.getAccessToken();
    if (disk != null && disk.isNotEmpty) {
      return disk;
    }

    throw ApiException(
      code: 'UNAUTHORIZED',
      message: 'UNAUTHORIZED',
      statusCode: 401,
    );
  }
}
