import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/locale/app_locale.dart';
import 'package:youpass/features/auth/domain/entities/otp_purpose.dart';
import 'package:youpass/features/auth/domain/usecases/login_usecase.dart';
import 'package:youpass/features/auth/domain/usecases/logout_usecase.dart';
import 'package:youpass/features/auth/domain/usecases/register_usecase.dart';
import 'package:youpass/features/auth/domain/usecases/resend_code_usecase.dart';
import 'package:youpass/features/auth/domain/usecases/send_code_usecase.dart';
import 'package:youpass/features/auth/presentation/providers/auth_provider.dart';
import 'package:youpass/features/auth/routes/verification_route_args.dart';
import 'package:youpass/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../features/auth/mocks/mock_auth_repository.dart';
import 'test_fixtures.dart';

class AuthTestHelper {
  AuthTestHelper._();

  static bool _fallbacksRegistered = false;

  static void registerFallbacks() {
    if (_fallbacksRegistered) {
      return;
    }

    registerFallbackValue(OtpPurpose.login);
    registerFallbackValue(TestFixtures.testSendCodeResult);
    registerFallbackValue(TestFixtures.testUser);
    _fallbacksRegistered = true;
  }

  static Widget wrap({
    required Widget child,
    MockAuthRepository? mockAuthRepository,
    Map<String, WidgetBuilder>? routes,
    String? initialRoute,
    Locale locale = AppLocale.defaultLocale,
  }) {
    registerFallbacks();

    final repository = mockAuthRepository ?? MockAuthRepository();
    stubSendCodeSuccess(repository);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => buildAuthProvider(repository),
        ),
      ],
      child: MaterialApp(
        locale: locale,
        supportedLocales: AppLocale.supported,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: initialRoute == null ? child : null,
        routes: routes ?? const {},
        initialRoute: initialRoute,
      ),
    );
  }

  static AuthProvider buildAuthProvider(MockAuthRepository repository) {
    return AuthProvider(
      sendCodeUseCase: SendCodeUseCase(repository),
      resendCodeUseCase: ResendCodeUseCase(repository),
      loginUseCase: LoginUseCase(repository),
      registerUseCase: RegisterUseCase(repository),
      logoutUseCase: LogoutUseCase(repository),
      authRepository: repository,
    );
  }

  static void stubSendCodeSuccess(MockAuthRepository repository) {
    when(
      () => repository.sendVerificationCode(
        phone: any(named: 'phone'),
        countryIsoCode: any(named: 'countryIsoCode'),
        purpose: any(named: 'purpose'),
      ),
    ).thenAnswer((_) async => TestFixtures.testSendCodeResult);
  }

  static const VerificationRouteArgs testVerificationArgs = VerificationRouteArgs(
    phone: '912345678',
    countryIsoCode: 'CL',
    purpose: OtpPurpose.login,
    phoneDisplay: '+56 9 1234 5678',
    resendCooldownSeconds: 60,
  );
}
