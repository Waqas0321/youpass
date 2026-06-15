import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/theme/invitations_screen_theme.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_entity.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_status_extensions.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';
import 'package:youpass/features/invitations/presentation/utils/guaranteed_pass_flow_actions.dart';
import 'package:youpass/features/invitations/presentation/widgets/invitation_filled_action_button_widget.dart';

class InvitationDetailGuaranteedPassPanelWidget extends StatelessWidget {
  const InvitationDetailGuaranteedPassPanelWidget({
    super.key,
    required this.invitation,
  });

  final InvitationEntity invitation;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final isPending = invitation.status.isPending;
    final amount = invitation.noShowChargeLabel ?? '—';
    final deadline = invitation.cancellationDeadlineLabel ?? '—';
    final actions = GuaranteedPassFlowActions(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: InvitationsDesignSpec.px(context, 16)),
        Container(
          padding: EdgeInsets.all(InvitationsDesignSpec.px(context, 14)),
          decoration: BoxDecoration(
            color: InvitationsDesignSpec.warningIconBackground.withValues(
              alpha: InvitationsScreenTheme.isDark(context) ? 0.35 : 1,
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: InvitationsDesignSpec.guaranteedTypeGold.withValues(alpha: 0.6),
              width: 1.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.invitationsGpWarningTitle(strings),
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: InvitationsDesignSpec.px(context, 15),
                  color: InvitationsDesignSpec.guaranteedTypeGold,
                ),
              ),
              SizedBox(height: InvitationsDesignSpec.px(context, 8)),
              Text(
                AppStrings.invitationsGpWarningBody(strings, amount, deadline),
                style: TextStyle(
                  fontSize: InvitationsDesignSpec.px(context, 13),
                  height: 1.45,
                  color: InvitationsScreenTheme.body(context),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: InvitationsDesignSpec.px(context, 20)),
        if (isPending) ...[
          InvitationFilledActionButtonWidget(
            label: AppStrings.invitationsAcceptAndReserve(strings),
            onPressed: () => actions.acceptFromDetail(invitation),
            backgroundColor: InvitationsDesignSpec.guaranteedTypeGold,
          ),
          SizedBox(height: InvitationsDesignSpec.px(context, 10)),
          TextButton(
            onPressed: () => actions.reject(invitation.id),
            child: Text(
              AppStrings.invitationsReject(strings),
              style: TextStyle(
                color: InvitationsScreenTheme.body(context),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ] else if (invitation.canCancel) ...[
          OutlinedButton(
            onPressed: () => actions.cancelConfirmedPass(invitation),
            child: Text(AppStrings.invitationsCancelInvitation(strings)),
          ),
        ],
      ],
    );
  }
}
