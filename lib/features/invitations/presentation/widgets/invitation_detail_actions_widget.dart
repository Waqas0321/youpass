import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_entity.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_status_extensions.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';
import 'package:youpass/features/invitations/presentation/utils/invitations_screen_actions.dart';
import 'package:youpass/features/invitations/presentation/widgets/invitation_card_secondary_actions_widget.dart';
import 'package:youpass/features/invitations/presentation/widgets/invitation_filled_action_button_widget.dart';

/// Shared action panel for list cards and detail screens (free / discounted).
class InvitationDetailActionsWidget extends StatelessWidget {
  const InvitationDetailActionsWidget({
    super.key,
    required this.invitation,
    this.confirmLabel,
    this.confirmBackgroundColor,
  });

  final InvitationEntity invitation;
  final String? confirmLabel;
  final Color? confirmBackgroundColor;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final actions = InvitationsScreenActions(context);
    final isPending = invitation.status.isPending;
    final isConfirmed = invitation.status.isAccepted;

    if (!isPending && !isConfirmed) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: InvitationsDesignSpec.px(context, 20)),
        if (isPending) ...[
          InvitationFilledActionButtonWidget(
            label: confirmLabel ?? AppStrings.invitationsConfirmAttendance(strings),
            onPressed: () => actions.confirmAttendance(invitation),
            backgroundColor: confirmBackgroundColor ?? InvitationsDesignSpec.primary,
          ),
          SizedBox(height: InvitationsDesignSpec.px(context, 8)),
          InvitationCardSecondaryActionsWidget(
            leftLabel: AppStrings.invitationsReject(strings),
            onLeftPressed:
                invitation.canReject ? () => actions.rejectInvitation(invitation.id) : null,
            onViewQr: () => actions.openTicket(invitation),
            isQrAvailable: invitation.canFetchQrFromApi,
            leftIsReject: true,
          ),
        ],
        if (isConfirmed) ...[
          InvitationFilledActionButtonWidget(
            label: AppStrings.invitationsAttendanceConfirmed(strings),
            enabled: false,
          ),
          SizedBox(height: InvitationsDesignSpec.px(context, 8)),
          InvitationCardSecondaryActionsWidget(
            onViewQr: () => actions.openTicket(invitation),
            isQrAvailable: invitation.canFetchQrFromApi,
          ),
        ],
      ],
    );
  }
}
