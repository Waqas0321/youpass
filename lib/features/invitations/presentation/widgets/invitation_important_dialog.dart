import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/theme/youpass_dialog_theme.dart';
import 'package:youpass/core/widgets/dialogs/youpass_dialog_icon_badge.dart';
import 'package:youpass/core/widgets/dialogs/youpass_dialog_primary_button.dart';
import 'package:youpass/core/widgets/dialogs/youpass_themed_dialog_shell.dart';

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

    return YouPassThemedDialogShell(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const YouPassDialogIconBadge(icon: Icons.warning_amber_rounded, iconSize: 32),
          const SizedBox(height: 16),
          Text(
            AppStrings.invitationsImportantTitle(strings),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: YouPassDialogTheme.title(context),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            AppStrings.invitationsImportantMessage(strings),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: YouPassDialogTheme.body(context),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 20),
          YouPassDialogPrimaryButton(
            label: AppStrings.invitationsAddPaymentMethod(strings),
            onPressed: () => Navigator.of(context).pop(true),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              AppStrings.confirmDialogCancel(strings),
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
