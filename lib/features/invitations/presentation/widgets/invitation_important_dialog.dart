import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';

class InvitationImportantDialog extends StatelessWidget {
  const InvitationImportantDialog({super.key});

  static Future<bool> show(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (_) => const InvitationImportantDialog(),
    );
    return result ?? false;
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
                  color: InvitationsDesignSpec.warningIconBackground,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.warning_amber_rounded,
                  color: InvitationsDesignSpec.primary,
                  size: 32,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                AppStrings.invitationsImportantTitle(strings),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: InvitationsDesignSpec.titleText,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                AppStrings.invitationsImportantMessage(strings),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: InvitationsDesignSpec.bodyText,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 44,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: InvitationsDesignSpec.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    AppStrings.invitationsAddPaymentMethod(strings),
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  AppStrings.confirmDialogCancel(strings),
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
