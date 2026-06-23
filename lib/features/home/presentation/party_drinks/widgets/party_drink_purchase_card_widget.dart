import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/home/presentation/party_drinks/models/party_drink_orders_list_mode.dart';
import 'package:youpass/features/home/presentation/party_drinks/models/party_drink_purchase_display_item.dart';
import 'package:youpass/features/home/presentation/party_drinks/party_drinks_design_spec.dart';
import 'package:youpass/features/home/presentation/party_drinks/utils/party_drink_relative_time_formatter.dart';

class PartyDrinkPurchaseCardWidget extends StatelessWidget {
  const PartyDrinkPurchaseCardWidget({
    super.key,
    required this.item,
    required this.listMode,
    required this.onViewQr,
  });

  final PartyDrinkPurchaseDisplayItem item;
  final PartyDrinkOrdersListMode listMode;
  final VoidCallback? onViewQr;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final line = item.line;
    final order = item.order;
    final isRedeemed = item.isRedeemed;
    final imageSize = PartyDrinksDesignSpec.px(context, 72);
    final isCourtesies = listMode == PartyDrinkOrdersListMode.courtesies;
    final timeLabel = isRedeemed
        ? AppStrings.partyDrinkPurchasesRedeemedAgo(
            strings,
            PartyDrinkRelativeTimeFormatter.format(
              strings,
              order.redeemedAt ?? order.createdAt,
            ),
          )
        : isCourtesies
            ? AppStrings.partyDrinkCourtesiesReceivedAgo(
                strings,
                PartyDrinkRelativeTimeFormatter.format(strings, order.createdAt),
              )
            : AppStrings.partyDrinkPurchasesBoughtAgo(
                strings,
                PartyDrinkRelativeTimeFormatter.format(strings, order.createdAt),
              );

    return Container(
      padding: EdgeInsets.all(PartyDrinksDesignSpec.px(context, 12)),
      decoration: BoxDecoration(
        color: PartyDrinksDesignSpec.cardBackground,
        borderRadius: BorderRadius.circular(
          PartyDrinksDesignSpec.px(context, 14),
        ),
        border: Border.all(
          color: PartyDrinksDesignSpec.checkoutItemCardBorder,
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(
              PartyDrinksDesignSpec.px(context, 10),
            ),
            child: _ProductImage(
              imageUrl: line.imageUrl,
              width: imageSize,
              height: imageSize,
            ),
          ),
          SizedBox(width: PartyDrinksDesignSpec.px(context, 12)),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        line.productName,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: PartyDrinksDesignSpec.px(context, 16),
                          height: 1.15,
                        ),
                      ),
                      SizedBox(height: PartyDrinksDesignSpec.px(context, 2)),
                      Text(
                        AppStrings.partyDrinkPurchasesQuantityLabel(
                          strings,
                          line.quantity,
                          line.productName,
                        ),
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.92),
                          fontWeight: isRedeemed ? FontWeight.w400 : FontWeight.w600,
                          fontSize: PartyDrinksDesignSpec.px(context, 14),
                          height: 1.15,
                        ),
                      ),
                      SizedBox(height: PartyDrinksDesignSpec.px(context, 10)),
                      Text(
                        AppStrings.partyDrinkPurchasesOrderLabel(
                          strings,
                          item.displayOrderId,
                        ),
                        style: TextStyle(
                          color: PartyDrinksDesignSpec.subtitleText,
                          fontSize: PartyDrinksDesignSpec.px(context, 12),
                          height: 1.15,
                        ),
                      ),
                      SizedBox(height: PartyDrinksDesignSpec.px(context, 2)),
                      Text(
                        timeLabel,
                        style: TextStyle(
                          color: PartyDrinksDesignSpec.subtitleText,
                          fontSize: PartyDrinksDesignSpec.px(context, 12),
                          height: 1.15,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: PartyDrinksDesignSpec.px(context, 8)),
                isRedeemed
                    ? _CardActionChip(
                        label: AppStrings.partyDrinkPurchasesRedeemedBadge(strings),
                        icon: Icons.check_rounded,
                      )
                    : _CardActionChip(
                        label: AppStrings.partyDrinkPurchasesViewQr(strings),
                        icon: Icons.qr_code_2_rounded,
                        onTap: onViewQr,
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductImage extends StatelessWidget {
  const _ProductImage({
    required this.imageUrl,
    required this.width,
    required this.height,
  });

  final String? imageUrl;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final url = imageUrl?.trim();
    if (url != null && url.isNotEmpty) {
      return Image.network(
        url,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _placeholder(),
      );
    }

    return _placeholder();
  }

  Widget _placeholder() {
    return Container(
      width: width,
      height: height,
      color: PartyDrinksDesignSpec.checkoutIconCircle,
      child: const Icon(Icons.local_bar_outlined, color: Colors.white54),
    );
  }
}

class _CardActionChip extends StatelessWidget {
  const _CardActionChip({
    required this.label,
    required this.icon,
    this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isRedeemedBadge = onTap == null && icon == Icons.check_rounded;
    final color = onTap != null || isRedeemedBadge
        ? PartyDrinksDesignSpec.gold
        : PartyDrinksDesignSpec.subtitleText;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: PartyDrinksDesignSpec.px(context, 10),
            vertical: PartyDrinksDesignSpec.px(context, 7),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: color),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: color,
                size: PartyDrinksDesignSpec.px(context, 15),
              ),
              SizedBox(width: PartyDrinksDesignSpec.px(context, 5)),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w700,
                  fontSize: PartyDrinksDesignSpec.px(context, 10),
                  letterSpacing: 0.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
