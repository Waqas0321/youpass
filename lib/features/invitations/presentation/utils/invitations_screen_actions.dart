import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youpass/features/auth/presentation/providers/auth_provider.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_entity.dart';
import 'package:youpass/features/invitations/presentation/providers/invitations_provider.dart';
import 'package:youpass/features/invitations/presentation/routes/event_ticket_route_args.dart';
import 'package:youpass/features/invitations/presentation/widgets/add_payment_method_dialog.dart';
import 'package:youpass/features/invitations/presentation/widgets/invitation_important_dialog.dart';
import 'package:youpass/features/invitations/presentation/widgets/payment_saved_success_dialog.dart';
import 'package:youpass/routes/app_routes.dart';

class InvitationsScreenActions {
  const InvitationsScreenActions(this.context);

  final BuildContext context;

  InvitationsProvider get invitationsProvider =>
      context.read<InvitationsProvider>();

  Future<void> handleSessionInvalid(InvitationsProvider provider) async {
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

  Future<void> openTicket(String invitationId) async {
    final provider = invitationsProvider;
    final ticket = await provider.loadTicket(invitationId);
    await handleSessionInvalid(provider);

    if (!context.mounted || ticket == null) {
      return;
    }

    await Navigator.of(context).pushNamed(
      AppRoutes.eventTicket,
      arguments: EventTicketRouteArgs(ticket: ticket),
    );
  }

  Future<void> finalizeConfirmation(String invitationId) async {
    final provider = invitationsProvider;
    final confirmed = await provider.confirmInvitation(invitationId);
    await handleSessionInvalid(provider);

    if (!context.mounted) {
      return;
    }

    if (confirmed) {
      await openTicket(invitationId);
    } else if (provider.errorMessage != null) {
      showError(provider.errorMessage!);
    }
  }

  Future<void> confirmAttendance(InvitationEntity invitation) async {
    final proceed = await InvitationImportantDialog.show(context);
    if (!proceed || !context.mounted) {
      return;
    }

    final provider = invitationsProvider;

    if (!provider.hasPaymentMethod) {
      final saved = await AddPaymentMethodDialog.show(
        context,
        onSave: provider.savePaymentMethod,
      );
      if (!saved || !context.mounted) {
        return;
      }

      await PaymentSavedSuccessDialog.show(
        context,
        onConfirmAttendance: () => finalizeConfirmation(invitation.id),
        onReject: () => rejectInvitation(invitation.id),
      );
      return;
    }

    await finalizeConfirmation(invitation.id);
  }

  Future<void> rejectInvitation(String invitationId) async {
    final provider = invitationsProvider;
    final rejected = await provider.rejectInvitation(invitationId);
    await handleSessionInvalid(provider);

    if (!context.mounted) {
      return;
    }

    if (!rejected && provider.errorMessage != null) {
      showError(provider.errorMessage!);
    }
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
