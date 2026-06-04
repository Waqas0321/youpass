import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/theme/youpass_dialog_theme.dart';
import 'package:youpass/core/widgets/dialogs/youpass_dialog_icon_badge.dart';
import 'package:youpass/core/widgets/dialogs/youpass_dialog_primary_button.dart';
import 'package:youpass/core/widgets/dialogs/youpass_themed_dialog_shell.dart';

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

    return YouPassThemedDialogShell(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const YouPassDialogIconBadge(icon: Icons.qr_code_2_outlined),
          const SizedBox(height: 16),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: YouPassDialogTheme.title(context),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: YouPassDialogTheme.body(context),
              height: 1.4,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 8),
            Text(
              subtitle!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: YouPassDialogTheme.iconColor(context),
                height: 1.4,
              ),
            ),
          ],
          const SizedBox(height: 20),
          YouPassDialogPrimaryButton(
            label: AppStrings.invitationsQrGotIt(strings),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
