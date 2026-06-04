import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/network/models/api_error_details_model.dart';
import 'package:youpass/l10n/app_localizations.dart';

class InvitationsQrHelper {
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
    ApiErrorDetailsModel? details,
  ) {
    final formatted = formatUnlockAt(context, details?.unlockAt);
    if (formatted == null) {
      return null;
    }
    return AppStrings.invitationsQrUnlockAt(strings, formatted);
  }

  static String? formatUnlockAt(BuildContext context, DateTime? unlockAt) {
    if (unlockAt == null) {
      return null;
    }

    try {
      final date = unlockAt.toLocal();
      final locale = Localizations.localeOf(context).toString();
      return DateFormat.yMMMMd(locale).add_jm().format(date);
    } catch (_) {
      return null;
    }
  }
}
