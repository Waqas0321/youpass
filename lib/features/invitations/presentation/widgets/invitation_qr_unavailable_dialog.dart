import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';

class InvitationQrUnavailableDialog extends StatelessWidget {
  const InvitationQrUnavailableDialog({
    super.key,
    required this.title,
    required this.message,
    this.subtitle,
  });

  final String title;
  final String message;
  final String? subtitle;

  static Future<void> show(
    BuildContext context, {
    required String title,
    required String message,
    String? subtitle,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (_) => InvitationQrUnavailableDialog(
        title: title,
        message: message,
        subtitle: subtitle,
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
                  color: InvitationsDesignSpec.warningIconBackground,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.qr_code_2_outlined,
                  color: InvitationsDesignSpec.primary,
                  size: 30,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: InvitationsDesignSpec.titleText,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: InvitationsDesignSpec.bodyText,
                  height: 1.4,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 8),
                Text(
                  subtitle!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: InvitationsDesignSpec.statusPending,
                    height: 1.4,
                  ),
                ),
              ],
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 44,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: InvitationsDesignSpec.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    AppStrings.invitationsQrGotIt(strings),
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
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
