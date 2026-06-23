import 'package:flutter/material.dart';
import 'package:youpass/core/theme/qr_screen_theme.dart';
import 'package:youpass/dependency_injection/injection_container.dart';
import 'package:youpass/core/services/screen_secure_service.dart';
import 'package:youpass/features/home/presentation/party_drinks/party_drinks_design_spec.dart';
import 'package:youpass/features/home/presentation/party_drinks/routes/party_drink_purchase_success_route_args.dart';
import 'package:youpass/features/home/presentation/party_drinks/utils/party_drink_purchase_confirmation_factory.dart';
import 'package:youpass/features/home/presentation/party_drinks/widgets/party_drink_purchase_success_content_widgets.dart';
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
  final ScreenSecureService _screenSecureService = sl<ScreenSecureService>();
  late final PageController _pageController;
  late int _currentIndex;

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
  }

  @override
  void dispose() {
    _pageController.dispose();
    _screenSecureService.disable();
    super.dispose();
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
            Icons.arrow_back,
            color: QrScreenTheme.accent(context),
            size: InvitationsDesignSpec.px(context, 24),
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
