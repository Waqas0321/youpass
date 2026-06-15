import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/security/device_auth_service.dart';
import 'package:youpass/core/widgets/app_snack_bar.dart';
import 'package:youpass/dependency_injection/injection_container.dart';
import 'package:youpass/features/profile/data/services/profile_api_service.dart';

class AccountDeletionActions {
  const AccountDeletionActions(this.context);

  final BuildContext context;

  Future<bool> confirmWithDeviceAuth(String reason) {
    return sl<DeviceAuthService>().authenticate(reason: reason);
  }

  Future<bool> cancelPendingDeletion() async {
    final strings = context.l10n;
    final authenticated = await confirmWithDeviceAuth(
      AppStrings.accountDeletionBiometricReason(strings),
    );

    if (!authenticated) {
      if (context.mounted) {
        AppSnackBar.show(context, AppStrings.accountDeletionBiometricFailed(strings));
      }
      return false;
    }

    try {
      await sl<ProfileApiService>().cancelAccountDeletion();
      if (context.mounted) {
        AppSnackBar.show(context, AppStrings.accountDeletionCancelled(strings));
      }
      return true;
    } catch (_) {
      if (context.mounted) {
        AppSnackBar.show(context, strings.errorGeneric);
      }
      return false;
    }
  }
}
