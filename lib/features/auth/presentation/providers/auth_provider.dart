import 'package:flutter/foundation.dart';
import 'package:youpass/core/l10n/auth_message_localizer.dart';
import 'package:youpass/core/network/api_exception.dart';
import 'package:youpass/core/utils/app_logger.dart';
import 'package:youpass/features/auth/domain/entities/otp_purpose.dart';
import 'package:youpass/features/auth/domain/entities/register_request_entity.dart';
import 'package:youpass/features/auth/domain/entities/send_code_result_entity.dart';
import 'package:youpass/features/auth/domain/entities/user_entity.dart';
import 'package:youpass/features/auth/domain/repositories/auth_repository.dart';
import 'package:youpass/features/auth/domain/usecases/login_usecase.dart';
import 'package:youpass/features/auth/domain/usecases/logout_usecase.dart';
import 'package:youpass/features/auth/domain/usecases/register_usecase.dart';
import 'package:youpass/features/auth/domain/usecases/resend_code_usecase.dart';
import 'package:youpass/features/auth/domain/usecases/send_code_usecase.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthProvider extends ChangeNotifier {
  AuthProvider({
    required this.sendCodeUseCase,
    required this.resendCodeUseCase,
    required this.loginUseCase,
    required this.registerUseCase,
    required this.logoutUseCase,
    required this.authRepository,
  });

  final SendCodeUseCase sendCodeUseCase;
  final ResendCodeUseCase resendCodeUseCase;
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final LogoutUseCase logoutUseCase;
  final AuthRepository authRepository;

  AuthStatus status = AuthStatus.initial;
  UserEntity? currentUser;
  String? errorMessage;
  String? errorCode;
  bool isSubmitting = false;
  int? lastRetryAfterSeconds;

  Future<void> checkAuthStatus() async {
    AppLogger.auth('Checking auth status');
    status = AuthStatus.loading;
    notifyListeners();

    currentUser = await authRepository.getCurrentUser();
    status = currentUser != null
        ? AuthStatus.authenticated
        : AuthStatus.unauthenticated;
    AppLogger.auth('Auth status: $status');
    notifyListeners();
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

  Future<bool> loginWithPhone({
    required String phone,
    required String countryIsoCode,
    required String code,
  }) async {
    final user = await runAuthAction(
      actionName: 'login',
      action: () => loginUseCase(
        phone: phone,
        countryIsoCode: countryIsoCode,
        code: code,
      ),
      logContext: 'country=$countryIsoCode phone=$phone code=******',
    );

    if (user == null) {
      return false;
    }

    currentUser = user;
    status = AuthStatus.authenticated;
    AppLogger.auth('Login success userId=${user.id}');
    notifyListeners();
    return true;
  }

  Future<bool> registerAccount(RegisterRequestEntity request) async {
    final user = await runAuthAction(
      actionName: 'register',
      action: () => registerUseCase(request),
      logContext:
          'country=${request.countryIsoCode} phone=${request.phone} email=${request.email}',
    );

    if (user == null) {
      return false;
    }

    currentUser = user;
    status = AuthStatus.authenticated;
    AppLogger.auth('Register success userId=${user.id}');
    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    AppLogger.auth('Logout');
    status = AuthStatus.loading;
    notifyListeners();

    await logoutUseCase();
    currentUser = null;
    status = AuthStatus.unauthenticated;
    AppLogger.auth('Logout complete');
    notifyListeners();
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

}
