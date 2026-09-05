import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/profile/data/models/profile_wallet_card_model.dart';
import 'package:youpass/features/vip_venue/domain/entities/vip_purchase_session.dart';
import 'package:youpass/features/vip_venue/presentation/utils/vip_currency_formatter.dart';
import 'package:youpass/features/vip_venue/presentation/utils/vip_purchase_label_helper.dart';
import 'package:youpass/features/vip_venue/presentation/utils/vip_venue_label_helper.dart';
import 'package:youpass/features/vip_venue/presentation/vip_venue_design_spec.dart';
import 'package:youpass/features/vip_venue/presentation/vip_venue_screen_theme.dart';
import 'package:youpass/features/vip_venue/presentation/widgets/vip_purchase_widgets.dart';
import 'package:youpass/features/vip_venue/presentation/widgets/vip_shared_widgets.dart';
import 'package:youpass/features/vip_venue/presentation/widgets/vip_surface_card_widget.dart';

class PurchaseSummaryContentWidget extends StatelessWidget {
  const PurchaseSummaryContentWidget({
    super.key,
    required this.session,
    this.onOfferingQuantityChanged,
    this.cards = const [],
    this.selectedCardId,
    this.isLoadingCards = false,
    this.isAddingPaymentMethod = false,
    this.onSelectCard,
    this.onAddPaymentMethod,
  });

  final VipPurchaseSession session;
  final void Function(String offeringId, int quantity)? onOfferingQuantityChanged;
  final List<ProfileWalletCardModel> cards;
  final String? selectedCardId;
  final bool isLoadingCards;
  final bool isAddingPaymentMethod;
  final ValueChanged<ProfileWalletCardModel>? onSelectCard;
  final VoidCallback? onAddPaymentMethod;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final table = session.selectedTable;
    final zone = session.selectedZone;
    final accent = VipVenueScreenTheme.accent(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (session.isGeneralTicketPurchase) ...[
          ...session.selectedOfferings.map(
            (offering) => VipGeneralTicketSummaryCardWidget(
              offering: offering,
              detailsLine: VipPurchaseLabelHelper.ticketDetailsLine(strings, offering),
              countryIsoCode: session.countryIsoCode,
              currencyDecimals: session.currencyDecimals,
              onQuantityChanged: (quantity) {
                onOfferingQuantityChanged?.call(offering.id, quantity);
              },
            ),
          ),
          VipPurchaseSummaryCardWidget(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                VipAmountRowWidget(
                  label: AppStrings.vipPurchaseSubtotal(strings),
                  amount: VipCurrencyFormatter.formatAmount(
                    context,
                    session.subtotal,
                    currencyCode: session.currency,
                    countryIsoCode: session.countryIsoCode,
                    currencyDecimals: session.currencyDecimals,
                  ),
                  amountColor: VipVenueScreenTheme.title(context),
                ),
                const VipCardDividerWidget(),
                VipAmountRowWidget(
                  label: AppStrings.vipPurchaseServiceCharge(strings),
                  amount: VipCurrencyFormatter.formatAmount(
                    context,
                    session.serviceFee,
                    currencyCode: session.currency,
                    countryIsoCode: session.countryIsoCode,
                    currencyDecimals: session.currencyDecimals,
                  ),
                  amountColor: VipVenueScreenTheme.title(context),
                ),
                const VipCardDividerWidget(),
                VipAmountRowWidget(
                  label: AppStrings.vipPurchaseTotal(strings),
                  amount: VipCurrencyFormatter.formatAmount(
                    context,
                    session.totalAmount,
                    currencyCode: session.currency,
                    countryIsoCode: session.countryIsoCode,
                    currencyDecimals: session.currencyDecimals,
                  ),
                  amountColor: accent,
                  amountSize: 22,
                  labelWeight: FontWeight.w700,
                  amountWeight: FontWeight.w800,
                ),
              ],
            ),
          ),
        ] else ...[
          VipPurchaseSummaryCardWidget(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (table != null && zone != null) ...[
                  VipPurchaseSummaryItemRowWidget(
                    tableNumber:
                        VipVenueLabelHelper.tableDisplayNumber(table.label),
                    zoneName: zone.name,
                    eventTitle: session.event.title,
                    peopleLabel:
                        AppStrings.vipTableCapacity(strings, table.capacity),
                    bottlesLabel:
                        AppStrings.vipTableBottles(strings, table.bottleCount),
                    vouchersLabel:
                        AppStrings.vipTableVouchers(strings, table.voucherCount),
                    amount: table.price,
                    currencyCode: session.currency,
                    countryIsoCode: session.countryIsoCode,
                    currencyDecimals: session.currencyDecimals,
                  ),
                  const VipCardDividerWidget(),
                  VipAmountRowWidget(
                    label: AppStrings.vipServiceFee(strings),
                    amount: VipCurrencyFormatter.formatAmount(
                      context,
                      session.serviceFee,
                      currencyCode: session.currency,
                      countryIsoCode: session.countryIsoCode,
                      currencyDecimals: session.currencyDecimals,
                    ),
                    amountColor: VipVenueScreenTheme.title(context),
                  ),
                  const VipCardDividerWidget(),
                  VipAmountRowWidget(
                    label: AppStrings.vipPurchaseTotal(strings),
                    amount: VipCurrencyFormatter.formatAmount(
                      context,
                      session.totalAmount,
                      currencyCode: session.currency,
                      countryIsoCode: session.countryIsoCode,
                      currencyDecimals: session.currencyDecimals,
                    ),
                    amountColor: accent,
                    amountSize: 22,
                    labelWeight: FontWeight.w700,
                    amountWeight: FontWeight.w800,
                  ),
                ],
              ],
            ),
          ),
        ],
        SizedBox(height: VipVenueDesignSpec.px(context, 24)),
        VipPurchaseSectionLabelWidget(
          label: AppStrings.vipPaymentMethod(strings),
        ),
        SizedBox(height: VipVenueDesignSpec.px(context, 10)),
        if (isLoadingCards)
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: VipVenueDesignSpec.px(context, 16),
            ),
            child: Center(
              child: SizedBox(
                width: VipVenueDesignSpec.px(context, 22),
                height: VipVenueDesignSpec.px(context, 22),
                child: CircularProgressIndicator(
                  strokeWidth: 2.4,
                  color: accent,
                ),
              ),
            ),
          )
        else ...[
          ...cards.map((card) {
            final brand = card.brand.toLowerCase();
            return VipPurchasePaymentMethodTileWidget(
              brandLabel: brand == 'mastercard'
                  ? AppStrings.paymentBrandMastercard(strings)
                  : AppStrings.paymentBrandVisa(strings),
              cardLabel: card.maskedLabel,
              defaultLabel:
                  card.isDefault ? AppStrings.profileDefaultCard(strings) : null,
              selected: card.id == selectedCardId,
              onTap: () => onSelectCard?.call(card),
              brandColor: brand == 'mastercard'
                  ? AppColors.profileMastercardBrand
                  : AppColors.profileVisaBrand,
            );
          }),
        ],
        VipPurchaseAddPaymentMethodTileWidget(
          label: AppStrings.vipAddPaymentMethod(strings),
          onTap: onAddPaymentMethod,
          isLoading: isAddingPaymentMethod,
        ),
        SizedBox(height: VipVenueDesignSpec.px(context, 16)),
        VipPurchaseAssignTicketsInfoWidget(
          message: AppStrings.vipPurchaseAssignTicketsInfo(
            strings,
            AppStrings.drawerMyTickets(strings),
          ),
          highlight: AppStrings.drawerMyTickets(strings),
        ),
      ],
    );
  }
}
