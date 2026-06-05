import 'package:flutter/material.dart';
import 'package:youpass/features/tickets/domain/entities/upcoming_ticket_entity.dart';
import 'package:youpass/features/tickets/presentation/tickets_design_spec.dart';
import 'package:youpass/features/tickets/presentation/widgets/upcoming_ticket_card_widget.dart';

class UpcomingTicketsTabWidget extends StatelessWidget {
  const UpcomingTicketsTabWidget({
    super.key,
    required this.tickets,
    required this.onViewQr,
    this.onAssignTickets,
    this.isViewQrLoading,
  });

  final List<UpcomingTicketEntity> tickets;
  final Future<void> Function(UpcomingTicketEntity ticket) onViewQr;
  final Future<void> Function(UpcomingTicketEntity ticket)? onAssignTickets;
  final bool Function(String ticketId)? isViewQrLoading;

  @override
  Widget build(BuildContext context) {
    final horizontalPadding =
        TicketsDesignSpec.px(context, TicketsDesignSpec.horizontalPadding);

    return ListView.builder(
      padding: EdgeInsets.fromLTRB(
        horizontalPadding,
        TicketsDesignSpec.px(context, 16),
        horizontalPadding,
        TicketsDesignSpec.px(context, 24),
      ),
      itemCount: tickets.length,
      itemBuilder: (context, index) {
        final ticket = tickets[index];
        return UpcomingTicketCardWidget(
          ticket: ticket,
          onViewQr: () => onViewQr(ticket),
          onAssignTickets: onAssignTickets == null
              ? null
              : () => onAssignTickets!(ticket),
          isViewQrLoading: isViewQrLoading?.call(ticket.id) ?? false,
        );
      },
    );
  }
}
