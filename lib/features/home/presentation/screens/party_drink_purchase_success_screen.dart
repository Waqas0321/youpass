import 'dart:async';

import 'package:flutter/material.dart';
import 'package:youpass/core/theme/qr_screen_theme.dart';
import 'package:youpass/dependency_injection/injection_container.dart';
import 'package:youpass/core/services/screen_secure_service.dart';
import 'package:youpass/features/home/data/services/party_drinks_api_service.dart';
import 'package:youpass/features/home/presentation/party_drinks/party_drinks_design_spec.dart';
import 'package:youpass/features/home/presentation/party_drinks/routes/party_drink_purchase_success_route_args.dart';
import 'package:youpass/features/home/presentation/party_drinks/utils/party_drink_purchase_confirmation_factory.dart';
import 'package:youpass/features/home/presentation/party_drinks/widgets/party_drink_purchase_success_content_widgets.dart';
import 'package:youpass/features/home/presentation/party_drinks/widgets/party_drink_qr_accepted_dialog.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';

class PartyDrinkPurchaseSuccessScreen extends StatefulWidget {
  const PartyDrinkPurchaseSuccessScreen({
    super.key,
    required this.args,
  });

  final PartyDrinkPurchaseSuccessRouteArgs args;

  static Widget fromRouteArgs(PartyDrinkPurchaseSuccessRouteArgs args) {
    return PartyDrinkPurchaseSuccessScreen(args: args);
  }

  @override
  State<PartyDrinkPurchaseSuccessScreen> createState() =>
      _PartyDrinkPurchaseSuccessScreenState();
}

