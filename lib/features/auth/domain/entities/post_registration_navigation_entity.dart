import 'package:equatable/equatable.dart';

class PostRegistrationNavigationEntity extends Equatable {
  const PostRegistrationNavigationEntity({
    this.flow = 'welcome_then_home',
    this.navigateTo = 'you_home',
    this.showWelcomeScreen = true,
    this.welcomeDurationSeconds = 2,
    this.openHamburgerMenu = false,
    this.openProfile = false,
    this.showOnboarding = false,
    this.requestPermissions = false,
    this.showPartyModeBanner = false,
    this.highlightPendingInvitation = false,
    this.linkedInvitationsCount = 0,
    this.preloadEndpoint = '/home/initial-feed',
    this.forbiddenRoutes = const [
      'profile',
      'hamburger_menu',
      'onboarding',
      'permissions_prompt',
    ],
  });

  final String flow;
  final String navigateTo;
  final bool showWelcomeScreen;
  final int welcomeDurationSeconds;
  final bool openHamburgerMenu;
  final bool openProfile;
  final bool showOnboarding;
  final bool requestPermissions;
  final bool showPartyModeBanner;
  final bool highlightPendingInvitation;
  final int linkedInvitationsCount;
  final String? preloadEndpoint;
  final List<String> forbiddenRoutes;

  bool get shouldNavigateToHome => navigateTo == 'you_home';

  @override
  List<Object?> get props => [
        flow,
        navigateTo,
        showWelcomeScreen,
        welcomeDurationSeconds,
        openHamburgerMenu,
        openProfile,
        showOnboarding,
        requestPermissions,
        showPartyModeBanner,
        highlightPendingInvitation,
        linkedInvitationsCount,
        preloadEndpoint,
        forbiddenRoutes,
      ];
}
