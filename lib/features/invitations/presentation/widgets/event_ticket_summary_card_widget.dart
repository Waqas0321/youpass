import 'package:flutter/material.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_ticket_entity.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';

class EventTicketSummaryCardWidget extends StatelessWidget {
  const EventTicketSummaryCardWidget({
    super.key,
    required this.ticket,
  });

  final InvitationTicketEntity ticket;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(InvitationsDesignSpec.px(context, 12)),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E8),
        borderRadius: BorderRadius.circular(
          InvitationsDesignSpec.px(context, 12),
        ),
        border: Border.all(color: InvitationsDesignSpec.dialogBorder),
      ),
      child: Row(
        children: [
          Icon(
            Icons.confirmation_number_outlined,
            color: InvitationsDesignSpec.primary,
            size: InvitationsDesignSpec.px(context, 28),
          ),
          SizedBox(width: InvitationsDesignSpec.px(context, 12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ticket.eventTitle,
                  style: TextStyle(
                    fontSize: InvitationsDesignSpec.px(context, 14),
                    fontWeight: FontWeight.w700,
                    color: InvitationsDesignSpec.titleText,
                  ),
                ),
                SizedBox(height: InvitationsDesignSpec.px(context, 4)),
                Text(
                  ticket.dateTimeLabel,
                  style: TextStyle(
                    fontSize: InvitationsDesignSpec.px(context, 12),
                    color: InvitationsDesignSpec.bodyText,
                  ),
                ),
                Text(
                  ticket.locationLabel,
                  style: TextStyle(
                    fontSize: InvitationsDesignSpec.px(context, 12),
                    color: InvitationsDesignSpec.bodyText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
