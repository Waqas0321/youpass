import 'package:youpass/features/auth/domain/entities/post_registration_navigation_entity.dart';
import 'package:youpass/features/auth/domain/entities/welcome_entity.dart';

class WelcomeRouteArgs {
  const WelcomeRouteArgs({
    required this.welcome,
    required this.navigation,
    this.registrationStartedAtMs,
    this.analyticsSource = 'organic',
  });

  final WelcomeEntity welcome;
  final PostRegistrationNavigationEntity navigation;
  final int? registrationStartedAtMs;
  final String analyticsSource;
}
