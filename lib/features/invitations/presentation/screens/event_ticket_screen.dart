import 'package:flutter/material.dart';
import 'package:youpass/dependency_injection/injection_container.dart';
import 'package:youpass/core/services/screen_secure_service.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_ticket_entity.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';
import 'package:youpass/features/invitations/presentation/routes/event_ticket_route_args.dart';
import 'package:youpass/features/invitations/presentation/widgets/event_ticket_app_bar_widget.dart';
import 'package:youpass/features/invitations/presentation/widgets/event_ticket_qr_section_widget.dart';
import 'package:youpass/features/invitations/presentation/widgets/event_ticket_ready_header_widget.dart';
import 'package:youpass/features/invitations/presentation/widgets/event_ticket_summary_card_widget.dart';
import 'package:youpass/features/home/presentation/utils/app_drawer_navigation.dart';

class EventTicketScreen extends StatefulWidget {
  const EventTicketScreen({
    super.key,
    required this.ticket,
    this.showQrCode = true,
  });

  final InvitationTicketEntity ticket;
  final bool showQrCode;

  static Widget fromRouteArgs(EventTicketRouteArgs args) {
    return EventTicketScreen(
      ticket: args.ticket,
      showQrCode: args.showQrCode,
    );
  }

  @override
  State<EventTicketScreen> createState() => EventTicketScreenState();
}

class EventTicketScreenState extends State<EventTicketScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final ScreenSecureService _screenSecureService = sl<ScreenSecureService>();

  @override
  void initState() {
    super.initState();
    _screenSecureService.enable();
  }

  @override
  void dispose() {
    _screenSecureService.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPadding =
        InvitationsDesignSpec.px(context, InvitationsDesignSpec.horizontalPadding);

    return AppDrawerNavigation.wrap(
      scaffoldKey: scaffoldKey,
      context: context,
      appBar: EventTicketAppBarWidget(
        onBack: () => Navigator.of(context).pop(),
        onMenuTap: () => AppDrawerNavigation.openDrawer(context, scaffoldKey),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(
          horizontalPadding,
          InvitationsDesignSpec.px(context, 12),
          horizontalPadding,
          InvitationsDesignSpec.px(context, 32),
        ),
        children: [
          const EventTicketReadyHeaderWidget(),
          SizedBox(height: InvitationsDesignSpec.px(context, 24)),
          EventTicketSummaryCardWidget(ticket: widget.ticket),
          SizedBox(height: InvitationsDesignSpec.px(context, 28)),
          EventTicketQrSectionWidget(
            ticket: widget.ticket,
            showQrCode: widget.showQrCode,
          ),
        ],
      ),
    );
  }
}
