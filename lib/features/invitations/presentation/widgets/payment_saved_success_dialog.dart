import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';
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

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 28),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: InvitationsDesignSpec.dialogBackground,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: InvitationsDesignSpec.dialogBorder),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: const BoxDecoration(
                  color: Color(0xFFE8F5E9),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle,
                  color: InvitationsDesignSpec.successGreen,
                  size: 34,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                AppStrings.invitationsCardSavedTitle(strings),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: InvitationsDesignSpec.titleText,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                AppStrings.invitationsCardSavedMessage(strings),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: InvitationsDesignSpec.bodyText,
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
              SizedBox(
                width: double.infinity,
                height: 44,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    onConfirmAttendance();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: InvitationsDesignSpec.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    AppStrings.invitationsConfirmAttendance(strings),
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  onReject();
                },
                child: Text(
                  AppStrings.invitationsReject(strings),
                  style: const TextStyle(
                    color: InvitationsDesignSpec.bodyText,
                    fontWeight: FontWeight.w600,
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
