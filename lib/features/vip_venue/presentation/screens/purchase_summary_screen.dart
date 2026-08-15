import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/l10n/app_message_localizer.dart';
import 'package:youpass/core/l10n/tickets_error_extension.dart';
import 'package:youpass/features/invitations/presentation/routes/event_ticket_route_args.dart';
import 'package:youpass/features/invitations/presentation/utils/invitations_qr_helper.dart';
import 'package:youpass/features/invitations/presentation/widgets/invitation_qr_unavailable_dialog.dart';
import 'package:youpass/core/utils/payment_url_launcher.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/event_checkout_result_entity.dart';
import 'package:youpass/features/ticket_assignment/presentation/providers/ticket_assignment_provider.dart';
import 'package:youpass/features/ticket_assignment/presentation/routes/assign_tickets_route_args.dart';
import 'package:youpass/features/tickets/presentation/providers/tickets_provider.dart';
import 'package:youpass/features/vip_venue/domain/entities/vip_purchase_checkout.dart';
import 'package:youpass/features/vip_venue/domain/entities/vip_purchase_session.dart';
import 'package:youpass/features/vip_venue/presentation/providers/vip_venue_provider.dart';
import 'package:youpass/features/vip_venue/presentation/routes/vip_purchase_route_args.dart';
import 'package:youpass/features/vip_venue/presentation/utils/free_ticket_checkout_payment_flow.dart';
import 'package:youpass/features/vip_venue/presentation/utils/vip_currency_formatter.dart';
import 'package:youpass/features/vip_venue/presentation/vip_venue_design_spec.dart';
import 'package:youpass/features/vip_venue/presentation/widgets/purchase_success_dialog.dart';
import 'package:youpass/features/vip_venue/presentation/widgets/purchase_summary_content_widget.dart';
import 'package:youpass/features/vip_venue/presentation/widgets/vip_flow_scaffold.dart';
import 'package:youpass/features/vip_venue/presentation/widgets/vip_navigation_widgets.dart';
import 'package:youpass/features/vip_venue/presentation/widgets/vip_table_lock_countdown_widget.dart';
import 'package:youpass/features/vip_venue/presentation/widgets/vip_table_lock_expired_dialog.dart';
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
  bool _lockExpired = false;
  bool _warmingCheckout = false;
  Future<bool>? _tableLockFuture;
  bool _redirectedToPayment = false;
  String? checkoutTicketId;
  String? checkoutOrderId;
  String? checkoutSeatLabel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _warmCheckout());
  }

  Future<void> _warmCheckout() async {
    if (!session.isVipTablePurchase || _hasActiveTableLock || _warmingCheckout) {
      return;
    }

    _warmingCheckout = true;
    _tableLockFuture = _ensureTableLockedForCheckout();
    await _tableLockFuture;
    _warmingCheckout = false;
  }

  bool get _hasActiveTableLock =>
      session.isVipTablePurchase &&
      session.tableLockExpiresAt != null &&
      session.tableLockExpiresAt!.isAfter(DateTime.now());

  Future<void> _releaseTableLockIfHeld() async {
    if (paymentCompleted || !_hasActiveTableLock) {
      return;
    }

    final table = session.selectedTable;
    if (table == null) {
      return;
    }

    await context.read<VipVenueProvider>().releaseTableLock(
          eventId: session.event.id,
          tableId: table.id,
        );

    if (!mounted) {
      return;
    }

    session.tableLockExpiresAt = null;
    session.tableLockId = null;
    _tableLockFuture = null;
  }

  Future<bool> _ensureTableLockForPayment() async {
    if (_hasActiveTableLock) {
      return true;
    }

    _tableLockFuture ??= _ensureTableLockedForCheckout();
    return _tableLockFuture!;
  }

  Future<bool> _ensureTableLockedForCheckout() async {
    final table = session.selectedTable;
    if (table == null) {
      return false;
    }

    if (_hasActiveTableLock) {
      return true;
    }

    final lock = await context.read<VipVenueProvider>().lockTable(
          eventId: session.event.id,
          tableId: table.id,
        );

    if (!mounted) {
      return false;
    }

    if (lock == null) {
      final provider = context.read<VipVenueProvider>();
      final strings = context.l10n;
      final message = provider.errorCode == 'TABLE_LOCKED'
          ? AppStrings.vipTableBlockedReserve(strings)
          : AppMessageLocalizer.fromApiError(
              strings,
              code: provider.errorCode,
              fallbackMessage: provider.errorMessage,
            );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
      _tableLockFuture = null;
      return false;
    }

    setState(() {
      session.tableLockId = lock.lockId;
      session.tableLockExpiresAt = lock.expiresAt;
      if (lock.table.price > 0) {
        session.selectedTable = lock.table;
      }
      _lockExpired = false;
      _lockExpiredHandled = false;
      _tableLockFuture = null;
    });
    return true;
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
    _redirectedToPayment = false;

    try {
      if (session.isVipTablePurchase) {
        final locked = await _ensureTableLockForPayment();
        if (!mounted) {
          return;
        }
        if (!locked) {
          return;
        }
      }

      if (session.totalAmount == 0) {
        final paymentReady =
            await FreeTicketCheckoutPaymentFlow(context).ensureBeforeCheckout();
        if (!mounted) {
          return;
        }
        if (!paymentReady) {
          return;
        }
      }

      final success = await _attemptCheckout(
        allowTableRelock: session.isVipTablePurchase,
      );

      if (!mounted) {
        return;
      }

      if (!success &&
          session.isVipTablePurchase &&
          !paymentCompleted &&
          !_redirectedToPayment) {
        await _releaseTableLockIfHeld();
        if (mounted) {
          setState(() {
            _lockExpired = false;
            _lockExpiredHandled = false;
          });
        }
      }
    } finally {
      if (mounted) {
        setState(() => isSubmitting = false);
      }
    }
  }

  Future<bool> _attemptCheckout({required bool allowTableRelock}) async {
    final assignmentProvider = context.read<TicketAssignmentProvider>();
    final result = await assignmentProvider.checkoutEvent(
      eventId: session.event.id,
      request: session.buildCheckoutRequest(),
    );

    if (!mounted) {
      return false;
    }

    if (result == null) {
      final code = assignmentProvider.errorCode;
      if (code == 'TABLE_LOCK_REQUIRED' &&
          allowTableRelock &&
          session.isVipTablePurchase) {
        final table = session.selectedTable;
        if (table != null) {
          final lock = await context.read<VipVenueProvider>().lockTable(
                eventId: session.event.id,
                tableId: table.id,
              );
          if (lock != null && mounted) {
            session.tableLockId = lock.lockId;
            session.tableLockExpiresAt = lock.expiresAt;
            return _attemptCheckout(allowTableRelock: false);
          }
        }
      }

      if (code == 'INSUFFICIENT_STOCK' || code == 'TICKET_OFFERING_SOLD_OUT') {
        await _refreshTicketTypes();
      }

      if (!mounted) {
        return false;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppMessageLocalizer.fromApiError(
              context.l10n,
              code: code,
              fallbackMessage: assignmentProvider.errorMessage,
            ),
          ),
        ),
      );
      return false;
    }

    if (result.isPaymentPending) {
      _redirectedToPayment = true;
      await handlePendingPayment(result);
      return false;
    }

    paymentCompleted = true;
    checkoutTicketId = result.ticketId;
    checkoutOrderId = result.orderId;
    checkoutSeatLabel = result.seatLabel;

    if (!mounted) {
      return false;
    }

    unawaited(context.read<TicketsProvider>().refreshUpcoming());

    await PurchaseSuccessDialog.show(
      context,
      onAssignTickets: navigateToAssignTickets,
      onViewQr: openTicketQr,
      onClose: navigateHomeAfterPurchase,
    );
    return true;
  }

  Future<void> _refreshTicketTypes() async {
    final bundle =
        await context.read<VipVenueProvider>().loadTicketTypes(session.event.id);
    if (!mounted || bundle == null) {
      return;
    }

    setState(() {
      session.offerings = List.from(bundle.offerings);
      session.serviceFeeRate = bundle.serviceFeeRate;
      if (bundle.currency.isNotEmpty) {
        session.purchaseCurrency = bundle.currency;
      }
    });
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

  void navigateToMyTickets() {
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.myTickets,
      (route) => route.isFirst,
    );
  }

  void navigateToAssignTickets() {
    final ticketId = checkoutTicketId?.trim() ?? '';
    if (ticketId.isEmpty) {
      navigateToMyTickets();
      return;
    }

    final orderId = checkoutOrderId?.trim();
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.assignTickets,
      (route) => route.settings.name == AppRoutes.home || route.isFirst,
      arguments: AssignTicketsRouteArgs(
        ticketId: ticketId,
        orderId: (orderId == null || orderId.isEmpty) ? null : orderId,
        eventTitle: session.event.title,
        isVip: session.isVipTablePurchase,
      ),
    );
  }

  void returnToFloorPlan() {
    unawaited(_releaseTableLockIfHeld());
    session.tableLockExpiresAt = null;
    session.tableLockId = null;
    session.selectedTable = null;
    session.selectedZone = null;

    Navigator.of(context).popUntil(
      (route) => route.settings.name == AppRoutes.vipFloorPlan || route.isFirst,
    );
  }

  void handleTableLockExpired() {
    if (!mounted || paymentCompleted || _lockExpiredHandled) {
      return;
    }

    _lockExpiredHandled = true;
    setState(() => _lockExpired = true);
    unawaited(_releaseTableLockIfHeld());

    VipTableLockExpiredDialog.show(
      context,
      onReturnToFloorPlan: returnToFloorPlan,
    );
  }

  Future<void> handleBack() async {
    await _releaseTableLockIfHeld();
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final padding = VipVenueDesignSpec.px(context, VipVenueDesignSpec.horizontalPadding);
    final canPay = session.isVipTablePurchase || session.hasSelectedTickets;
    final lockExpiresAt = session.tableLockExpiresAt;

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop && !paymentCompleted) {
          unawaited(_releaseTableLockIfHeld());
        }
      },
      child: VipFlowScaffold(
      title: AppStrings.vipPurchaseSummaryTitle(strings),
      subtitle: session.event.title,
      body: ListView(
        padding: EdgeInsets.fromLTRB(padding, 0, padding, padding),
        children: [
          if (session.isVipTablePurchase && lockExpiresAt != null && !_lockExpired) ...[
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
        child: VipFlowBottomActionRowWidget(
          backLabel: AppStrings.vipBackButton(strings),
          onBack: handleBack,
          primaryLabel: AppStrings.vipPayButton(
            strings,
            VipCurrencyFormatter.formatAmount(
              context,
              session.totalAmount,
              currencyCode: session.currency,
              countryIsoCode: session.countryIsoCode,
              currencyDecimals: session.currencyDecimals,
            ),
          ),
          onPrimary: submitPayment,
          primaryEnabled: canPay,
          primaryLoading: isSubmitting,
        ),
      ),
      ),
    );
  }
}
