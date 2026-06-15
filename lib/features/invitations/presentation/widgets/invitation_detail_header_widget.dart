import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/theme/invitations_screen_theme.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_entity.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';
import 'package:youpass/features/invitations/presentation/utils/invitations_text_factory.dart';
import 'package:youpass/features/invitations/presentation/widgets/invitation_card_event_image_widget.dart';
import 'package:youpass/features/invitations/presentation/widgets/invitation_meta_row_widget.dart';
import 'package:youpass/features/invitations/presentation/widgets/invitation_status_line_widget.dart';
import 'package:youpass/features/invitations/presentation/widgets/invitation_type_badge_widget.dart';
import 'package:youpass/l10n/app_localizations.dart';

class InvitationDetailHeaderWidget extends StatelessWidget {
  const InvitationDetailHeaderWidget({
    super.key,
    required this.invitation,
    this.showTier = true,
    this.showAssignedSlot = false,
    this.showPassStatus = false,
    this.leading,
  });

  final InvitationEntity invitation;
  final bool showTier;
  final bool showAssignedSlot;
  final bool showPassStatus;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final invitedBy = invitation.invitedBy?.name ?? '—';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (leading != null) ...[
          leading!,
          SizedBox(height: InvitationsDesignSpec.px(context, 16)),
        ],
        ClipRRect(
          borderRadius: BorderRadius.circular(
            InvitationsDesignSpec.px(context, InvitationsDesignSpec.imageRadius),
          ),
          child: SizedBox(
            height: InvitationsDesignSpec.px(context, 180),
            child: InvitationCardEventImageWidget(invitation: invitation),
          ),
        ),
        SizedBox(height: InvitationsDesignSpec.px(context, 16)),
        Text(
          invitation.eventTitle,
          style: TextStyle(
            fontSize: InvitationsDesignSpec.px(context, 22),
            fontWeight: FontWeight.w800,
            color: InvitationsScreenTheme.title(context),
          ),
        ),
        SizedBox(height: InvitationsDesignSpec.px(context, 10)),
        InvitationMetaRowWidget(
          icon: Icons.location_on_outlined,
          label: invitation.locationLabel,
        ),
        InvitationMetaRowWidget(
          icon: Icons.calendar_today_outlined,
          label: invitation.dateTimeLabel,
        ),
        if (showTier)
          InvitationMetaRowWidget(
            icon: Icons.diamond_outlined,
            label: InvitationsTextFactory.tierLabel(strings, invitation),
          ),
        if (showAssignedSlot)
          InvitationMetaRowWidget(
            icon: Icons.event_seat_outlined,
            label: AppStrings.invitationsAssignedSlot(
              strings,
              invitation.assignedSlot ?? '—',
            ),
          ),
        if (showPassStatus)
          InvitationMetaRowWidget(
            icon: Icons.verified_outlined,
            label: AppStrings.invitationsPassStatus(
              strings,
              invitation.statusLabel ??
                  AppStrings.invitationsStatusConfirmed(strings),
            ),
          ),
        InvitationMetaRowWidget(
          icon: Icons.person_outline,
          label: AppStrings.invitationsInvitedBy(strings, invitedBy),
        ),
        SizedBox(height: InvitationsDesignSpec.px(context, 8)),
        InvitationTypeBadgeWidget(invitation: invitation),
        SizedBox(height: InvitationsDesignSpec.px(context, 8)),
        InvitationStatusLineWidget(status: invitation.status),
        ..._pricingRows(context, strings),
        if (invitation.customMessage?.isNotEmpty == true) ...[
          SizedBox(height: InvitationsDesignSpec.px(context, 12)),
          Text(
            invitation.customMessage!,
            style: TextStyle(
              fontSize: InvitationsDesignSpec.px(context, 14),
              color: InvitationsScreenTheme.body(context),
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ],
    );
  }

  List<Widget> _pricingRows(BuildContext context, AppLocalizations strings) {
    if (invitation.acceptAmountLabel?.isNotEmpty != true) {
      return const [];
    }

    return [
      SizedBox(height: InvitationsDesignSpec.px(context, 8)),
      InvitationMetaRowWidget(
        icon: Icons.payments_outlined,
        label: invitation.acceptAmountLabel!,
        emphasize: true,
      ),
    ];
  }
}
