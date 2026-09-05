import 'dart:async';

import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/widgets/app_snack_bar.dart';
import 'package:youpass/dependency_injection/injection_container.dart';
import 'package:youpass/features/home/presentation/party_drinks/models/party_drink_item.dart';
import 'package:youpass/features/home/presentation/party_drinks/party_drinks_design_spec.dart';
import 'package:youpass/features/home/presentation/party_drinks/utils/party_drink_cart_calculator.dart';
import 'package:youpass/features/home/presentation/party_drinks/utils/party_drink_cart_quantities.dart';
import 'package:youpass/features/home/presentation/party_drinks/widgets/party_drink_checkout_line_item_widget.dart';
import 'package:youpass/features/home/presentation/party_drinks/widgets/party_drink_checkout_payment_method_card_widget.dart';
import 'package:youpass/features/home/presentation/party_drinks/widgets/party_drink_checkout_price_breakdown_widget.dart';
import 'package:youpass/features/home/presentation/party_drinks/widgets/party_drink_checkout_sheet_footer_widget.dart';
import 'package:youpass/features/home/presentation/party_drinks/widgets/party_drink_checkout_sheet_header_widget.dart';
import 'package:youpass/features/profile/data/models/profile_wallet_card_model.dart';
import 'package:youpass/features/profile/data/services/profile_api_service.dart';
import 'package:youpass/features/profile/presentation/utils/wallet_add_card_flow.dart';

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
  bool _loadingCards = true;
  bool _updatingPaymentMethod = false;
  List<ProfileWalletCardModel> _walletCards = const [];
  String? _selectedCardId;

  @override
  void initState() {
    super.initState();
    _quantities = PartyDrinkCartQuantities.copy(widget.quantities);
    unawaited(_loadWalletCards());
  }

  PartyDrinkCartSummary get _cart =>
      PartyDrinkCartCalculator.summarize(_quantities, widget.drinks);

  ProfileWalletCardModel? get _selectedCard {
    for (final card in _walletCards) {
      if (card.id == _selectedCardId) {
        return card;
      }
    }
    return null;
  }

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

  Future<void> _loadWalletCards() async {
    try {
      final cards = await sl<ProfileApiService>().fetchWalletCards();
      if (!mounted) {
        return;
      }
      String? selected = _selectedCardId;
      if (selected == null || !cards.any((card) => card.id == selected)) {
        selected = null;
        for (final card in cards) {
          if (card.isDefault) {
            selected = card.id;
            break;
          }
        }
        selected ??= cards.isEmpty ? null : cards.first.id;
      }
      setState(() {
        _walletCards = cards;
        _selectedCardId = selected;
        _loadingCards = false;
      });
    } catch (_) {
      if (!mounted) {
        return;
      }
      setState(() => _loadingCards = false);
    }
  }

  Future<void> _addPaymentMethod() async {
    if (_updatingPaymentMethod) {
      return;
    }
    setState(() => _updatingPaymentMethod = true);
    try {
      final added = await WalletAddCardFlow().start(context);
      if (added) {
        await _loadWalletCards();
      }
    } finally {
      if (mounted) {
        setState(() => _updatingPaymentMethod = false);
      } else {
        _updatingPaymentMethod = false;
      }
    }
  }

  Future<void> _openPaymentMethodPicker() async {
    if (_updatingPaymentMethod || _loadingCards) {
      return;
    }

    if (_walletCards.isEmpty) {
      await _addPaymentMethod();
      return;
    }

    final strings = context.l10n;
    final selected = await showModalBottomSheet<Object>(
      context: context,
      backgroundColor: PartyDrinksDesignSpec.checkoutSurface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(PartyDrinksDesignSpec.px(context, 16)),
        ),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                  PartyDrinksDesignSpec.px(sheetContext, 16),
                  PartyDrinksDesignSpec.px(sheetContext, 16),
                  PartyDrinksDesignSpec.px(sheetContext, 16),
                  PartyDrinksDesignSpec.px(sheetContext, 8),
                ),
                child: Text(
                  AppStrings.partyDrinkCheckoutPaymentMethod(strings),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: PartyDrinksDesignSpec.px(sheetContext, 16),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              ..._walletCards.map((card) {
                final isSelected = card.id == _selectedCardId;
                return ListTile(
                  leading: Icon(
                    isSelected
                        ? Icons.radio_button_checked
                        : Icons.radio_button_off,
                    color: Colors.white,
                  ),
                  title: Text(
                    card.maskedLabel,
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: card.displaySubtitle.isEmpty
                      ? null
                      : Text(
                          card.displaySubtitle,
                          style: TextStyle(
                            color: PartyDrinksDesignSpec.checkoutMutedText,
                          ),
                        ),
                  onTap: () => Navigator.of(sheetContext).pop(card.id),
                );
              }),
              ListTile(
                leading: const Icon(Icons.add_circle_outline, color: Colors.white),
                title: Text(
                  AppStrings.vipAddPaymentMethod(strings),
                  style: const TextStyle(color: Colors.white),
                ),
                onTap: () => Navigator.of(sheetContext).pop('__add__'),
              ),
            ],
          ),
        );
      },
    );

    if (!mounted || selected == null) {
      return;
    }
    if (selected == '__add__') {
      await _addPaymentMethod();
      return;
    }
    if (selected is String) {
      setState(() => _selectedCardId = selected);
    }
  }

  Future<void> _completePurchase() async {
    final cart = _cart;
    if (!cart.hasItems || _isSubmitting) {
      return;
    }

    if (_selectedCard == null && cart.grandTotalClp > 0) {
      AppSnackBar.show(
        context,
        AppStrings.vipAddPaymentMethod(context.l10n),
      );
      await _openPaymentMethodPicker();
      if (_selectedCard == null) {
        return;
      }
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
                        card: _selectedCard,
                        isLoading: _loadingCards,
                        isBusy: _updatingPaymentMethod,
                        onTap: _openPaymentMethodPicker,
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
