import 'package:youpass/core/config/app_product_config.dart';
import 'package:youpass/features/auth/domain/entities/auth_session_entity.dart';
import 'package:youpass/features/auth/domain/entities/post_registration_navigation_entity.dart';
import 'package:youpass/features/auth/domain/entities/welcome_entity.dart';

class PostRegistrationFlowHelper {
  PostRegistrationFlowHelper._();

  static PostRegistrationNavigationEntity resolveNavigation(
    AuthSessionEntity session,
  ) {
    final fromResponse = session.navigation;
    if (fromResponse != null) {
      return fromResponse;
    }

    return AppProductConfig.postRegistration.toNavigationEntity(
      highlightPendingInvitation: session.linkedInvitations > 0,
      linkedInvitationsCount: session.linkedInvitations,
    );
  }

  static WelcomeEntity resolveWelcome(AuthSessionEntity session) {
    final fromResponse = session.welcome;
    if (fromResponse != null) {
      return WelcomeEntity(
        title: fromResponse.title.trim().isEmpty
            ? _defaultTitle(session)
            : fromResponse.title,
        subtitle: fromResponse.subtitle.trim().isEmpty
            ? _defaultSubtitle()
            : fromResponse.subtitle,
        durationSeconds: fromResponse.durationSeconds > 0
            ? fromResponse.durationSeconds
            : AppProductConfig.postRegistration.welcomeDurationSeconds,
      );
    }

    return WelcomeEntity(
      title: _defaultTitle(session),
      subtitle: _defaultSubtitle(),
      durationSeconds: AppProductConfig.postRegistration.welcomeDurationSeconds,
    );
  }

  static String _defaultTitle(AuthSessionEntity session) {
    final name = session.user.name.trim();
    if (name.isEmpty) {
      return 'Welcome to YouPass';
    }

    final firstName = name.split(RegExp(r'\s+')).first;
    return 'Welcome to YouPass, $firstName!';
  }

  static String _defaultSubtitle() {
    return 'Your access to the best events starts here';
  }
}
