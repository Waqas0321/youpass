import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/features/auth/presentation/providers/auth_provider.dart';
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

  static String greetingName(
    AuthProvider authProvider,
    AppLocalizations strings,
  ) {
    final rawName = authProvider.currentUser?.name.trim() ??
        authProvider.userProfile?.fullName.trim();

    if (rawName == null || rawName.isEmpty) {
      return AppStrings.defaultGuestName(strings);
    }

    final firstName = rawName.split(RegExp(r'\s+')).first;
    if (firstName.length == 1) {
      return firstName.toUpperCase();
    }

    return firstName[0].toUpperCase() + firstName.substring(1);
  }
}
