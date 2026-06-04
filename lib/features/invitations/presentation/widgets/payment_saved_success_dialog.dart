import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/theme/youpass_dialog_theme.dart';
import 'package:youpass/core/widgets/dialogs/youpass_dialog_icon_badge.dart';
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
              color: YouPassDialogTheme.title(context),
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
          PaymentSavedReminderRowWidget(
            icon: Icons.warning_amber_rounded,
            text: AppStrings.invitationsCardSavedReminderCharge(strings),
          ),
          const SizedBox(height: 8),
          PaymentSavedReminderRowWidget(
            icon: Icons.schedule,
            text: AppStrings.invitationsCardSavedReminderCancel(strings),
          ),
          const SizedBox(height: 20),
          YouPassDialogPrimaryButton(
            label: AppStrings.invitationsConfirmAttendance(strings),
            onPressed: () {
              Navigator.of(context).pop();
              onConfirmAttendance();
            },
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onReject();
            },
            child: Text(
              AppStrings.invitationsReject(strings),
              style: TextStyle(
                color: YouPassDialogTheme.cancelText(context),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
