import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/theme/tickets_screen_theme.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_qr_status.dart';
import 'package:youpass/features/tickets/domain/entities/ticket_display_status.dart';
import 'package:youpass/features/tickets/domain/entities/ticket_tier.dart';
import 'package:youpass/features/tickets/domain/entities/upcoming_ticket_entity.dart';
import 'package:youpass/features/tickets/presentation/tickets_design_spec.dart';
import 'package:youpass/features/tickets/presentation/utils/ticket_status_labels.dart';
import 'package:youpass/features/tickets/presentation/widgets/ticket_event_image_widget.dart';
import 'package:youpass/features/tickets/presentation/widgets/ticket_filled_button_widget.dart';
import 'package:youpass/features/tickets/presentation/widgets/ticket_meta_row_widget.dart';
import 'package:youpass/features/tickets/presentation/widgets/ticket_outline_button_widget.dart';
import 'package:youpass/features/tickets/presentation/widgets/ticket_status_badge_widget.dart';

class UpcomingTicketCardWidget extends StatelessWidget {
  const UpcomingTicketCardWidget({
    super.key,
    required this.ticket,
    this.onViewQr,
    this.onAssignTickets,
    this.isViewQrLoading = false,
  });

  final UpcomingTicketEntity ticket;
  final VoidCallback? onViewQr;
  final VoidCallback? onAssignTickets;
  final bool isViewQrLoading;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final radius = TicketsDesignSpec.px(context, TicketsDesignSpec.cardRadius);
    final imageHeight = TicketsDesignSpec.px(context, 160);
    final isQrLocked = !ticket.canViewQr &&
        ticket.qrStatus == InvitationQrStatus.locked;

    return Container(
      margin: EdgeInsets.only(bottom: TicketsDesignSpec.px(context, 16)),
      decoration: BoxDecoration(
        color: TicketsScreenTheme.cardBackground(context),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: TicketsScreenTheme.cardBorder(context)),
        boxShadow: TicketsScreenTheme.cardShadow(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(radius),
            ),
            child: Stack(
              children: [
                TicketEventImageWidget(
                  imagePath: ticket.imageAssetPath,
                  width: double.infinity,
                  height: imageHeight,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  left: TicketsDesignSpec.px(context, 12),
                  top: TicketsDesignSpec.px(context, 12),
                  child: TicketStatusBadgeWidget(
                    label: TicketStatusLabels.label(strings, ticket.displayStatus),
                    variant: _badgeVariant(ticket.displayStatus),
                  ),
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
                  ticket.title,
                  style: TextStyle(
                    fontSize: TicketsDesignSpec.px(context, 17),
                    fontWeight: FontWeight.w700,
                    color: TicketsScreenTheme.title(context),
                    height: 1.2,
                  ),
                ),
                SizedBox(height: TicketsDesignSpec.px(context, 10)),
                TicketMetaRowWidget(
                  icon: Icons.calendar_today_outlined,
                  label: ticket.dateLabel,
                ),
                TicketMetaRowWidget(
                  icon: Icons.location_on_outlined,
                  label: ticket.locationLabel,
                ),
                TicketMetaRowWidget(
                  icon: Icons.confirmation_number_outlined,
                  label: ticket.ticketTypeLabel,
                ),
                if (isQrLocked) ...[
                  SizedBox(height: TicketsDesignSpec.px(context, 12)),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(TicketsDesignSpec.px(context, 12)),
                    decoration: BoxDecoration(
                      color: TicketsScreenTheme.accent(context).withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(
                        TicketsDesignSpec.px(context, 10),
                      ),
                    ),
                    child: Text(
                      AppStrings.ticketsQrCountdown(strings, ticket.dateLabel),
                      style: TextStyle(
                        fontSize: TicketsDesignSpec.px(context, 12),
                        color: TicketsScreenTheme.body(context),
                        height: 1.35,
                      ),
                    ),
                  ),
                ],
                SizedBox(height: TicketsDesignSpec.px(context, 12)),
                TicketFilledButtonWidget(
                  label: isQrLocked
                      ? AppStrings.ticketsQrUnavailable(strings)
                      : AppStrings.ticketsViewQr(strings),
                  icon: isQrLocked
                      ? Icons.lock_clock_outlined
                      : Icons.visibility_outlined,
                  backgroundColor: TicketsScreenTheme.accent(context),
                  foregroundColor: TicketsScreenTheme.activeBadgeText(context),
                  onPressed: onViewQr,
                  isLoading: isViewQrLoading,
                ),
                if (onAssignTickets != null && ticket.showsAssignmentAction) ...[
                  SizedBox(height: TicketsDesignSpec.px(context, 10)),
                  TicketOutlineButtonWidget(
                    label: ticket.showsViewAssignedAction
                        ? AppStrings.ticketsViewAssigned(strings)
                        : ticket.tier == TicketTier.vip
                            ? AppStrings.ticketsAssignVip(strings)
                            : AppStrings.ticketsAssignEntries(strings),
                    icon: Icons.people_outline,
                    onPressed: onAssignTickets,
                    foregroundColor: ticket.tier == TicketTier.vip
                        ? TicketsScreenTheme.vipAssignAccent(context)
                        : TicketsScreenTheme.assignFlowAccent(
                            context,
                            isVip: false,
                          ),
                    borderColor: ticket.tier == TicketTier.vip
                        ? TicketsScreenTheme.vipAssignAccent(context)
                        : TicketsScreenTheme.assignFlowAccent(
                            context,
                            isVip: false,
                          ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  TicketStatusBadgeVariant _badgeVariant(TicketDisplayStatus status) {
    switch (status) {
      case TicketDisplayStatus.active:
        return TicketStatusBadgeVariant.active;
      case TicketDisplayStatus.validated:
        return TicketStatusBadgeVariant.validated;
      case TicketDisplayStatus.expired:
        return TicketStatusBadgeVariant.expired;
      case TicketDisplayStatus.cancelled:
        return TicketStatusBadgeVariant.cancelled;
      case TicketDisplayStatus.refunded:
        return TicketStatusBadgeVariant.refunded;
    }
  }
}
