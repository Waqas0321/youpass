import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/theme/youpass_dialog_theme.dart';
import 'package:youpass/core/widgets/dialogs/youpass_dialog_icon_badge.dart';
import 'package:youpass/core/widgets/dialogs/youpass_dialog_outline_button.dart';
import 'package:youpass/core/widgets/dialogs/youpass_dialog_primary_button.dart';
import 'package:youpass/core/widgets/dialogs/youpass_themed_dialog_shell.dart';
import 'package:youpass/features/invitations/presentation/widgets/payment_saved_reminder_row_widget.dart';

class PaymentSavedSuccessDialog extends StatelessWidget {
  const PaymentSavedSuccessDialog({
    super.key,
    required this.onConfirmAttendance,
    required this.onReject,
  });

  final VoidCallback onConfirmAttendance;
  final VoidCallback onReject;

  static Future<void> show(
    BuildContext context, {
    required VoidCallback onConfirmAttendance,
    required VoidCallback onReject,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => PaymentSavedSuccessDialog(
        onConfirmAttendance: onConfirmAttendance,
        onReject: onReject,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return YouPassThemedDialogShell(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          YouPassDialogIconBadge(
            icon: Icons.check_circle,
            iconSize: 34,
            backgroundColor: YouPassDialogTheme.successIconBadgeBackground(context),
            iconColor: YouPassDialogTheme.successIconColor(context),
          ),
          const SizedBox(height: 16),
          Text(
            AppStrings.invitationsCardSavedTitle(strings),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: YouPassDialogTheme.successTitle(context),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            AppStrings.invitationsCardSavedMessage(strings),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: YouPassDialogTheme.body(context),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: YouPassDialogTheme.infoPanelBackground(context),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: YouPassDialogTheme.border(context),
              ),
            ),
            child: Column(
              children: [
                PaymentSavedReminderRowWidget(
                  icon: Icons.warning_amber_rounded,
                  text: AppStrings.invitationsCardSavedReminderCharge(strings),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Divider(
                    height: 1,
                    thickness: 1,
                    color: YouPassDialogTheme.border(context).withValues(
                      alpha: YouPassDialogTheme.isDark(context) ? 0.6 : 1,
                    ),
                  ),
                ),
                PaymentSavedReminderRowWidget(
                  icon: Icons.schedule,
                  text: AppStrings.invitationsCardSavedReminderCancel(strings),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          YouPassDialogPrimaryButton(
            label: AppStrings.invitationsConfirmAttendance(strings),
            onPressed: () {
              Navigator.of(context).pop();
              onConfirmAttendance();
            },
          ),
          const SizedBox(height: 8),
          YouPassDialogOutlineButton(
            label: AppStrings.invitationsReject(strings),
            onPressed: () {
              Navigator.of(context).pop();
              onReject();
            },
          ),
        ],
      ),
    );
  }
}
