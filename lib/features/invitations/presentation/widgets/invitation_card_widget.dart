import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_assets.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/widgets/app_asset_image.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_entity.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_status.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';
import 'package:youpass/features/invitations/presentation/utils/invitations_text_factory.dart';
import 'package:youpass/features/invitations/presentation/widgets/invitation_filled_action_button_widget.dart';
import 'package:youpass/features/invitations/presentation/widgets/invitation_meta_row_widget.dart';
import 'package:youpass/features/invitations/presentation/widgets/invitation_outline_action_button_widget.dart';
import 'package:youpass/features/invitations/presentation/widgets/invitation_tier_badge_widget.dart';

class InvitationCardWidget extends StatelessWidget {
  const InvitationCardWidget({
    super.key,
    required this.invitation,
    this.onConfirm,
    this.onReject,
    this.onViewQr,
  });

  final InvitationEntity invitation;
  final VoidCallback? onConfirm;
  final VoidCallback? onReject;
  final VoidCallback? onViewQr;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final isPending = invitation.status == InvitationStatus.pending;
    final isConfirmed = invitation.status == InvitationStatus.confirmed;
    final imageSize = InvitationsDesignSpec.px(context, 88);

    return Container(
      margin: EdgeInsets.only(bottom: InvitationsDesignSpec.px(context, 14)),
      padding: EdgeInsets.all(InvitationsDesignSpec.px(context, 12)),
      decoration: BoxDecoration(
        color: InvitationsDesignSpec.screenBackground,
        borderRadius: BorderRadius.circular(
          InvitationsDesignSpec.px(context, InvitationsDesignSpec.cardRadius),
        ),
        border: Border.all(color: InvitationsDesignSpec.cardBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppAssetImage(
            assetPath: invitation.imageAssetPath.isNotEmpty
                ? invitation.imageAssetPath
                : AppAssets.dummyImage,
            width: imageSize,
            height: imageSize,
            borderRadius: BorderRadius.circular(
              InvitationsDesignSpec.px(
                context,
                InvitationsDesignSpec.imageRadius,
              ),
            ),
          ),
          SizedBox(width: InvitationsDesignSpec.px(context, 12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        invitation.eventTitle,
                        style: TextStyle(
                          fontSize: InvitationsDesignSpec.px(context, 15),
                          fontWeight: FontWeight.w700,
                          color: InvitationsDesignSpec.titleText,
                        ),
                      ),
                    ),
                    InvitationTierBadgeWidget(tier: invitation.tier),
                  ],
                ),
                SizedBox(height: InvitationsDesignSpec.px(context, 8)),
                InvitationMetaRowWidget(
                  icon: Icons.location_on_outlined,
                  label: invitation.locationLabel,
                ),
                InvitationMetaRowWidget(
                  icon: Icons.schedule_outlined,
                  label: invitation.dateTimeLabel,
                ),
                SizedBox(height: InvitationsDesignSpec.px(context, 6)),
                Text(
                  AppStrings.invitationsStatusLine(
                    strings,
                    InvitationsTextFactory.statusLabel(
                      strings,
                      invitation.status,
                    ),
                  ),
                  style: TextStyle(
                    fontSize: InvitationsDesignSpec.px(context, 12),
                    fontWeight: FontWeight.w600,
                    color: isConfirmed
                        ? InvitationsDesignSpec.statusConfirmed
                        : InvitationsDesignSpec.statusPending,
                  ),
                ),
                if (isPending) ...[
                  SizedBox(height: InvitationsDesignSpec.px(context, 10)),
                  InvitationFilledActionButtonWidget(
                    label: AppStrings.invitationsConfirmAttendance(strings),
                    onPressed: onConfirm,
                  ),
                  SizedBox(height: InvitationsDesignSpec.px(context, 8)),
                  InvitationOutlineActionButtonWidget(
                    label: AppStrings.invitationsReject(strings),
                    onPressed: onReject,
                  ),
                ],
                if (isConfirmed) ...[
                  SizedBox(height: InvitationsDesignSpec.px(context, 10)),
                  InvitationFilledActionButtonWidget(
                    label: AppStrings.invitationsViewQr(strings),
                    backgroundColor: InvitationsDesignSpec.viewQrButton,
                    onPressed: onViewQr,
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
