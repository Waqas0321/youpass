import 'package:flutter/material.dart';
import 'package:youpass/core/theme/qr_screen_theme.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_ticket_entity.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';
import 'package:youpass/features/invitations/presentation/widgets/event_ticket_meta_row_widget.dart';

class EventTicketSummaryCardWidget extends StatelessWidget {
  const EventTicketSummaryCardWidget({
    super.key,
    required this.ticket,
  });

  final InvitationTicketEntity ticket;

  @override
  Widget build(BuildContext context) {
    final iconCircleSize = InvitationsDesignSpec.px(context, 44);

    return Container(
      padding: EdgeInsets.all(InvitationsDesignSpec.px(context, 14)),
      decoration: BoxDecoration(
        color: QrScreenTheme.eventSummaryBackground(context),
        borderRadius: BorderRadius.circular(
          InvitationsDesignSpec.px(context, 14),
        ),
        border: Border.all(color: QrScreenTheme.eventSummaryBorder(context)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: iconCircleSize,
            height: iconCircleSize,
            decoration: BoxDecoration(
              color: QrScreenTheme.eventSummaryIconCircle(context),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.confirmation_number_outlined,
              color: QrScreenTheme.accent(context),
              size: InvitationsDesignSpec.px(context, 22),
            ),
          ),
          SizedBox(width: InvitationsDesignSpec.px(context, 12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ticket.eventTitle,
                  style: TextStyle(
                    fontSize: InvitationsDesignSpec.px(context, 15),
                    fontWeight: FontWeight.w700,
                    color: QrScreenTheme.eventTitle(context),
                  ),
                ),
                SizedBox(height: InvitationsDesignSpec.px(context, 8)),
                if (ticket.seatLabel != null)
                  EventTicketMetaRowWidget(
                    icon: Icons.event_seat_outlined,
                    label: ticket.seatLabel!,
                  ),
                EventTicketMetaRowWidget(
                  icon: Icons.calendar_today_outlined,
                  label: ticket.dateTimeLabel,
                ),
                EventTicketMetaRowWidget(
                  icon: Icons.location_on_outlined,
                  label: ticket.locationLabel,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
