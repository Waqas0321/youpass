import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/theme/youpass_dialog_theme.dart';
import 'package:youpass/core/widgets/dialogs/youpass_dialog_outline_button.dart';
import 'package:youpass/core/widgets/dialogs/youpass_dialog_primary_button.dart';
import 'package:youpass/core/widgets/dialogs/youpass_themed_dialog_shell.dart';

class InvitationRejectConfirmDialog extends StatelessWidget {
  const InvitationRejectConfirmDialog({super.key});

  static Future<bool> show(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (_) => const InvitationRejectConfirmDialog(),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return YouPassThemedDialogShell(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppStrings.invitationsRejectConfirmTitle(strings),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            AppStrings.invitationsRejectConfirmMessage(strings),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: YouPassDialogTheme.body(context),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 20),
          YouPassDialogPrimaryButton(
            label: AppStrings.invitationsRejectConfirmAction(strings),
            onPressed: () => Navigator.of(context).pop(true),
          ),
          const SizedBox(height: 8),
          YouPassDialogOutlineButton(
            label: AppStrings.invitationsDialogCancel(strings),
            onPressed: () => Navigator.of(context).pop(false),
          ),
        ],
      ),
    );
  }
}
