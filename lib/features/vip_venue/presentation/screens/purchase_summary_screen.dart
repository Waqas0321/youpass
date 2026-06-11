import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/l10n/tickets_error_extension.dart';
import 'package:youpass/features/invitations/presentation/routes/event_ticket_route_args.dart';
import 'package:youpass/features/invitations/presentation/utils/invitations_qr_helper.dart';
import 'package:youpass/features/invitations/presentation/widgets/invitation_qr_unavailable_dialog.dart';
import 'package:youpass/core/utils/payment_url_launcher.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/event_checkout_result_entity.dart';
import 'package:youpass/features/ticket_assignment/presentation/providers/ticket_assignment_provider.dart';
import 'package:youpass/features/tickets/presentation/providers/tickets_provider.dart';
import 'package:youpass/features/vip_venue/domain/entities/vip_purchase_checkout.dart';
import 'package:youpass/features/vip_venue/domain/entities/vip_purchase_session.dart';
import 'package:youpass/features/vip_venue/presentation/providers/vip_venue_provider.dart';
import 'package:youpass/features/vip_venue/presentation/routes/vip_purchase_route_args.dart';
import 'package:youpass/features/vip_venue/presentation/utils/vip_currency_formatter.dart';
import 'package:youpass/features/vip_venue/presentation/vip_venue_design_spec.dart';
import 'package:youpass/features/vip_venue/presentation/widgets/purchase_success_dialog.dart';
import 'package:youpass/features/vip_venue/presentation/widgets/purchase_summary_content_widget.dart';
import 'package:youpass/features/vip_venue/presentation/widgets/vip_flow_scaffold.dart';
import 'package:youpass/features/vip_venue/presentation/widgets/vip_primary_button_widget.dart';
import 'package:youpass/features/vip_venue/presentation/widgets/vip_table_lock_countdown_widget.dart';
import 'package:youpass/routes/app_routes.dart';

class PurchaseSummaryScreen extends StatefulWidget {
  const PurchaseSummaryScreen({
    super.key,
    required this.args,
  });

  final VipPurchaseRouteArgs args;

  static Widget fromRouteArgs(VipPurchaseRouteArgs args) {
    return PurchaseSummaryScreen(args: args);
  }

  @override
  State<PurchaseSummaryScreen> createState() => _PurchaseSummaryScreenState();
}

