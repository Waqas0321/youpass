import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/locale/app_locale.dart';
import 'package:youpass/features/auth/data/models/profile_completeness_model.dart';
import 'package:youpass/features/auth/data/models/user_profile_model.dart';
import 'package:youpass/features/auth/domain/entities/otp_purpose.dart';
import 'package:youpass/features/auth/domain/usecases/check_whatsapp_usecase.dart';
import 'package:youpass/features/auth/domain/usecases/confirm_delete_account_usecase.dart';
import 'package:youpass/features/auth/domain/usecases/get_user_profile_usecase.dart';
import 'package:youpass/features/auth/domain/usecases/login_usecase.dart';
import 'package:youpass/features/auth/domain/usecases/logout_usecase.dart';
import 'package:youpass/features/auth/domain/usecases/register_usecase.dart';
import 'package:youpass/features/auth/domain/usecases/request_delete_account_usecase.dart';
import 'package:youpass/features/auth/domain/usecases/resend_code_usecase.dart';
import 'package:youpass/features/auth/domain/usecases/send_code_usecase.dart';
import 'package:youpass/features/auth/presentation/providers/auth_provider.dart';
import 'package:youpass/features/home/presentation/providers/home_provider.dart';
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
    registerFallbackValue(TestFixtures.testAuthSession);
    registerFallbackValue(TestFixtures.testWhatsAppCheck);
    registerFallbackValue(
      UserProfileModel(
        id: TestFixtures.testUser.id,
        phone: '',
        phoneDisplay: '',
        countryCode: 'PK',
        fullName: TestFixtures.testUser.name,
        email: TestFixtures.testUser.email,
        birthdate: '',
        gender: '',
        rutOrPassport: '',
        category: 'bronze',
        accountStatus: 'active',
        createdAt: DateTime(2026),
        profileCompleteness: const ProfileCompletenessModel(
          hasPhoto: false,
          hasInstagram: false,
          completionPercentage: 0,
          missingFields: [],
        ),
      ),
    );
    _fallbacksRegistered = true;
  }

  static Widget wrap({
    required Widget child,
    MockAuthRepository? mockAuthRepository,
    HomeProvider? homeProvider,
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
        if (homeProvider != null)
          ChangeNotifierProvider<HomeProvider>.value(value: homeProvider),
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
      checkWhatsAppUseCase: CheckWhatsAppUseCase(repository),
      loginUseCase: LoginUseCase(repository),
      registerUseCase: RegisterUseCase(repository),
      logoutUseCase: LogoutUseCase(repository),
      getUserProfileUseCase: GetUserProfileUseCase(repository),
      requestDeleteAccountUseCase: RequestDeleteAccountUseCase(repository),
      confirmDeleteAccountUseCase: ConfirmDeleteAccountUseCase(repository),
      authRepository: repository,
    );
  }

  static void stubSendCodeSuccess(MockAuthRepository repository) {
    when(
      () => repository.checkWhatsApp(
        phone: any(named: 'phone'),
        countryIsoCode: any(named: 'countryIsoCode'),
        purpose: any(named: 'purpose'),
      ),
    ).thenAnswer((_) async => TestFixtures.testWhatsAppCheck);

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
