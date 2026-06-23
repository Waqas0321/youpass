import 'package:flutter/material.dart';
import 'package:youpass/features/tickets/domain/entities/upcoming_ticket_entity.dart';
import 'package:youpass/features/tickets/presentation/tickets_design_spec.dart';
import 'package:youpass/features/tickets/presentation/widgets/upcoming_ticket_card_widget.dart';

class UpcomingTicketsTabWidget extends StatefulWidget {
  const UpcomingTicketsTabWidget({
    super.key,
    required this.tickets,
    required this.onViewQr,
    required this.onRefresh,
    this.onAssignTickets,
    this.isViewQrLoading,
    this.isLoadingMore = false,
    this.hasMore = false,
    this.onLoadMore,
  });

  final List<UpcomingTicketEntity> tickets;
  final Future<void> Function() onRefresh;
  final Future<void> Function(UpcomingTicketEntity ticket) onViewQr;
  final Future<void> Function(UpcomingTicketEntity ticket)? onAssignTickets;
  final bool Function(String ticketId)? isViewQrLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final VoidCallback? onLoadMore;

  @override
  State<UpcomingTicketsTabWidget> createState() => UpcomingTicketsTabWidgetState();
}

class UpcomingTicketsTabWidgetState extends State<UpcomingTicketsTabWidget> {
  @override
  Widget build(BuildContext context) {
    final horizontalPadding =
        TicketsDesignSpec.px(context, TicketsDesignSpec.horizontalPadding);
    final itemCount = widget.tickets.length +
        (widget.hasMore || widget.isLoadingMore ? 1 : 0);

    return RefreshIndicator(
      onRefresh: widget.onRefresh,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.fromLTRB(
          horizontalPadding,
          TicketsDesignSpec.px(context, 16),
          horizontalPadding,
          TicketsDesignSpec.px(context, 24),
        ),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          if (index < widget.tickets.length) {
            final ticket = widget.tickets[index];
            return UpcomingTicketCardWidget(
              ticket: ticket,
              onViewQr: () => widget.onViewQr(ticket),
              onAssignTickets: widget.onAssignTickets == null
                  ? null
                  : () => widget.onAssignTickets!(ticket),
              isViewQrLoading:
                  widget.isViewQrLoading?.call(ticket.id) ?? false,
            );
          }

          if (widget.isLoadingMore) {
            return Padding(
              padding: EdgeInsets.symmetric(
                vertical: TicketsDesignSpec.px(context, 16),
              ),
              child: const Center(child: CircularProgressIndicator()),
            );
          }

          WidgetsBinding.instance.addPostFrameCallback((_) {
            widget.onLoadMore?.call();
          });
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
