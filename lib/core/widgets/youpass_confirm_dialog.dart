import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/theme/youpass_button_theme.dart';
import 'package:youpass/core/theme/youpass_dialog_theme.dart';
import 'package:youpass/core/theme/youpass_theme_extension.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/core/widgets/dialogs/youpass_dialog_icon_badge.dart';
import 'package:youpass/core/widgets/dialogs/youpass_themed_dialog_shell.dart';

enum YouPassConfirmDialogVariant { logout, deleteAccount, exitApp }

class YouPassConfirmDialog extends StatelessWidget {
  const YouPassConfirmDialog({
    super.key,
    required this.variant,
  });

  final YouPassConfirmDialogVariant variant;

  static Future<bool> showLogout(BuildContext context) {
    return showConfirm(context, YouPassConfirmDialogVariant.logout);
  }

  static Future<bool> showDeleteAccount(BuildContext context) {
    return showConfirm(context, YouPassConfirmDialogVariant.deleteAccount);
  }

  static Future<bool> showExitApp(BuildContext context) {
    return showConfirm(context, YouPassConfirmDialogVariant.exitApp);
  }

  static Future<bool> showConfirm(
    BuildContext context,
    YouPassConfirmDialogVariant variant,
  ) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      barrierColor: AppColors.scrimBase.withValues(alpha: 0.45),
      builder: (dialogContext) => YouPassConfirmDialog(variant: variant),
    );
    return result ?? false;
  }

  bool get isDestructive =>
      variant == YouPassConfirmDialogVariant.deleteAccount ||
      variant == YouPassConfirmDialogVariant.exitApp;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final String title;
    final String message;
    final String confirmLabel;
    final String cancelLabel;
    final IconData iconData;

    switch (variant) {
      case YouPassConfirmDialogVariant.deleteAccount:
        title = AppStrings.confirmDeleteAccountTitle(strings);
        message = AppStrings.confirmDeleteAccountMessage(strings);
        confirmLabel = AppStrings.confirmDeleteAccountAction(strings);
        cancelLabel = AppStrings.confirmDialogCancel(strings);
        iconData = Icons.warning_amber_rounded;
      case YouPassConfirmDialogVariant.logout:
        title = AppStrings.confirmLogoutTitle(strings);
        message = AppStrings.confirmLogoutMessage(strings);
        confirmLabel = AppStrings.confirmLogoutAction(strings);
        cancelLabel = AppStrings.confirmDialogCancel(strings);
        iconData = Icons.logout_rounded;
      case YouPassConfirmDialogVariant.exitApp:
        title = AppStrings.confirmExitAppTitle(strings);
        message = AppStrings.confirmExitAppMessage(strings);
        confirmLabel = AppStrings.confirmExitAppAction(strings);
        cancelLabel = AppStrings.confirmExitAppStay(strings);
        iconData = Icons.exit_to_app_rounded;
    }

    final iconColor = variant == YouPassConfirmDialogVariant.deleteAccount
        ? AppColors.profileDeleteRed
        : YouPassDialogTheme.iconColor(context);
    final iconBackground =
        variant == YouPassConfirmDialogVariant.deleteAccount
            ? YouPassDialogTheme.destructiveIconBackground(context)
            : YouPassDialogTheme.iconBadgeBackground(context);

    return YouPassThemedDialogShell(
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          YouPassDialogIconBadge(
            icon: iconData,
            iconSize: 28,
            backgroundColor: iconBackground,
            iconColor: iconColor,
          ),
          const SizedBox(height: 20),
          AppText(
            title,
            variant: AppTextVariant.title,
            textAlign: TextAlign.center,
            color: YouPassDialogTheme.title(context),
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
          const SizedBox(height: 12),
          AppText(
            message,
            variant: AppTextVariant.body,
            textAlign: TextAlign.center,
            color: YouPassDialogTheme.body(context),
            fontSize: 14,
            height: 1.45,
          ),
          const SizedBox(height: 28),
          SizedBox(
            width: double.infinity,
            child: YouPassConfirmActionButton(
              label: confirmLabel,
              isDestructive: isDestructive,
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => Navigator.of(context).pop(false),
              style: YouPassButtonTheme.outlineElevatedStyle(context).copyWith(
                elevation: WidgetStateProperty.all(0),
              ),
              child: Text(
                cancelLabel,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: YouPassThemeExtension.of(context)
                      .outlineButtonForeground,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class YouPassConfirmActionButton extends StatelessWidget {
  const YouPassConfirmActionButton({
    super.key,
    required this.label,
    required this.isDestructive,
    required this.onPressed,
  });

  final String label;
  final bool isDestructive;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isDestructive
        ? AppColors.profileDeleteRed
        : YouPassDialogTheme.primaryButtonBackground(context);
    final foregroundColor = isDestructive
        ? AppColors.backgroundWhite
        : YouPassDialogTheme.primaryButtonForeground(context);

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: isDestructive ? 0 : 2,
        shadowColor: AppColors.scrimBase.withValues(alpha: 0.18),
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            YouPassButtonTheme.outlineBorderRadius,
          ),
        ),
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
      child: Text(label),
    );
  }
}