class _PurchaseSummaryScreenState extends State<PurchaseSummaryScreen> {
  late final VipPurchaseSession session = widget.args.session;
  bool isSubmitting = false;
  bool paymentCompleted = false;
  bool _lockExpiredHandled = false;
  String? checkoutTicketId;
  String? checkoutSeatLabel;
  VipVenueProvider? _vipVenueProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _vipVenueProvider ??= context.read<VipVenueProvider>();
  }

  @override
  void dispose() {
    if (!paymentCompleted && session.isVipTablePurchase) {
      final table = session.selectedTable;
      if (table != null) {
        _vipVenueProvider?.releaseTableLock(
          eventId: session.event.id,
          tableId: table.id,
        );
      }
    }
    super.dispose();
  }

  void updateOfferingQuantity(String offeringId, int quantity) {
    setState(() {
      final index = session.offerings.indexWhere((item) => item.id == offeringId);
      if (index == -1) {
        return;
      }
      session.offerings[index] =
          session.offerings[index].copyWith(quantity: quantity);
    });
  }

  Future<void> submitPayment() async {
    if (isSubmitting ||
        (!session.hasSelectedTickets && !session.isVipTablePurchase)) {
      return;
    }

    setState(() => isSubmitting = true);

    final assignmentProvider = context.read<TicketAssignmentProvider>();
    final result = await assignmentProvider.checkoutEvent(
      eventId: session.event.id,
      request: session.buildCheckoutRequest(),
    );

    if (!mounted) {
      return;
    }

    setState(() => isSubmitting = false);

    if (result == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            assignmentProvider.errorMessage ?? AppStrings.errorGeneric(context.l10n),
          ),
        ),
      );
      return;
    }

    if (result.isPaymentPending) {
      await handlePendingPayment(result);
      return;
    }

    paymentCompleted = true;
    checkoutTicketId = result.ticketId;
    checkoutSeatLabel = result.seatLabel;

    await PurchaseSuccessDialog.show(
      context,
      onViewQr: () => openTicketQr(),
    );
  }

  Future<void> handlePendingPayment(EventCheckoutResultEntity result) async {
    final strings = context.l10n;

    if (result.gateway == 'klap' &&
        result.paymentUrl != null &&
        result.paymentUrl!.isNotEmpty) {
      final opened = await PaymentUrlLauncher.openExternalUrl(result.paymentUrl!);
      if (!mounted) {
        return;
      }

      if (!opened) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppStrings.errorGeneric(strings))),
        );
      }
      return;
    }

    if (result.gateway == 'stripe' && result.stripeClientSecret != null) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppStrings.errorGeneric(strings))),
      );
      return;
    }

    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppStrings.errorGeneric(strings))),
    );
  }

  Future<void> openTicketQr() async {
    final strings = context.l10n;
    final ticketId = checkoutTicketId;

    if (ticketId == null || ticketId.isEmpty) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppStrings.errorGeneric(strings))),
      );
      navigateHomeAfterPurchase();
      return;
    }

    final provider = context.read<TicketsProvider>();
    final qrTicket = await provider.loadTicketQr(ticketId);
    if (!mounted) {
      return;
    }

    if (qrTicket != null) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        AppRoutes.eventTicket,
        (route) => route.settings.name == AppRoutes.home || route.isFirst,
        arguments: EventTicketRouteArgs(ticket: qrTicket),
      );
      return;
    }

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
      if (!mounted) {
        return;
      }
      navigateHomeAfterPurchase();
      return;
    }

    final error = provider.localizedUpcomingErrorMessage(strings);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error ?? AppStrings.errorGeneric(strings)),
      ),
    );
    navigateHomeAfterPurchase();
  }

  void navigateHomeAfterPurchase() {
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.home,
      (route) => route.isFirst,
    );
  }

  void handleTableLockExpired() {
    if (!mounted || paymentCompleted || _lockExpiredHandled) {
      return;
    }

    _lockExpiredHandled = true;
    session.tableLockExpiresAt = null;
    session.selectedTable = null;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppStrings.vipTableLockExpired(context.l10n))),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final padding = VipVenueDesignSpec.px(context, VipVenueDesignSpec.horizontalPadding);
    final canPay = session.isVipTablePurchase || session.hasSelectedTickets;
    final lockExpiresAt = session.tableLockExpiresAt;

    return VipFlowScaffold(
      title: AppStrings.vipPurchaseSummaryTitle(strings),
      subtitle: session.event.title,
      body: ListView(
        padding: EdgeInsets.fromLTRB(padding, 0, padding, padding),
        children: [
          if (session.isVipTablePurchase && lockExpiresAt != null) ...[
            VipTableLockCountdownWidget(
              expiresAt: lockExpiresAt,
              onExpired: handleTableLockExpired,
            ),
            SizedBox(height: VipVenueDesignSpec.px(context, 12)),
          ],
          PurchaseSummaryContentWidget(
            session: session,
            onOfferingQuantityChanged: updateOfferingQuantity,
          ),
        ],
      ),
      bottomBar: SafeArea(
        minimum: EdgeInsets.fromLTRB(padding, 0, padding, padding),
        child: VipPrimaryButtonWidget(
          label: AppStrings.vipPayButton(
            strings,
            VipCurrencyFormatter.formatAmountCompact(
              context,
              session.totalAmount,
              currencyCode: session.currency,
              countryIsoCode: session.countryIsoCode,
            ),
          ),
          onPressed: canPay ? submitPayment : null,
          isLoading: isSubmitting,
        ),
      ),
    );
  }
}
