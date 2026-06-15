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

class DiscountedAcceptDialog extends StatelessWidget {
  const DiscountedAcceptDialog({super.key, required this.invitation});

  final InvitationEntity invitation;

  static Future<bool> show(BuildContext context, InvitationEntity invitation) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (_) => DiscountedAcceptDialog(invitation: invitation),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final amount = invitation.acceptAmountLabel ??
        invitation.chargeAmount?.toStringAsFixed(0) ??
        '—';
    final discount = invitation.discountPercent;

    return YouPassThemedDialogShell(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const YouPassDialogIconBadge(
            icon: Icons.local_offer_outlined,
            iconSize: 32,
          ),
          const SizedBox(height: 16),
          Text(
            AppStrings.invitationsDiscountedPayTitle(strings),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: InvitationsDesignSpec.discountedTypePurple,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            AppStrings.invitationsDiscountedPayMessage(strings, amount),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: YouPassDialogTheme.body(context),
              height: 1.4,
            ),
          ),
          if (discount != null) ...[
            const SizedBox(height: 8),
            Text(
              AppStrings.invitationsDiscountPercent(strings, discount),
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: InvitationsDesignSpec.discountedTypePurple,
              ),
            ),
          ],
          const SizedBox(height: 20),
          YouPassDialogPrimaryButton(
            label: AppStrings.invitationsAcceptDiscounted(strings),
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
