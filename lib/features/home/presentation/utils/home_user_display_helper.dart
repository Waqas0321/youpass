import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/features/auth/presentation/providers/auth_provider.dart';
import 'package:youpass/features/home/domain/entities/drawer_membership_tier.dart';
import 'package:youpass/features/home/presentation/utils/drawer_tier_label_formatter.dart';
import 'package:youpass/features/home/presentation/utils/home_greeting_formatter.dart';
import 'package:youpass/l10n/app_localizations.dart';

class HomeUserDisplayHelper {
  HomeUserDisplayHelper._();

  static String drawerFullName(
    AuthProvider authProvider,
    AppLocalizations strings,
  ) {
    final profileName = authProvider.userProfile?.fullName.trim();
    if (profileName != null && profileName.isNotEmpty) {
      return profileName;
    }

    final userName = authProvider.currentUser?.name.trim();
    if (userName != null && userName.isNotEmpty) {
      return userName;
    }

    return AppStrings.defaultGuestName(strings);
  }

  static String drawerFirstName(
    AuthProvider authProvider,
    AppLocalizations strings,
  ) {
    final fullName = drawerFullName(authProvider, strings);
    final parts = fullName.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) {
      return fullName;
    }
    final token = parts.first;
    if (token.length == 1) {
      return token.toUpperCase();
    }
    return token[0].toUpperCase() + token.substring(1).toLowerCase();
  }

  static DrawerMembershipTier membershipTier(AuthProvider authProvider) {
    return DrawerMembershipTierMapper.fromCategory(
      authProvider.userProfile?.category,
    );
  }

  static String membershipTierLabel(
    AuthProvider authProvider,
    AppLocalizations strings,
  ) {
    return DrawerTierLabelFormatter.label(
      strings,
      membershipTier(authProvider),
    );
  }

  static String greetingName(
    AuthProvider authProvider,
    AppLocalizations strings,
  ) {
    final rawName = _rawFullName(authProvider);

    if (rawName == null || rawName.isEmpty) {
      return AppStrings.defaultGuestName(strings);
    }

    return HomeGreetingFormatter.abbreviatedName(rawName);
  }

  /// Header row: `Hi, {name}!` — API pre-formatted string wins, else local abbreviation.
  static String headerGreetingText(
    AuthProvider authProvider,
    AppLocalizations strings, {
    String? apiGreeting,
  }) {
    final fromApi = apiGreeting?.trim();
    if (fromApi != null && fromApi.isNotEmpty) {
      return fromApi;
    }

    return AppStrings.homeGreeting(strings, greetingName(authProvider, strings));
  }

  static String? _rawFullName(AuthProvider authProvider) {
    final profileName = authProvider.userProfile?.fullName.trim();
    if (profileName != null && profileName.isNotEmpty) {
      return profileName;
    }

    final userName = authProvider.currentUser?.name.trim();
    if (userName != null && userName.isNotEmpty) {
      return userName;
    }

    return null;
  }
}
