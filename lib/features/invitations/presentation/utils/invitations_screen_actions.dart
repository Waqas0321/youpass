import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/l10n/invitations_error_extension.dart';
import 'package:youpass/features/auth/presentation/providers/auth_provider.dart';
import 'package:youpass/features/invitations/domain/entities/confirm_invitation_params.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_entity.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_product_kind.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_status_extensions.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_ticket_entity.dart';
import 'package:youpass/features/invitations/presentation/providers/invitations_provider.dart';
import 'package:youpass/features/invitations/presentation/routes/event_ticket_route_args.dart';
import 'package:youpass/features/invitations/presentation/utils/guaranteed_pass_flow_actions.dart';
import 'package:youpass/features/invitations/presentation/widgets/invitation_important_dialog.dart';
import 'package:youpass/features/invitations/presentation/utils/invitation_detail_navigation.dart';
import 'package:youpass/features/invitations/presentation/utils/invitations_product_kind_resolver.dart';
import 'package:youpass/features/invitations/presentation/utils/invitations_text_factory.dart';
import 'package:youpass/features/invitations/presentation/utils/invitations_qr_helper.dart';
import 'package:youpass/features/invitations/presentation/widgets/add_payment_method_dialog.dart';
import 'package:youpass/features/invitations/presentation/widgets/discounted_accept_dialog.dart';
import 'package:youpass/features/invitations/presentation/widgets/invitation_qr_unavailable_dialog.dart';
import 'package:youpass/features/invitations/presentation/widgets/invitation_reject_confirm_dialog.dart';
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

  Future<void> openTicket(InvitationEntity invitation) async {
    final strings = context.l10n;

    if (invitation.status.isPending) {
      if (!invitation.canFetchQrFromApi) {
        return;
      }
      await InvitationQrUnavailableDialog.show(
        context,
        title: InvitationsQrHelper.pendingTitle(strings),
        message: InvitationsQrHelper.pendingMessage(strings),
      );
      return;
    }

    if (invitation.isQrExpiredForDisplay) {
      await InvitationQrUnavailableDialog.show(
        context,
        title: InvitationsQrHelper.expiredTitle(strings),
        message: InvitationsQrHelper.expiredMessage(strings),
      );
      return;
    }

    await navigateToTicketScreen(invitation);
  }

  Future<void> navigateToTicketScreen(InvitationEntity invitation) async {
    final strings = context.l10n;
    final provider = invitationsProvider;
    InvitationTicketEntity? ticket;
    var loadedFromApi = false;

    if (invitation.canFetchQrFromApi) {
      final loaded = await provider.loadTicket(invitation.id);
      await handleSessionInvalid(provider);
      if (loaded != null) {
        ticket = loaded;
        loadedFromApi = true;
      }
    }

    if (!context.mounted) {
      return;
    }

    ticket ??= _ticketFromInvitation(invitation);

    if (ticket.entryCode.isEmpty) {
      if (invitation.isQrLockedForDisplay || !invitation.canFetchQrFromApi) {
        await InvitationQrUnavailableDialog.show(
          context,
          title: InvitationsQrHelper.lockedTitle(strings),
          message: provider.localizedErrorMessage(strings) ??
              InvitationsQrHelper.lockedMessage(strings),
          subtitle: InvitationsQrHelper.unlockSubtitle(
            strings,
            context,
            provider.errorDetails,
          ),
        );
        return;
      }

      final error = provider.localizedErrorMessage(strings);
      if (error != null) {
        showError(error);
      }
      return;
    }

    await Navigator.of(context).pushNamed(
      AppRoutes.eventTicket,
      arguments: EventTicketRouteArgs(
        ticket: ticket,
        showQrCode: loadedFromApi,
      ),
    );
  }

  InvitationTicketEntity _ticketFromInvitation(InvitationEntity invitation) {
    final entryCode = invitation.entryCode?.trim() ?? '';

    return InvitationTicketEntity(
      invitationId: invitation.id,
      eventTitle: invitation.eventTitle,
      dateTimeLabel: invitation.dateTimeLabel,
      locationLabel: invitation.locationLabel,
      entryCode: entryCode,
      qrPayload: invitation.qrPayload?.trim().isNotEmpty == true
          ? invitation.qrPayload!.trim()
          : entryCode,
    );
  }

  Future<void> finalizeConfirmation(
    String invitationId, {
    ConfirmInvitationParams params = const ConfirmInvitationParams(),
    bool navigateToQr = false,
  }) async {
    final provider = invitationsProvider;
    final confirmed = await provider.confirmInvitation(
      invitationId,
      params: params,
    );
    await handleSessionInvalid(provider);

    if (!context.mounted) {
      return;
    }

    if (confirmed) {
      if (navigateToQr) {
        final updated = provider.invitations.firstWhere(
          (item) => item.id == invitationId,
        );
        await navigateToTicketScreen(updated);
      }
      return;
    }

    final error = provider.localizedErrorMessage(context.l10n);
    if (error != null) {
      showError(error);
    }
  }

  Future<bool> ensurePaymentMethod() async {
    final provider = invitationsProvider;
    if (provider.hasPaymentMethod) {
      return true;
    }

    return AddPaymentMethodDialog.show(
      context,
      onSave: provider.savePaymentMethod,
    );
  }

  Future<void> openInvitationDetail(InvitationEntity invitation) async {
    final destination = InvitationDetailNavigation.resolve(invitation);
    await Navigator.of(context).pushNamed(
      destination.route,
      arguments: destination.args,
    );
  }

  Future<void> openInvitationDetailById(String invitationId) async {
    final destination = InvitationDetailNavigation.resolveById(invitationId);
    await Navigator.of(context).pushNamed(
      destination.route,
      arguments: destination.args,
    );
  }

  Future<void> confirmAttendance(InvitationEntity invitation) async {
    final kind = InvitationsProductKindResolver.resolve(invitation);

    switch (kind) {
      case InvitationProductKind.free:
        final needsPaymentFlow =
            invitation.requiresPaymentMethod ||
            InvitationsTextFactory.isZeroValueFreeInvitation(invitation);
        if (!needsPaymentFlow) {
          await finalizeConfirmation(invitation.id);
          return;
        }

        final importantProceed = await InvitationImportantDialog.show(context);
        if (!importantProceed || !context.mounted) {
          return;
        }

        await invitationsProvider.refreshPaymentMethodStatus();

        if (!await ensurePaymentMethod() || !context.mounted) {
          return;
        }

        await PaymentSavedSuccessDialog.show(
          context,
          onConfirmAttendance: () => finalizeConfirmation(
            invitation.id,
            params: const ConfirmInvitationParams(acceptChargeTerms: true),
          ),
          onReject: () => rejectInvitation(invitation.id),
        );
        return;
      case InvitationProductKind.guaranteedPass:
        await GuaranteedPassFlowActions(context).acceptFromList(invitation);
        return;
      case InvitationProductKind.discounted:
        final proceed = await DiscountedAcceptDialog.show(context, invitation);
        if (!proceed || !context.mounted) {
          return;
        }
        if (!await ensurePaymentMethod() || !context.mounted) {
          return;
        }
        await PaymentSavedSuccessDialog.show(
          context,
          onConfirmAttendance: () => finalizeConfirmation(invitation.id),
          onReject: () => rejectInvitation(invitation.id),
        );
        return;
    }
  }

  Future<void> rejectInvitation(String invitationId) async {
    final confirmed = await InvitationRejectConfirmDialog.show(context);
    if (!confirmed || !context.mounted) {
      return;
    }

    final provider = invitationsProvider;
    final rejected = await provider.rejectInvitation(invitationId);
    await handleSessionInvalid(provider);

    if (!context.mounted) {
      return;
    }

    if (!rejected) {
      final error = provider.localizedErrorMessage(context.l10n);
      if (error != null) {
        showError(error);
      }
    }
  }

  Future<void> cancelInvitation(InvitationEntity invitation) async {
    await GuaranteedPassFlowActions(context).cancelConfirmedPass(
      invitation,
      popOnSuccess: false,
    );
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
