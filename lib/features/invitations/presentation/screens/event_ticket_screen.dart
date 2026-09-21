import 'dart:async';

import 'package:flutter/material.dart';
import 'package:youpass/dependency_injection/injection_container.dart';
import 'package:youpass/core/services/screen_secure_service.dart';
import 'package:youpass/features/home/presentation/providers/home_provider.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_ticket_entity.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';
import 'package:youpass/features/invitations/presentation/routes/event_ticket_route_args.dart';
import 'package:youpass/features/invitations/presentation/widgets/event_ticket_app_bar_widget.dart';
import 'package:youpass/features/invitations/presentation/widgets/event_ticket_qr_accepted_dialog.dart';
import 'package:youpass/features/invitations/presentation/widgets/event_ticket_qr_section_widget.dart';
import 'package:youpass/features/invitations/presentation/widgets/event_ticket_ready_header_widget.dart';
import 'package:youpass/features/invitations/presentation/widgets/event_ticket_summary_card_widget.dart';
import 'package:youpass/features/tickets/data/services/tickets_api_service.dart';
import 'package:youpass/features/tickets/domain/entities/ticket_display_status.dart';
import 'package:youpass/features/tickets/presentation/providers/tickets_provider.dart';
import 'package:youpass/routes/app_routes.dart';

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
  static const _pollInterval = Duration(milliseconds: 500);

  final ScreenSecureService _screenSecureService = sl<ScreenSecureService>();
  final TicketsApiService _ticketsApi = sl<TicketsApiService>();

  Timer? _pollTimer;
  bool _isPolling = false;
  bool _isShowingAcceptedDialog = false;
  bool _didAcceptScan = false;

  @override
  void initState() {
    super.initState();
    _screenSecureService.enable();
    _startValidationPolling();
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    _screenSecureService.disable();
    super.dispose();
  }

  void _startValidationPolling() {
    final ticketId = widget.ticket.invitationId.trim();
    if (ticketId.isEmpty || !widget.showQrCode) {
      return;
    }

    _pollTimer?.cancel();
    _pollTimer = Timer.periodic(_pollInterval, (_) {
      unawaited(_checkValidationStatus());
    });
    unawaited(_checkValidationStatus());
  }

  Future<void> _checkValidationStatus() async {
    if (!mounted ||
        _isPolling ||
        _isShowingAcceptedDialog ||
        _didAcceptScan) {
      return;
    }

    final ticketId = widget.ticket.invitationId.trim();
    if (ticketId.isEmpty) {
      return;
    }

    _isPolling = true;
    try {
      final status = await _ticketsApi.fetchTicketStatus(ticketId);
      if (!mounted || status != TicketDisplayStatus.validated) {
        return;
      }

      _didAcceptScan = true;
      await _showAcceptedFeedback();
    } catch (_) {
      // Ignore transient polling errors while waiting for a staff scan.
    } finally {
      _isPolling = false;
    }
  }

  Future<void> _showAcceptedFeedback() async {
    if (!mounted || _isShowingAcceptedDialog) {
      return;
    }

    _isShowingAcceptedDialog = true;
    _pollTimer?.cancel();
    try {
      await EventTicketQrAcceptedDialog.show(context);
      if (!mounted) {
        return;
      }

      try {
        final ticketsProvider = sl<TicketsProvider>();
        unawaited(ticketsProvider.refreshUpcoming());
        unawaited(ticketsProvider.ensurePastLoaded());
      } catch (_) {
        // Tickets provider may be unavailable outside the tickets flow.
      }

      try {
        sl<HomeProvider>().requestPartyModeActivateTip();
      } catch (_) {
        // Home provider should always be registered; ignore if DI is mid-reset.
      }

      // Return to Home so the Party Mode activation tip can show.
      Navigator.of(context).pushNamedAndRemoveUntil(
        AppRoutes.home,
        (_) => false,
      );
    } finally {
      _isShowingAcceptedDialog = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPadding =
        InvitationsDesignSpec.px(context, InvitationsDesignSpec.horizontalPadding);

    return Scaffold(
      appBar: EventTicketAppBarWidget(
        onBack: () => Navigator.of(context).pop(),
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