class _PartyDrinkPurchaseSuccessScreenState
    extends State<PartyDrinkPurchaseSuccessScreen> {
  static const _pollInterval = Duration(milliseconds: 500);

  final ScreenSecureService _screenSecureService = sl<ScreenSecureService>();
  final PartyDrinksApiService _partyDrinksApi = sl<PartyDrinksApiService>();
  late final PageController _pageController;
  late int _currentIndex;
  Timer? _pollTimer;
  bool _isPolling = false;
  bool _isShowingAcceptedDialog = false;
  final Set<String> _acceptedKeys = <String>{};

  List<PartyDrinkPurchaseConfirmation> get _confirmations =>
      widget.args.confirmations.isNotEmpty
          ? widget.args.confirmations
          : [widget.args.confirmation];

  PartyDrinkPurchaseConfirmation get _activeConfirmation =>
      _confirmations[_currentIndex.clamp(0, _confirmations.length - 1)];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.args.initialIndex.clamp(
      0,
      _confirmations.length - 1,
    );
    _pageController = PageController(initialPage: _currentIndex);
    _screenSecureService.enable();
    _startRedemptionPolling();
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    _pageController.dispose();
    _screenSecureService.disable();
    super.dispose();
  }

  void _startRedemptionPolling() {
    final hasTrackableOrders = _confirmations.any(
      (confirmation) =>
          confirmation.orderId != null && confirmation.orderId!.isNotEmpty,
    );
    if (!hasTrackableOrders) {
      return;
    }

    _pollTimer?.cancel();
    _pollTimer = Timer.periodic(_pollInterval, (_) {
      unawaited(_checkRedemptionStatus());
    });
    unawaited(_checkRedemptionStatus());
  }

  String _acceptanceKey(PartyDrinkPurchaseConfirmation confirmation) {
    final lineId = confirmation.lineId?.trim() ?? '';
    if (lineId.isNotEmpty) {
      return lineId;
    }
    return confirmation.orderId?.trim() ?? confirmation.entryCode;
  }

  Future<void> _checkRedemptionStatus() async {
    if (!mounted || _isPolling || _isShowingAcceptedDialog) {
      return;
    }

    final confirmation = _activeConfirmation;
    final orderId = confirmation.orderId?.trim() ?? '';
    if (orderId.isEmpty) {
      return;
    }

    final key = _acceptanceKey(confirmation);
    if (_acceptedKeys.contains(key)) {
      return;
    }

    _isPolling = true;
    try {
      final order = await _partyDrinksApi.fetchDrinkOrder(orderId);
      if (!mounted) {
        return;
      }

      final lineId = confirmation.lineId?.trim() ?? '';
      final isRedeemed = lineId.isEmpty
          ? order.status == 'redeemed' || order.qrStatus == 'redeemed'
          : order.lineItems.any(
              (line) => line.lineId == lineId && line.isRedeemed,
            );

      if (!isRedeemed) {
        return;
      }

      _acceptedKeys.add(key);
      await _showAcceptedFeedback();
    } catch (_) {
      // Ignore transient polling errors while waiting for a staff scan.
    } finally {
      _isPolling = false;
    }
  }

  Future<void> _showAcceptedFeedback() async {
    if (!mounted || _isShowingAcceptedDialog) {
      return;
    }

    _isShowingAcceptedDialog = true;
    _pollTimer?.cancel();
    try {
      await PartyDrinkQrAcceptedDialog.show(context);
      if (!mounted) {
        return;
      }

      final nextIndex = _confirmations.indexWhere(
        (confirmation) => !_acceptedKeys.contains(_acceptanceKey(confirmation)),
      );
      if (nextIndex == -1) {
        Navigator.of(context).pop();
        return;
      }

      setState(() => _currentIndex = nextIndex);
      if (_pageController.hasClients) {
        await _pageController.animateToPage(
          nextIndex,
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOut,
        );
      }
      _startRedemptionPolling();
    } finally {
      _isShowingAcceptedDialog = false;
    }
  }

  double _qrPageHeight(BuildContext context) {
    final qrSize = InvitationsDesignSpec.px(context, 240);
    final padding = InvitationsDesignSpec.px(context, 20);
    final spacing = InvitationsDesignSpec.px(context, 16) +
        InvitationsDesignSpec.px(context, 14) +
        InvitationsDesignSpec.px(context, 6) +
        InvitationsDesignSpec.px(context, 24);
    return qrSize + padding * 2 + spacing + InvitationsDesignSpec.px(context, 40);
  }

  @override
  Widget build(BuildContext context) {
    final confirmations = _confirmations;
    final horizontalPadding = PartyDrinksDesignSpec.px(
      context,
      PartyDrinksDesignSpec.horizontalPadding,
    );
    final bottomPadding = MediaQuery.paddingOf(context).bottom +
        PartyDrinksDesignSpec.px(context, 24);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        surfaceTintColor: Colors.black,
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: QrScreenTheme.accent(context),
            size: InvitationsDesignSpec.px(context, 20),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(
          horizontalPadding,
          InvitationsDesignSpec.px(context, 8),
          horizontalPadding,
          bottomPadding,
        ),
        children: [
          const PartyDrinkPurchaseSuccessHeaderWidget(),
          SizedBox(height: PartyDrinksDesignSpec.px(context, 28)),
          if (confirmations.length == 1)
            PartyDrinkPurchaseSuccessQrSectionWidget(
              confirmation: confirmations.first,
            )
          else
            SizedBox(
              height: _qrPageHeight(context),
              child: PageView.builder(
                controller: _pageController,
                itemCount: confirmations.length,
                onPageChanged: (index) => setState(() => _currentIndex = index),
                itemBuilder: (context, index) {
                  return Align(
                    alignment: Alignment.topCenter,
                    child: PartyDrinkPurchaseSuccessQrSectionWidget(
                      confirmation: confirmations[index],
                    ),
                  );
                },
              ),
            ),
          SizedBox(height: PartyDrinksDesignSpec.px(context, 28)),
          PartyDrinkPurchaseSuccessFooterWidget(
            confirmation: _activeConfirmation,
          ),
          if (confirmations.length > 1) ...[
            SizedBox(height: PartyDrinksDesignSpec.px(context, 16)),
            Text(
              '${_currentIndex + 1} / ${confirmations.length}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: PartyDrinksDesignSpec.px(context, 14),
                color: QrScreenTheme.subtitle(context),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
