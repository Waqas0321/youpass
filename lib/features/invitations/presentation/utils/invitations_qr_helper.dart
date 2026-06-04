import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/l10n/app_localizations.dart';

class InvitationsQrHelper {
  InvitationsQrHelper._();

  static String pendingTitle(AppLocalizations strings) =>
      AppStrings.invitationsQrPendingTitle(strings);

  static String pendingMessage(AppLocalizations strings) =>
      AppStrings.invitationsQrPendingMessage(strings);

  static String lockedTitle(AppLocalizations strings) =>
      AppStrings.invitationsQrLockedTitle(strings);

  static String lockedMessage(AppLocalizations strings) =>
      AppStrings.invitationsQrLockedMessage(strings);

  static String expiredTitle(AppLocalizations strings) =>
      AppStrings.invitationsQrExpiredTitle(strings);

  static String expiredMessage(AppLocalizations strings) =>
      AppStrings.invitationsQrExpiredMessage(strings);

  static String? unlockSubtitle(
    AppLocalizations strings,
    BuildContext context,
    Map<String, dynamic>? details,
  ) {
    final unlockAt = details?['unlock_at'] ?? details?['unlockAt'];
    final formatted = formatUnlockAt(context, unlockAt);
    if (formatted == null) {
      return null;
    }
    return AppStrings.invitationsQrUnlockAt(strings, formatted);
  }

  static String? formatUnlockAt(BuildContext context, Object? unlockAt) {
    if (unlockAt == null) {
      return null;
    }

    try {
      final date = DateTime.parse(unlockAt.toString()).toLocal();
      final locale = Localizations.localeOf(context).toString();
      return DateFormat.yMMMMd(locale).add_jm().format(date);
    } catch (_) {
      return null;
    }
  }
}
