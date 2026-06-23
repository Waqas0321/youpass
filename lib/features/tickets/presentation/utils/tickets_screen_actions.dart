import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/l10n/tickets_error_extension.dart';
import 'package:youpass/features/auth/presentation/providers/auth_provider.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_qr_status.dart';
import 'package:youpass/features/invitations/presentation/routes/event_ticket_route_args.dart';
import 'package:youpass/features/invitations/presentation/utils/invitations_qr_helper.dart';
import 'package:youpass/features/invitations/presentation/widgets/invitation_qr_unavailable_dialog.dart';
import 'package:youpass/features/tickets/domain/entities/ticket_tier.dart';
import 'package:youpass/features/tickets/domain/entities/upcoming_ticket_entity.dart';
import 'package:youpass/features/tickets/presentation/providers/tickets_provider.dart';
import 'package:youpass/features/ticket_assignment/presentation/routes/assign_tickets_route_args.dart';
import 'package:youpass/routes/app_routes.dart';

class TicketsScreenActions {
  const TicketsScreenActions(this.context);

  final BuildContext context;

  TicketsProvider get ticketsProvider => context.read<TicketsProvider>();

  Future<void> handleSessionInvalid(TicketsProvider provider) async {
    if (provider.errorCode != 'SESSION_INVALID' &&
        provider.errorCode != 'UNAUTHORIZED') {
      return;
    }

    await context.read<AuthProvider>().logout();
    if (!context.mounted) {
      return;
    }

    await Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.login,
      (_) => false,
    );
  }

  Future<void> openTicketQr(UpcomingTicketEntity ticket) async {
    final strings = context.l10n;

    if (ticket.qrStatus == InvitationQrStatus.expired) {
      await InvitationQrUnavailableDialog.show(
        context,
        title: InvitationsQrHelper.expiredTitle(strings),
        message: InvitationsQrHelper.expiredMessage(strings),
      );
      return;
    }

    if (!ticket.canViewQr && ticket.qrStatus == InvitationQrStatus.locked) {
      await InvitationQrUnavailableDialog.show(
        context,
        title: InvitationsQrHelper.lockedTitle(strings),
        message: InvitationsQrHelper.lockedMessage(strings),
      );
      return;
    }

    final provider = ticketsProvider;
    final qrTicket = await provider.loadTicketQr(ticket.id);
    await handleSessionInvalid(provider);

    if (!context.mounted) {
      return;
    }

    if (qrTicket == null) {
      if (provider.errorCode == 'QR_LOCKED') {
        await InvitationQrUnavailableDialog.show(
          context,
          title: InvitationsQrHelper.lockedTitle(strings),
          message: provider.localizedUpcomingErrorMessage(strings) ??
              InvitationsQrHelper.lockedMessage(strings),
          subtitle: InvitationsQrHelper.unlockSubtitle(
            strings,
            context,
            provider.errorDetails,
          ),
        );
        return;
      }

      final error = provider.localizedUpcomingErrorMessage(strings);
      if (error != null) {
        showError(error);
      }
      return;
    }

    await Navigator.of(context).pushNamed(
      AppRoutes.eventTicket,
      arguments: EventTicketRouteArgs(ticket: qrTicket),
    );
  }

  Future<void> openAssignTickets(UpcomingTicketEntity ticket) async {
    final strings = context.l10n;

    if (!ticket.showsAssignmentAction) {
      showError(AppStrings.ticketAssignmentMissingOrder(strings));
      return;
    }

    await Navigator.of(context).pushNamed(
      AppRoutes.assignTickets,
      arguments: AssignTicketsRouteArgs(
        ticketId: ticket.id,
        orderId: ticket.ticketOrderId,
        eventTitle: ticket.title,
        isVip: ticket.tier == TicketTier.vip,
      ),
    );
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
