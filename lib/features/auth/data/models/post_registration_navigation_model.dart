import 'package:youpass/core/utils/json_readers.dart';
import 'package:youpass/features/auth/domain/entities/post_registration_navigation_entity.dart';

class PostRegistrationNavigationModel extends PostRegistrationNavigationEntity {
  const PostRegistrationNavigationModel({
    super.flow,
    super.navigateTo,
    super.showWelcomeScreen,
    super.welcomeDurationSeconds,
    super.openHamburgerMenu,
    super.openProfile,
    super.showOnboarding,
    super.requestPermissions,
    super.showPartyModeBanner,
    super.highlightPendingInvitation,
    super.linkedInvitationsCount,
    super.preloadEndpoint,
    super.forbiddenRoutes,
  });

  factory PostRegistrationNavigationModel.fromJson(Map<String, dynamic> json) {
    final forbiddenRaw = json['forbidden_routes'] ?? json['forbiddenRoutes'];
    final forbiddenRoutes = <String>[];
    if (forbiddenRaw is List) {
      for (final item in forbiddenRaw) {
        forbiddenRoutes.add(item.toString());
      }
    }

    return PostRegistrationNavigationModel(
      flow: JsonReaders.string(json, 'flow', fallback: 'welcome_then_home'),
      navigateTo: JsonReaders.string(
        json,
        'navigate_to',
        fallback: JsonReaders.string(json, 'navigateTo', fallback: 'you_home'),
      ),
      showWelcomeScreen: JsonReaders.boolean(
        json,
        'show_welcome_screen',
        fallback: JsonReaders.boolean(json, 'showWelcomeScreen', fallback: true),
      ),
      welcomeDurationSeconds: JsonReaders.integer(
        json,
        'welcome_duration_seconds',
        fallback: JsonReaders.integer(
          json,
          'welcomeDurationSeconds',
          fallback: 2,
        ),
      ),
      openHamburgerMenu: JsonReaders.boolean(
        json,
        'open_hamburger_menu',
        fallback: JsonReaders.boolean(json, 'openHamburgerMenu', fallback: false),
      ),
      openProfile: JsonReaders.boolean(
        json,
        'open_profile',
        fallback: JsonReaders.boolean(json, 'openProfile', fallback: false),
      ),
      showOnboarding: JsonReaders.boolean(
        json,
        'show_onboarding',
        fallback: JsonReaders.boolean(json, 'showOnboarding', fallback: false),
      ),
      requestPermissions: JsonReaders.boolean(
        json,
        'request_permissions',
        fallback: JsonReaders.boolean(json, 'requestPermissions', fallback: false),
      ),
      showPartyModeBanner: JsonReaders.boolean(
        json,
        'show_party_mode_banner',
        fallback: JsonReaders.boolean(json, 'showPartyModeBanner', fallback: false),
      ),
      highlightPendingInvitation: JsonReaders.boolean(
        json,
        'highlight_pending_invitation',
        fallback: JsonReaders.boolean(
          json,
          'highlightPendingInvitation',
          fallback: false,
        ),
      ),
      linkedInvitationsCount: JsonReaders.integer(
        json,
        'linked_invitations_count',
        fallback: JsonReaders.integer(json, 'linkedInvitationsCount'),
      ),
      preloadEndpoint: JsonReaders.nullableString(json, 'preload_endpoint') ??
          JsonReaders.nullableString(json, 'preloadEndpoint'),
      forbiddenRoutes: forbiddenRoutes.isEmpty
          ? const PostRegistrationNavigationEntity().forbiddenRoutes
          : forbiddenRoutes,
    );
  }
}
