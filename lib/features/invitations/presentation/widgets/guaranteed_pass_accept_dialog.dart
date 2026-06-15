import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/theme/youpass_dialog_theme.dart';
import 'package:youpass/core/widgets/dialogs/youpass_dialog_icon_badge.dart';
import 'package:youpass/core/widgets/dialogs/youpass_dialog_outline_button.dart';
import 'package:youpass/core/widgets/dialogs/youpass_dialog_primary_button.dart';
import 'package:youpass/core/widgets/dialogs/youpass_themed_dialog_shell.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_entity.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';

class GuaranteedPassAcceptDialog extends StatefulWidget {
  const GuaranteedPassAcceptDialog({super.key, required this.invitation});

  final InvitationEntity invitation;

  static Future<bool> show(BuildContext context, InvitationEntity invitation) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      useRootNavigator: true,
      builder: (dialogContext) => GuaranteedPassAcceptDialog(invitation: invitation),
    );
    return result ?? false;
  }

  @override
  State<GuaranteedPassAcceptDialog> createState() =>
      _GuaranteedPassAcceptDialogState();
}

class _GuaranteedPassAcceptDialogState extends State<GuaranteedPassAcceptDialog> {
  bool termsAccepted = false;
  bool showTermsError = false;

  void _accept() {
    if (!termsAccepted) {
      setState(() => showTermsError = true);
      return;
    }

    Navigator.of(context, rootNavigator: true).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final deadline = widget.invitation.cancellationDeadlineLabel ?? '—';
    final amount = widget.invitation.noShowChargeLabel ??
        widget.invitation.chargeAmount?.toStringAsFixed(0) ??
        '—';

    return YouPassThemedDialogShell(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const YouPassDialogIconBadge(
              icon: Icons.verified_user_outlined,
              iconSize: 32,
            ),
            const SizedBox(height: 16),
            Text(
              AppStrings.invitationsGuaranteedPassTitle(strings),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: InvitationsDesignSpec.guaranteedTypeGold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              AppStrings.invitationsGuaranteedPassMessage(strings, deadline, amount),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: YouPassDialogTheme.body(context),
                height: 1.4,
              ),
            ),
            if (widget.invitation.customMessage?.isNotEmpty == true) ...[
              const SizedBox(height: 10),
              Text(
                widget.invitation.customMessage!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: YouPassDialogTheme.body(context),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
            const SizedBox(height: 12),
            Text(
              AppStrings.invitationsPreauthNotice(strings, amount),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: YouPassDialogTheme.body(context),
              ),
            ),
            const SizedBox(height: 12),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: termsAccepted,
              onChanged: (value) => setState(() {
                termsAccepted = value ?? false;
                showTermsError = false;
              }),
              title: Text(
                AppStrings.invitationsGuaranteedPassTerms(strings),
                style: TextStyle(
                  fontSize: 13,
                  color: YouPassDialogTheme.body(context),
                ),
              ),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            if (showTermsError) ...[
              Text(
                AppStrings.invitationsGpTermsRequired(strings),
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
              const SizedBox(height: 8),
            ],
            const SizedBox(height: 12),
            YouPassDialogPrimaryButton(
              label: AppStrings.invitationsAcceptGuaranteed(strings),
              enabled: termsAccepted,
              onPressed: _accept,
            ),
            const SizedBox(height: 8),
            YouPassDialogOutlineButton(
              label: AppStrings.invitationsDialogCancel(strings),
              onPressed: () => Navigator.of(context, rootNavigator: true).pop(false),
            ),
          ],
        ),
      ),
    );
  }
}
