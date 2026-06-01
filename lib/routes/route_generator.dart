import 'package:flutter/material.dart';
import 'package:youpass/core/constants/country_code_list.dart';
import 'package:youpass/features/auth/domain/entities/otp_purpose.dart';
import 'package:youpass/features/auth/presentation/screens/login_screen.dart';
import 'package:youpass/features/auth/presentation/screens/register_screen.dart';
import 'package:youpass/features/auth/presentation/screens/splash_screen.dart';
import 'package:youpass/features/auth/presentation/screens/verification_screen.dart';
import 'package:youpass/features/auth/routes/register_route_args.dart';
import 'package:youpass/features/auth/routes/verification_route_args.dart';
import 'package:youpass/features/home/presentation/screens/home_screen.dart';
import 'package:youpass/core/widgets/route_not_found_screen.dart';
import 'package:youpass/routes/app_routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRoutes.register:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const RegisterScreen(),
        );
      case AppRoutes.verification:
        final args = settings.arguments;
        final verificationArgs = args is VerificationRouteArgs
            ? args
            : VerificationRouteArgs(
                phone: '912345678',
                countryIsoCode: CountryCodeList.defaultCountry.isoCode,
                purpose: OtpPurpose.login,
                phoneDisplay: '+56 9 1234 5678',
                resendCooldownSeconds: 60,
              );
        return MaterialPageRoute(
          builder: (_) => VerificationScreen(args: verificationArgs),
        );
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => const RouteNotFoundScreen(),
        );
    }
  }
}