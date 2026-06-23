import 'package:flutter/material.dart';
import 'package:youpass/features/home/presentation/party_drinks/models/party_drink_item.dart';
import 'package:youpass/features/home/presentation/party_drinks/party_drinks_design_spec.dart';
import 'package:youpass/features/home/presentation/party_drinks/utils/party_drink_cart_calculator.dart';
import 'package:youpass/features/home/presentation/party_drinks/utils/party_drink_cart_quantities.dart';
import 'package:youpass/features/home/presentation/party_drinks/widgets/party_drink_checkout_line_item_widget.dart';
import 'package:youpass/features/home/presentation/party_drinks/widgets/party_drink_checkout_payment_method_card_widget.dart';
import 'package:youpass/features/home/presentation/party_drinks/widgets/party_drink_checkout_price_breakdown_widget.dart';
import 'package:youpass/features/home/presentation/party_drinks/widgets/party_drink_checkout_sheet_footer_widget.dart';
import 'package:youpass/features/home/presentation/party_drinks/widgets/party_drink_checkout_sheet_header_widget.dart';

class PartyDrinkCheckoutSummarySheet extends StatefulWidget {
  const PartyDrinkCheckoutSummarySheet({
    super.key,
    required this.quantities,
    required this.drinks,
    required this.onQuantitiesChanged,
    required this.onPurchaseCompleted,
  });

  final Map<String, int> quantities;
  final List<PartyDrinkItem> drinks;
  final ValueChanged<Map<String, int>> onQuantitiesChanged;
  final Future<void> Function(PartyDrinkCartSummary cart) onPurchaseCompleted;

  static Future<void> show({
    required BuildContext context,
    required Map<String, int> quantities,
    required List<PartyDrinkItem> drinks,
    required ValueChanged<Map<String, int>> onQuantitiesChanged,
    required Future<void> Function(PartyDrinkCartSummary cart) onPurchaseCompleted,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => PartyDrinkCheckoutSummarySheet(
        quantities: PartyDrinkCartQuantities.copy(quantities),
        drinks: drinks,
        onQuantitiesChanged: onQuantitiesChanged,
        onPurchaseCompleted: onPurchaseCompleted,
      ),
    );
  }

  @override
  State<PartyDrinkCheckoutSummarySheet> createState() =>
      _PartyDrinkCheckoutSummarySheetState();
}

class _PartyDrinkCheckoutSummarySheetState
    extends State<PartyDrinkCheckoutSummarySheet> {
  late Map<String, int> _quantities;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _quantities = PartyDrinkCartQuantities.copy(widget.quantities);
  }

  PartyDrinkCartSummary get _cart =>
      PartyDrinkCartCalculator.summarize(_quantities, widget.drinks);

  void _notifyParent() {
    widget.onQuantitiesChanged(PartyDrinkCartQuantities.copy(_quantities));
  }

  void _adjustQuantity(String drinkId, int delta) {
    setState(() => PartyDrinkCartQuantities.adjust(_quantities, drinkId, delta));
    _notifyParent();
    if (!_cart.hasItems && mounted) {
      Navigator.of(context).pop();
    }
  }

  void _close() => Navigator.of(context).pop();

  Future<void> _completePurchase() async {
    final cart = _cart;
    if (!cart.hasItems || _isSubmitting) {
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      await widget.onPurchaseCompleted(cart);
      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (_) {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = _cart;
    final screenHeight = MediaQuery.sizeOf(context).height;
    final topInset = screenHeight * 0.06;
    final horizontalPadding = PartyDrinksDesignSpec.px(
      context,
      PartyDrinksDesignSpec.horizontalPadding,
    );
    final topRadius = PartyDrinksDesignSpec.px(
      context,
      PartyDrinksDesignSpec.checkoutTopRadius,
    );

    return Padding(
      padding: EdgeInsets.only(top: topInset),
      child: Material(
        color: Colors.black,
        borderRadius: BorderRadius.vertical(top: Radius.circular(topRadius)),
        clipBehavior: Clip.antiAlias,
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: screenHeight - topInset,
            child: Column(
              children: [
                PartyDrinkCheckoutSheetHeaderWidget(onCloseTap: _close),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                    children: [
                      ...cart.lineItems.map(
                        (lineItem) => PartyDrinkCheckoutLineItemWidget(
                          lineItem: lineItem,
                          onDecrement: () =>
                              _adjustQuantity(lineItem.drink.id, -1),
                          onIncrement: () =>
                              _adjustQuantity(lineItem.drink.id, 1),
                        ),
                      ),
                      SizedBox(height: PartyDrinksDesignSpec.px(context, 20)),
                      PartyDrinkCheckoutPriceBreakdownWidget(cart: cart),
                      SizedBox(height: PartyDrinksDesignSpec.px(context, 20)),
                      PartyDrinkCheckoutPaymentMethodCardWidget(
                        onChangeTap: () {},
                      ),
                      SizedBox(height: PartyDrinksDesignSpec.px(context, 16)),
                    ],
                  ),
                ),
                PartyDrinkCheckoutSheetFooterWidget(
                  onPurchaseTap: _isSubmitting ? () {} : _completePurchase,
                  isSubmitting: _isSubmitting,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
