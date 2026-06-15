import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/theme/tickets_screen_theme.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_entity.dart';
import 'package:youpass/features/invitations/presentation/utils/invitations_product_kind_resolver.dart';
import 'package:youpass/features/invitations/presentation/utils/invitations_product_kind_style.dart';
import 'package:youpass/features/invitations/presentation/utils/invitations_text_factory.dart';
import 'package:youpass/features/invitations/presentation/widgets/invitation_type_badge_widget.dart';
import 'package:youpass/features/tickets/presentation/tickets_design_spec.dart';
import 'package:youpass/features/tickets/presentation/widgets/ticket_event_image_widget.dart';
import 'package:youpass/features/tickets/presentation/widgets/ticket_filled_button_widget.dart';
import 'package:youpass/features/tickets/presentation/widgets/ticket_meta_row_widget.dart';
import 'package:youpass/features/tickets/presentation/widgets/ticket_outline_button_widget.dart';
import 'package:youpass/features/tickets/presentation/widgets/ticket_status_badge_widget.dart';

class PendingInvitationTicketCardWidget extends StatelessWidget {
  const PendingInvitationTicketCardWidget({
    super.key,
    required this.invitation,
    required this.onAccept,
    required this.onDecline,
    this.isAcceptLoading = false,
    this.isDeclineLoading = false,
  });

  final InvitationEntity invitation;
  final VoidCallback? onAccept;
  final VoidCallback? onDecline;
  final bool isAcceptLoading;
  final bool isDeclineLoading;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final radius = TicketsDesignSpec.px(context, TicketsDesignSpec.cardRadius);
    final imageHeight = TicketsDesignSpec.px(context, 120);
    final typeColor =
        InvitationsProductKindStyle.parseHexColor(invitation.typeColorHex) ??
            InvitationsProductKindStyle.colorFor(
              InvitationsProductKindResolver.resolve(invitation),
            );

    return Container(
      margin: EdgeInsets.only(bottom: TicketsDesignSpec.px(context, 16)),
      decoration: BoxDecoration(
        color: TicketsScreenTheme.cardBackground(context),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: typeColor.withValues(alpha: 0.45), width: 1.5),
        boxShadow: TicketsScreenTheme.cardShadow(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(radius)),
            child: Stack(
              children: [
                TicketEventImageWidget(
                  imagePath: invitation.imageAssetPath,
                  width: double.infinity,
                  height: imageHeight,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  left: TicketsDesignSpec.px(context, 12),
                  top: TicketsDesignSpec.px(context, 12),
                  child: TicketStatusBadgeWidget(
                    label: AppStrings.ticketsInvitationPending(strings),
                    variant: TicketStatusBadgeVariant.pending,
                  ),
                ),
                Positioned(
                  right: TicketsDesignSpec.px(context, 12),
                  top: TicketsDesignSpec.px(context, 12),
                  child: InvitationTypeBadgeWidget(invitation: invitation),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(TicketsDesignSpec.px(context, 16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  invitation.eventTitle,
                  style: TextStyle(
                    fontSize: TicketsDesignSpec.px(context, 17),
                    fontWeight: FontWeight.w700,
                    color: TicketsScreenTheme.title(context),
                  ),
                ),
                SizedBox(height: TicketsDesignSpec.px(context, 10)),
                TicketMetaRowWidget(
                  icon: Icons.calendar_today_outlined,
                  label: invitation.dateTimeLabel,
                ),
                TicketMetaRowWidget(
                  icon: Icons.location_on_outlined,
                  label: invitation.locationLabel,
                ),
                TicketMetaRowWidget(
                  icon: Icons.confirmation_number_outlined,
                  label: InvitationsTextFactory.tierLabel(strings, invitation),
                ),
                if (invitation.cancellationDeadlineLabel != null) ...[
                  TicketMetaRowWidget(
                    icon: Icons.event_busy_outlined,
                    label: invitation.cancellationDeadlineLabel!,
                  ),
                ],
                if (invitation.expiresAtLabel != null) ...[
                  SizedBox(height: TicketsDesignSpec.px(context, 8)),
                  Text(
                    AppStrings.ticketsInvitationExpires(
                      strings,
                      invitation.expiresAtLabel!,
                    ),
                    style: TextStyle(
                      fontSize: TicketsDesignSpec.px(context, 12),
                      color: TicketsScreenTheme.body(context),
                    ),
                  ),
                ],
                SizedBox(height: TicketsDesignSpec.px(context, 12)),
                TicketFilledButtonWidget(
                  label: AppStrings.invitationsConfirmAttendance(strings),
                  icon: Icons.check_circle_outline,
                  backgroundColor: typeColor,
                  foregroundColor: Colors.white,
                  onPressed: onAccept,
                  isLoading: isAcceptLoading,
                ),
                SizedBox(height: TicketsDesignSpec.px(context, 10)),
                TicketOutlineButtonWidget(
                  label: AppStrings.invitationsReject(strings),
                  icon: Icons.close,
                  onPressed: onDecline,
                  isLoading: isDeclineLoading,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
