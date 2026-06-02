import 'package:flutter/material.dart';
import 'package:youpass/features/tickets/domain/entities/upcoming_ticket_entity.dart';
import 'package:youpass/features/tickets/presentation/tickets_design_spec.dart';
import 'package:youpass/features/tickets/presentation/widgets/upcoming_ticket_card_widget.dart';

class UpcomingTicketsTabWidget extends StatelessWidget {
  const UpcomingTicketsTabWidget({
    super.key,
    required this.tickets,
  });

  final List<UpcomingTicketEntity> tickets;

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
          onViewQr: () {},
          onAssignTickets: () {},
        );
      },
    );
  }
}
