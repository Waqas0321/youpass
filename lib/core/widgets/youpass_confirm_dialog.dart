import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/theme/youpass_button_theme.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_design_spec.dart';

enum YouPassConfirmDialogVariant { logout, deleteAccount }

class YouPassConfirmDialog extends StatelessWidget {
  const YouPassConfirmDialog({
    super.key,
    required this.variant,
  });

  final YouPassConfirmDialogVariant variant;

  static Future<bool> showLogout(BuildContext context) {
    return _show(context, YouPassConfirmDialogVariant.logout);
  }

  static Future<bool> showDeleteAccount(BuildContext context) {
    return _show(context, YouPassConfirmDialogVariant.deleteAccount);
  }

  static Future<bool> _show(
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

  bool get _isDestructive => variant == YouPassConfirmDialogVariant.deleteAccount;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final title = _isDestructive
        ? AppStrings.confirmDeleteAccountTitle(strings)
        : AppStrings.confirmLogoutTitle(strings);
    final message = _isDestructive
        ? AppStrings.confirmDeleteAccountMessage(strings)
        : AppStrings.confirmLogoutMessage(strings);
    final confirmLabel = _isDestructive
        ? AppStrings.confirmDeleteAccountAction(strings)
        : AppStrings.confirmLogoutAction(strings);
    final cancelLabel = AppStrings.confirmDialogCancel(strings);

    final iconData =
        _isDestructive ? Icons.warning_amber_rounded : Icons.logout_rounded;
    final iconColor =
        _isDestructive ? AppColors.profileDeleteRed : ProfileDesignSpec.primary;
    final iconBackground = _isDestructive
        ? AppColors.profileDeleteRed.withValues(alpha: 0.12)
        : ProfileDesignSpec.iconCircleBackground;

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 28),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.profileCardBackground,
          borderRadius: BorderRadius.circular(ProfileDesignSpec.cardRadius),
          border: Border.all(
            color: AppColors.profileCardBorder,
            width: ProfileDesignSpec.cardBorderWidth,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.scrimBase.withValues(alpha: 0.12),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: iconBackground,
                  shape: BoxShape.circle,
                ),
                child: Icon(iconData, size: 28, color: iconColor),
              ),
              const SizedBox(height: 20),
              AppText(
                title,
                variant: AppTextVariant.title,
                textAlign: TextAlign.center,
                color: AppColors.darkNavy,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
              const SizedBox(height: 12),
              AppText(
                message,
                variant: AppTextVariant.body,
                textAlign: TextAlign.center,
                color: AppColors.profileLabelGrey,
                fontSize: 14,
                height: 1.45,
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: _ConfirmActionButton(
                  label: confirmLabel,
                  isDestructive: _isDestructive,
                  onPressed: () => Navigator.of(context).pop(true),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  style: YouPassButtonTheme.outlineElevatedStyle().copyWith(
                    elevation: WidgetStateProperty.all(0),
                  ),
                  child: Text(
                    cancelLabel,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.outlineButtonForeground,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ConfirmActionButton extends StatelessWidget {
  const _ConfirmActionButton({
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
        : AppColors.primaryMustard;
    final foregroundColor =
        isDestructive ? AppColors.backgroundWhite : AppColors.darkNavy;

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
