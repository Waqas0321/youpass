import 'package:flutter/material.dart';
import 'package:youpass/core/theme/youpass_theme_extension.dart';
import 'package:youpass/core/theme/youpass_themed_colors.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_entity.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_status.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';
import 'package:youpass/features/invitations/presentation/utils/invitations_text_factory.dart';
import 'package:youpass/features/invitations/presentation/widgets/invitation_card_event_image_widget.dart';
import 'package:youpass/features/invitations/presentation/widgets/invitation_card_secondary_actions_widget.dart';
import 'package:youpass/features/invitations/presentation/widgets/invitation_filled_action_button_widget.dart';
import 'package:youpass/features/invitations/presentation/widgets/invitation_meta_row_widget.dart';
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
    this.isConfirmLoading = false,
    this.isRejectLoading = false,
    this.isViewQrLoading = false,
  });

  final InvitationEntity invitation;
  final VoidCallback? onConfirm;
  final VoidCallback? onReject;
  final VoidCallback? onCancel;
  final VoidCallback? onViewQr;
  final bool isConfirmLoading;
  final bool isRejectLoading;
  final bool isViewQrLoading;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final theme = YouPassThemeExtension.of(context);
    final isPending = invitation.status == InvitationStatus.pending;
    final isConfirmed = invitation.status == InvitationStatus.confirmed;
    final imageSize = InvitationsDesignSpec.px(context, 96);

    return Container(
      margin: EdgeInsets.only(bottom: InvitationsDesignSpec.px(context, 14)),
      padding: EdgeInsets.all(InvitationsDesignSpec.px(context, 12)),
      decoration: BoxDecoration(
        color: theme.cardBackground,
        borderRadius: BorderRadius.circular(
          InvitationsDesignSpec.px(context, InvitationsDesignSpec.cardRadius),
        ),
        border: Border.all(color: theme.cardBorder),
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
          InvitationCardEventImageWidget(
            invitation: invitation,
            imageSize: imageSize,
          ),
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
                          color: YouPassThemedColors.primaryText(context),
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
                  color: theme.cardBorder,
                ),
                SizedBox(height: InvitationsDesignSpec.px(context, 10)),
                if (isPending) ...[
                  InvitationFilledActionButtonWidget(
                    label: AppStrings.invitationsConfirmAttendance(strings),
                    onPressed: onConfirm,
                    isLoading: isConfirmLoading,
                  ),
                  SizedBox(height: InvitationsDesignSpec.px(context, 8)),
                  InvitationCardSecondaryActionsWidget(
                    leftLabel: AppStrings.invitationsReject(strings),
                    onLeftPressed: onReject,
                    onViewQr: onViewQr,
                    isLeftLoading: isRejectLoading,
                    isViewQrLoading: isViewQrLoading,
                  ),
                ],
                if (isConfirmed) ...[
                  InvitationFilledActionButtonWidget(
                    label: AppStrings.invitationsAttendanceConfirmed(strings),
                    enabled: false,
                  ),
                  SizedBox(height: InvitationsDesignSpec.px(context, 8)),
                  InvitationCardSecondaryActionsWidget(
                    leftLabel: AppStrings.invitationsCancel(strings),
                    onLeftPressed: onCancel,
                    onViewQr: onViewQr,
                    isLeftLoading: isRejectLoading,
                    isViewQrLoading: isViewQrLoading,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
