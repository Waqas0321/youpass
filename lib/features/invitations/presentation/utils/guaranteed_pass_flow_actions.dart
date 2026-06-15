import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/l10n/invitations_error_extension.dart';
import 'package:youpass/core/security/device_auth_service.dart';
import 'package:youpass/dependency_injection/injection_container.dart';
import 'package:youpass/features/invitations/domain/entities/confirm_invitation_params.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_entity.dart';
import 'package:youpass/features/invitations/presentation/providers/invitations_provider.dart';
import 'package:youpass/features/invitations/presentation/routes/guaranteed_pass_active_route_args.dart';
import 'package:youpass/features/invitations/presentation/utils/invitations_screen_actions.dart';
import 'package:youpass/features/invitations/presentation/widgets/add_payment_method_dialog.dart';
import 'package:youpass/features/invitations/presentation/widgets/guaranteed_pass_accept_dialog.dart';
import 'package:youpass/features/invitations/presentation/widgets/invitation_important_dialog.dart';
import 'package:youpass/routes/app_routes.dart';

class GuaranteedPassFlowActions {
  GuaranteedPassFlowActions(this.context);

  final BuildContext context;

  InvitationsScreenActions get _screenActions => InvitationsScreenActions(context);

  /// Section 14.3B list-screen flow — Important modal → card → confirm.
  Future<void> acceptFromList(InvitationEntity invitation) async {
    final strings = context.l10n;
    final provider = context.read<InvitationsProvider>();

    final proceed = await InvitationImportantDialog.show(context);
    if (!proceed || !context.mounted) {
      return;
    }

    await provider.refreshPaymentMethodStatus();

    if (!provider.hasPaymentMethod) {
      final saved = await AddPaymentMethodDialog.show(
        context,
        onSave: provider.savePaymentMethod,
      );
      if (!saved || !context.mounted) {
        _screenActions.showError(
          AppStrings.invitationsGpPaymentRequired(strings),
        );
        return;
      }
    }

    final confirmed = await provider.confirmInvitation(
      invitation.id,
      params: const ConfirmInvitationParams(acceptChargeTerms: true),
    );
    await _screenActions.handleSessionInvalid(provider);

    if (!context.mounted) {
      return;
    }

    if (!confirmed) {
      final error =
          provider.localizedErrorMessage(strings) ?? strings.errorGeneric;
      _screenActions.showError(error);
    }
  }

  Future<void> acceptFromDetail(InvitationEntity invitation) async {
    final strings = context.l10n;
    final provider = context.read<InvitationsProvider>();

    final proceed = await GuaranteedPassAcceptDialog.show(context, invitation);
    if (!proceed || !context.mounted) {
      return;
    }

    final authenticated = await sl<DeviceAuthService>().authenticate(
      reason: AppStrings.invitationsBiometricReason(strings),
    );
    if (!authenticated) {
      if (context.mounted) {
        _screenActions.showError(
          AppStrings.accountDeletionBiometricFailed(strings),
        );
      }
      return;
    }

    if (!context.mounted) {
      return;
    }

    await provider.refreshPaymentMethodStatus();

    if (!provider.hasPaymentMethod) {
      final saved = await AddPaymentMethodDialog.show(
        context,
        onSave: provider.savePaymentMethod,
      );
      if (!saved || !context.mounted) {
        _screenActions.showError(
          AppStrings.invitationsGpPaymentRequired(strings),
        );
        return;
      }
    }

    final confirmed = await provider.confirmInvitation(
      invitation.id,
      params: const ConfirmInvitationParams(acceptChargeTerms: true),
    );
    await _screenActions.handleSessionInvalid(provider);

    if (!context.mounted) {
      return;
    }

    if (!confirmed) {
      final error =
          provider.localizedErrorMessage(strings) ?? strings.errorGeneric;
      _screenActions.showError(error);
      return;
    }

    await Navigator.of(context).pushNamed(
      AppRoutes.guaranteedPassActive,
      arguments: GuaranteedPassActiveRouteArgs(
        eventTitle: invitation.eventTitle,
        cancellationDeadlineLabel: invitation.cancellationDeadlineLabel,
      ),
    );
  }

  Future<void> reject(String invitationId) {
    return _screenActions.rejectInvitation(invitationId);
  }

  Future<void> cancelConfirmedPass(
    InvitationEntity invitation, {
    bool popOnSuccess = true,
  }) async {
    final strings = context.l10n;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(AppStrings.invitationsGpCancelTitle(strings)),
        content: Text(AppStrings.invitationsGpCancelMessage(strings)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(AppStrings.invitationsDialogCancel(strings)),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(AppStrings.invitationsGpCancelConfirm(strings)),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) {
      return;
    }

    final provider = context.read<InvitationsProvider>();
    final cancelled = await provider.cancelInvitation(invitation.id);
    await _screenActions.handleSessionInvalid(provider);

    if (!context.mounted) {
      return;
    }

    if (cancelled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppStrings.invitationsGpCancelSuccess(strings))),
      );
      if (popOnSuccess) {
        Navigator.of(context).pop();
      }
      return;
    }

    final error = provider.localizedErrorMessage(strings);
    if (error != null) {
      _screenActions.showError(error);
    }
  }
}
