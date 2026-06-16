import 'package:flutter/material.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_entity.dart';
import 'package:youpass/features/tickets/domain/entities/upcoming_ticket_entity.dart';
import 'package:youpass/features/tickets/presentation/tickets_design_spec.dart';
import 'package:youpass/features/tickets/presentation/widgets/pending_invitation_ticket_card_widget.dart';
import 'package:youpass/features/tickets/presentation/widgets/upcoming_ticket_card_widget.dart';

class UpcomingTicketsTabWidget extends StatefulWidget {
  const UpcomingTicketsTabWidget({
    super.key,
    required this.tickets,
    required this.pendingInvitations,
    required this.onViewQr,
    required this.onRefresh,
    this.onAssignTickets,
    this.onAcceptInvitation,
    this.onDeclineInvitation,
    this.isViewQrLoading,
    this.isInvitationSubmitting,
    this.isLoadingMore = false,
    this.hasMore = false,
    this.onLoadMore,
  });

  final List<UpcomingTicketEntity> tickets;
  final List<InvitationEntity> pendingInvitations;
  final Future<void> Function() onRefresh;
  final Future<void> Function(UpcomingTicketEntity ticket) onViewQr;
  final Future<void> Function(UpcomingTicketEntity ticket)? onAssignTickets;
  final Future<bool> Function(String invitationId)? onAcceptInvitation;
  final Future<bool> Function(String invitationId)? onDeclineInvitation;
  final bool Function(String ticketId)? isViewQrLoading;
  final bool Function(String invitationId)? isInvitationSubmitting;
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
    final itemCount = widget.pendingInvitations.length +
        widget.tickets.length +
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
          if (index < widget.pendingInvitations.length) {
            final invitation = widget.pendingInvitations[index];
            return PendingInvitationTicketCardWidget(
              invitation: invitation,
              onAccept: widget.onAcceptInvitation == null
                  ? null
                  : () => widget.onAcceptInvitation!(invitation.id),
              onDecline: widget.onDeclineInvitation == null
                  ? null
                  : () => widget.onDeclineInvitation!(invitation.id),
              isAcceptLoading:
                  widget.isInvitationSubmitting?.call(invitation.id) ?? false,
              isDeclineLoading:
                  widget.isInvitationSubmitting?.call(invitation.id) ?? false,
            );
          }

          final ticketIndex = index - widget.pendingInvitations.length;
          if (ticketIndex < widget.tickets.length) {
            final ticket = widget.tickets[ticketIndex];
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
