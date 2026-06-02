import 'package:flutter/material.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_ticket_entity.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';
import 'package:youpass/features/invitations/presentation/routes/event_ticket_route_args.dart';
import 'package:youpass/features/invitations/presentation/widgets/event_ticket_app_bar_widget.dart';
import 'package:youpass/features/invitations/presentation/widgets/event_ticket_qr_section_widget.dart';
import 'package:youpass/features/invitations/presentation/widgets/event_ticket_ready_header_widget.dart';
import 'package:youpass/features/invitations/presentation/widgets/event_ticket_summary_card_widget.dart';

class EventTicketScreen extends StatelessWidget {
  const EventTicketScreen({
    super.key,
    required this.ticket,
  });

  final InvitationTicketEntity ticket;

  static Widget fromRouteArgs(EventTicketRouteArgs args) {
    return EventTicketScreen(ticket: args.ticket);
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPadding =
        InvitationsDesignSpec.px(context, InvitationsDesignSpec.horizontalPadding);

    return Scaffold(
      backgroundColor: InvitationsDesignSpec.screenBackground,
      appBar: EventTicketAppBarWidget(
        onBack: () => Navigator.of(context).pop(),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(
          horizontalPadding,
          InvitationsDesignSpec.px(context, 8),
          horizontalPadding,
          InvitationsDesignSpec.px(context, 32),
        ),
        children: [
          const EventTicketReadyHeaderWidget(),
          SizedBox(height: InvitationsDesignSpec.px(context, 20)),
          EventTicketSummaryCardWidget(ticket: ticket),
          SizedBox(height: InvitationsDesignSpec.px(context, 24)),
          EventTicketQrSectionWidget(ticket: ticket),
        ],
      ),
    );
  }
}
