import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';
import 'package:youpass/features/invitations/presentation/widgets/invitation_outline_action_button_widget.dart';

class InvitationCardSecondaryActionsWidget extends StatelessWidget {
  const InvitationCardSecondaryActionsWidget({
    super.key,
    this.leftLabel,
    this.onLeftPressed,
    this.onViewQr,
    this.isLeftLoading = false,
    this.isViewQrLoading = false,
    this.isQrAvailable = true,
    this.leftIsReject = false,
  });

  final String? leftLabel;
  final VoidCallback? onLeftPressed;
  final VoidCallback? onViewQr;
  final bool isLeftLoading;
  final bool isViewQrLoading;
  final bool isQrAvailable;
  final bool leftIsReject;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return Row(
      children: [
        if (leftLabel != null) ...[
          Expanded(
            child: InvitationOutlineActionButtonWidget(
              label: leftLabel!,
              onPressed: onLeftPressed,
              isLoading: isLeftLoading,
              style: leftIsReject
                  ? InvitationOutlineButtonStyle.reject
                  : InvitationOutlineButtonStyle.primary,
            ),
          ),
          SizedBox(width: InvitationsDesignSpec.px(context, 8)),
        ],
        Expanded(
          child: InvitationOutlineActionButtonWidget(
            label: AppStrings.invitationsViewQr(strings),
            icon: Icons.qr_code_2_outlined,
            onPressed: onViewQr,
            isLoading: isViewQrLoading,
            style: isQrAvailable
                ? InvitationOutlineButtonStyle.primary
                : InvitationOutlineButtonStyle.muted,
          ),
        ),
      ],
    );
  }
}
