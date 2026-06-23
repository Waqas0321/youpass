import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youpass/features/invitations/presentation/providers/invitations_provider.dart';
import 'package:youpass/features/invitations/presentation/widgets/add_payment_method_dialog.dart';
import 'package:youpass/features/invitations/presentation/widgets/invitation_important_dialog.dart';

/// Payment-method gate for $0 ticket checkout (free registration events).
class FreeTicketCheckoutPaymentFlow {
  const FreeTicketCheckoutPaymentFlow(this.context);

  final BuildContext context;

  Future<bool> ensureBeforeCheckout() async {
    final proceed = await InvitationImportantDialog.show(context);
    if (!proceed || !context.mounted) {
      return false;
    }

    final provider = context.read<InvitationsProvider>();
    await provider.refreshPaymentMethodStatus();

    if (provider.hasPaymentMethod) {
      return true;
    }

    if (!context.mounted) {
      return false;
    }

    return AddPaymentMethodDialog.show(
      context,
      onSave: provider.savePaymentMethod,
    );
  }
}
