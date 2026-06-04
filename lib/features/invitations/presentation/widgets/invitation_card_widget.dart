import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/widgets/event_network_image.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_entity.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_status.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';
import 'package:youpass/features/invitations/presentation/utils/invitations_text_factory.dart';
import 'package:youpass/features/invitations/presentation/widgets/invitation_filled_action_button_widget.dart';
import 'package:youpass/features/invitations/presentation/widgets/invitation_meta_row_widget.dart';
import 'package:youpass/features/invitations/presentation/widgets/invitation_outline_action_button_widget.dart';
import 'package:youpass/features/invitations/presentation/widgets/invitation_status_icon_widget.dart';
import 'package:youpass/features/invitations/presentation/widgets/invitation_status_line_widget.dart';

class InvitationCardWidget extends StatelessWidget {
  const InvitationCardWidget({
    super.key,
    required this.invitation,
    this.onConfirm,
    this.onReject,
    this.onCancel,
    this.onViewQr,
  });

  final InvitationEntity invitation;
  final VoidCallback? onConfirm;
  final VoidCallback? onReject;
  final VoidCallback? onCancel;
  final VoidCallback? onViewQr;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final isPending = invitation.status == InvitationStatus.pending;
    final isConfirmed = invitation.status == InvitationStatus.confirmed;
    final imageSize = InvitationsDesignSpec.px(context, 96);

    return Container(
      margin: EdgeInsets.only(bottom: InvitationsDesignSpec.px(context, 14)),
      padding: EdgeInsets.all(InvitationsDesignSpec.px(context, 12)),
      decoration: BoxDecoration(
        color: InvitationsDesignSpec.screenBackground,
        borderRadius: BorderRadius.circular(
          InvitationsDesignSpec.px(context, InvitationsDesignSpec.cardRadius),
        ),
        border: Border.all(color: InvitationsDesignSpec.cardBorder),
        boxShadow: const [
          BoxShadow(
            color: InvitationsDesignSpec.cardShadow,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildEventImage(context, imageSize),
          SizedBox(width: InvitationsDesignSpec.px(context, 12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        invitation.eventTitle,
                        style: TextStyle(
                          fontSize: InvitationsDesignSpec.px(context, 15),
                          fontWeight: FontWeight.w700,
                          color: InvitationsDesignSpec.titleText,
                          height: 1.2,
                        ),
                      ),
                    ),
                    SizedBox(width: InvitationsDesignSpec.px(context, 8)),
                    InvitationStatusIconWidget(status: invitation.status),
                  ],
                ),
                SizedBox(height: InvitationsDesignSpec.px(context, 8)),
                InvitationMetaRowWidget(
                  icon: Icons.location_on_outlined,
                  label: invitation.locationLabel,
                ),
                InvitationMetaRowWidget(
                  icon: Icons.calendar_today_outlined,
                  label: invitation.dateTimeLabel,
                ),
                InvitationMetaRowWidget(
                  icon: Icons.diamond_outlined,
                  label: InvitationsTextFactory.tierLabel(strings, invitation),
                ),
                SizedBox(height: InvitationsDesignSpec.px(context, 4)),
                InvitationStatusLineWidget(status: invitation.status),
                SizedBox(height: InvitationsDesignSpec.px(context, 10)),
                Divider(
                  height: 1,
                  thickness: 1,
                  color: InvitationsDesignSpec.cardBorder,
                ),
                SizedBox(height: InvitationsDesignSpec.px(context, 10)),
                if (isPending) ...[
                  InvitationFilledActionButtonWidget(
                    label: AppStrings.invitationsConfirmAttendance(strings),
                    onPressed: onConfirm,
                  ),
                  SizedBox(height: InvitationsDesignSpec.px(context, 8)),
                  _buildSecondaryActions(
                    context,
                    leftLabel: AppStrings.invitationsReject(strings),
                    onLeftPressed: onReject,
                  ),
                ],
                if (isConfirmed) ...[
                  InvitationFilledActionButtonWidget(
                    label: AppStrings.invitationsAttendanceConfirmed(strings),
                    enabled: false,
                  ),
                  SizedBox(height: InvitationsDesignSpec.px(context, 8)),
                  _buildSecondaryActions(
                    context,
                    leftLabel: AppStrings.invitationsCancel(strings),
                    onLeftPressed: onCancel,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecondaryActions(
    BuildContext context, {
    required String leftLabel,
    VoidCallback? onLeftPressed,
  }) {
    final strings = context.l10n;

    return Row(
      children: [
        Expanded(
          child: InvitationOutlineActionButtonWidget(
            label: leftLabel,
            onPressed: onLeftPressed,
          ),
        ),
        SizedBox(width: InvitationsDesignSpec.px(context, 8)),
        Expanded(
          child: InvitationOutlineActionButtonWidget(
            label: AppStrings.invitationsViewQr(strings),
            icon: Icons.qr_code_2_outlined,
            onPressed: onViewQr,
          ),
        ),
      ],
    );
  }

  Widget _buildEventImage(BuildContext context, double imageSize) {
    final borderRadius = BorderRadius.circular(
      InvitationsDesignSpec.px(
        context,
        InvitationsDesignSpec.imageRadius,
      ),
    );

    if (invitation.usesNetworkImage) {
      return EventNetworkImage(
        imageUrl: invitation.imageAssetPath,
        width: imageSize,
        height: imageSize,
        borderRadius: borderRadius,
      );
    }

    return EventNetworkImage(
      width: imageSize,
      height: imageSize,
      borderRadius: borderRadius,
    );
  }
}
