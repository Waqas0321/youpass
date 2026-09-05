import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/widgets/app_rich_text.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/features/vip_venue/domain/entities/ticket_offering_entity.dart';
import 'package:youpass/features/vip_venue/presentation/utils/vip_currency_formatter.dart';
import 'package:youpass/features/vip_venue/presentation/vip_venue_design_spec.dart';
import 'package:youpass/features/vip_venue/presentation/vip_venue_screen_theme.dart';
import 'package:youpass/features/vip_venue/presentation/widgets/vip_shared_widgets.dart';
import 'package:youpass/features/vip_venue/presentation/widgets/vip_surface_card_widget.dart';
import 'package:youpass/features/vip_venue/presentation/widgets/vip_ticket_quantity_stepper_widget.dart';

class VipPurchaseSummaryCardWidget extends StatelessWidget {
  const VipPurchaseSummaryCardWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return VipSurfaceCardWidget(
      padding: EdgeInsets.all(VipVenueDesignSpec.px(context, 16)),
      backgroundColor: VipVenueScreenTheme.summaryCardBackground(context),
      borderColor: Colors.transparent,
      boxShadow: const [],
      radius: VipVenueDesignSpec.px(context, 16),
      child: child,
    );
  }
}

class VipGeneralTicketSummaryCardWidget extends StatelessWidget {
  const VipGeneralTicketSummaryCardWidget({
    super.key,
    required this.offering,
    required this.detailsLine,
    required this.onQuantityChanged,
    this.countryIsoCode,
    this.currencyDecimals,
  });

  final TicketOfferingEntity offering;
  final String detailsLine;
  final ValueChanged<int> onQuantityChanged;
  final String? countryIsoCode;
  final int? currencyDecimals;

  @override
  Widget build(BuildContext context) {
    final accent = VipVenueScreenTheme.accent(context);

    return VipSurfaceCardWidget(
      margin: EdgeInsets.only(bottom: VipVenueDesignSpec.px(context, 12)),
      boxShadow: const [],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VipIconBadgeWidget(
                icon: Icons.confirmation_number_outlined,
                size: 40,
                iconSize: 20,
              ),
              SizedBox(width: VipVenueDesignSpec.px(context, 12)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      offering.label,
                      variant: AppTextVariant.bodyEmphasis,
                      color: accent,
                      fontSize: VipVenueDesignSpec.px(context, 14),
                      fontWeight: FontWeight.w800,
                    ),
                    SizedBox(height: VipVenueDesignSpec.px(context, 4)),
                    AppText(
                      detailsLine,
                      variant: AppTextVariant.body,
                      color: VipVenueScreenTheme.body(context),
                      fontSize: VipVenueDesignSpec.px(context, 12),
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
              AppText(
                VipCurrencyFormatter.formatAmount(
                  context,
                  offering.lineTotal,
                  currencyCode: offering.currency,
                  countryIsoCode: countryIsoCode,
                  currencyDecimals: currencyDecimals,
                ),
                variant: AppTextVariant.bodyEmphasis,
                color: VipVenueScreenTheme.title(context),
                fontSize: VipVenueDesignSpec.px(context, 14),
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
          SizedBox(height: VipVenueDesignSpec.px(context, 12)),
          VipTicketQuantityStepperWidget(
            quantity: offering.quantity,
            onChanged: onQuantityChanged,
          ),
        ],
      ),
    );
  }
}

class VipPurchaseSummaryItemRowWidget extends StatelessWidget {
  const VipPurchaseSummaryItemRowWidget({
    super.key,
    required this.tableNumber,
    required this.zoneName,
    required this.eventTitle,
    required this.peopleLabel,
    required this.bottlesLabel,
    required this.vouchersLabel,
    required this.amount,
    this.currencyCode = 'CLP',
    this.countryIsoCode = 'CL',
    this.currencyDecimals,
  });

  final String tableNumber;
  final String zoneName;
  final String eventTitle;
  final String peopleLabel;
  final String bottlesLabel;
  final String vouchersLabel;
  final int amount;
  final String currencyCode;
  final String countryIsoCode;
  final int? currencyDecimals;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VipIconBadgeWidget(
          icon: Icons.table_restaurant_outlined,
          size: 40,
          iconSize: 20,
        ),
        SizedBox(width: VipVenueDesignSpec.px(context, 12)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                AppStrings.vipPurchaseSummaryItemTitle(
                  strings,
                  tableNumber,
                  zoneName,
                  eventTitle,
                ),
                variant: AppTextVariant.bodyEmphasis,
                color: VipVenueScreenTheme.title(context),
                fontSize: VipVenueDesignSpec.px(context, 14),
                fontWeight: FontWeight.w800,
                height: 1.25,
              ),
              SizedBox(height: VipVenueDesignSpec.px(context, 4)),
              AppText(
                AppStrings.vipTableIncludesShort(
                  strings,
                  peopleLabel,
                  bottlesLabel,
                  vouchersLabel,
                ),
                variant: AppTextVariant.body,
                color: VipVenueScreenTheme.body(context),
                fontSize: VipVenueDesignSpec.px(context, 12),
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ),
        SizedBox(width: VipVenueDesignSpec.px(context, 8)),
        AppText(
          VipCurrencyFormatter.formatAmount(
            context,
            amount,
            currencyCode: currencyCode,
            countryIsoCode: countryIsoCode,
            currencyDecimals: currencyDecimals,
          ),
          variant: AppTextVariant.bodyEmphasis,
          color: VipVenueScreenTheme.title(context),
          fontSize: VipVenueDesignSpec.px(context, 14),
          fontWeight: FontWeight.w700,
        ),
      ],
    );
  }
}

class VipPurchasePaymentMethodTileWidget extends StatelessWidget {
  const VipPurchasePaymentMethodTileWidget({
    super.key,
    required this.brandLabel,
    required this.cardLabel,
    this.defaultLabel,
    this.selected = true,
    this.onTap,
    this.brandColor,
  });

  final String brandLabel;
  final String cardLabel;
  final String? defaultLabel;
  final bool selected;
  final VoidCallback? onTap;
  final Color? brandColor;

  @override
  Widget build(BuildContext context) {
    final accent = VipVenueScreenTheme.accent(context);
    final badgeColor = brandColor ?? AppColors.profileVisaBrand;

    return Padding(
      padding: EdgeInsets.only(bottom: VipVenueDesignSpec.px(context, 10)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(VipVenueDesignSpec.px(context, 12)),
          child: Ink(
            decoration: BoxDecoration(
              color: VipVenueScreenTheme.cardBackground(context),
              borderRadius: BorderRadius.circular(VipVenueDesignSpec.px(context, 12)),
              border: Border.all(
                color: selected ? accent : VipVenueScreenTheme.cardBorder(context),
                width: selected ? 1.5 : 1,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: VipVenueDesignSpec.px(context, 14),
                vertical: VipVenueDesignSpec.px(context, 12),
              ),
              child: Row(
                children: [
                  Container(
                    width: VipVenueDesignSpec.px(context, 42),
                    height: VipVenueDesignSpec.px(context, 28),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: badgeColor,
                      borderRadius:
                          BorderRadius.circular(VipVenueDesignSpec.px(context, 6)),
                    ),
                    child: AppText(
                      brandLabel,
                      variant: AppTextVariant.sectionCaption,
                      color: Colors.white,
                      fontSize: VipVenueDesignSpec.px(context, 10),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(width: VipVenueDesignSpec.px(context, 12)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          cardLabel,
                          variant: AppTextVariant.bodyEmphasis,
                          color: VipVenueScreenTheme.title(context),
                          fontSize: VipVenueDesignSpec.px(context, 14),
                          fontWeight: FontWeight.w700,
                        ),
                        if (defaultLabel != null && defaultLabel!.isNotEmpty) ...[
                          SizedBox(height: VipVenueDesignSpec.px(context, 4)),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: VipVenueDesignSpec.px(context, 8),
                              vertical: VipVenueDesignSpec.px(context, 2),
                            ),
                            decoration: BoxDecoration(
                              color: accent.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(
                                VipVenueDesignSpec.px(context, 10),
                              ),
                            ),
                            child: AppText(
                              defaultLabel!,
                              variant: AppTextVariant.sectionCaption,
                              color: accent,
                              fontSize: VipVenueDesignSpec.px(context, 10),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Icon(
                    selected
                        ? Icons.radio_button_checked
                        : Icons.radio_button_off,
                    color: selected
                        ? accent
                        : VipVenueScreenTheme.muted(context),
                    size: VipVenueDesignSpec.px(context, 20),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class VipPurchaseAddPaymentMethodTileWidget extends StatelessWidget {
  const VipPurchaseAddPaymentMethodTileWidget({
    super.key,
    required this.label,
    this.onTap,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback? onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final accent = VipVenueScreenTheme.accent(context);
    final radius = VipVenueDesignSpec.px(context, 12);
    final enabled = onTap != null && !isLoading;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: BorderRadius.circular(radius),
        child: VipDashedBorderContainerWidget(
          radius: radius,
          child: Row(
        children: [
          Container(
            width: VipVenueDesignSpec.px(context, 28),
            height: VipVenueDesignSpec.px(context, 28),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: accent, width: 1.5),
            ),
            child: isLoading
                ? Padding(
                    padding: EdgeInsets.all(VipVenueDesignSpec.px(context, 5)),
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: accent,
                    ),
                  )
                : Icon(
                    Icons.add,
                    color: accent,
                    size: VipVenueDesignSpec.px(context, 16),
                  ),
          ),
          SizedBox(width: VipVenueDesignSpec.px(context, 12)),
          Expanded(
            child: AppText(
              label,
              variant: AppTextVariant.bodyEmphasis,
              color: VipVenueScreenTheme.title(context),
              fontSize: VipVenueDesignSpec.px(context, 14),
              fontWeight: FontWeight.w600,
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: VipVenueScreenTheme.muted(context),
            size: VipVenueDesignSpec.px(context, 20),
          ),
        ],
      ),
        ),
      ),
    );
  }
}

class VipPurchaseAssignTicketsInfoWidget extends StatelessWidget {
  const VipPurchaseAssignTicketsInfoWidget({
    super.key,
    required this.message,
    required this.highlight,
  });

  final String message;
  final String highlight;

  @override
  Widget build(BuildContext context) {
    final accent = VipVenueScreenTheme.accent(context);
    final parts = message.split(highlight);

    return VipSurfaceCardWidget(
      backgroundColor: VipVenueScreenTheme.summaryCardBackground(context),
      borderColor: Colors.transparent,
      boxShadow: const [],
      radius: VipVenueDesignSpec.px(context, 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.shield_outlined,
            color: accent,
            size: VipVenueDesignSpec.px(context, 22),
          ),
          SizedBox(width: VipVenueDesignSpec.px(context, 12)),
          Expanded(
            child: AppRichText(
              variant: AppTextVariant.body,
              children: [
                if (parts.isNotEmpty)
                  AppRichText.span(
                    context,
                    parts.first,
                    color: VipVenueScreenTheme.body(context),
                  ),
                AppRichText.span(
                  context,
                  highlight,
                  color: accent,
                  fontWeight: FontWeight.w800,
                ),
                if (parts.length > 1)
                  AppRichText.span(
                    context,
                    parts.last,
                    color: VipVenueScreenTheme.body(context),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class VipDashedBorderContainerWidget extends StatelessWidget {
  const VipDashedBorderContainerWidget({
    super.key,
    required this.child,
    this.radius,
  });

  final Widget child;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    final accent = VipVenueScreenTheme.accent(context);
    final resolvedRadius = radius ?? VipVenueDesignSpec.px(context, 12);

    return Container(
      padding: EdgeInsets.all(VipVenueDesignSpec.px(context, 14)),
      decoration: BoxDecoration(
        color: VipVenueScreenTheme.cardBackground(context),
        borderRadius: BorderRadius.circular(resolvedRadius),
      ),
      child: CustomPaint(
        painter: VipDashedBorderPainter(
          color: accent.withValues(alpha: 0.85),
          radius: resolvedRadius,
          strokeWidth: 1.2,
          dashWidth: 6,
          dashGap: 4,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: VipVenueDesignSpec.px(context, 2),
          ),
          child: child,
        ),
      ),
    );
  }
}

class VipDashedBorderPainter extends CustomPainter {
  const VipDashedBorderPainter({
    required this.color,
    required this.radius,
    required this.strokeWidth,
    required this.dashWidth,
    required this.dashGap,
  });

  final Color color;
  final double radius;
  final double strokeWidth;
  final double dashWidth;
  final double dashGap;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Offset.zero & size,
          Radius.circular(radius),
        ),
      );

    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        final next = distance + dashWidth;
        canvas.drawPath(
          metric.extractPath(distance, next.clamp(0, metric.length)),
          paint,
        );
        distance = next + dashGap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant VipDashedBorderPainter oldDelegate) => false;
}

class VipTicketSelectionSummaryRowWidget extends StatelessWidget {
  const VipTicketSelectionSummaryRowWidget({
    super.key,
    required this.title,
    required this.summaryLine,
    required this.onTap,
    this.enabled = true,
  });

  final String title;
  final String summaryLine;
  final VoidCallback? onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final accent = VipVenueScreenTheme.accent(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: BorderRadius.circular(VipVenueDesignSpec.px(context, 12)),
        child: Padding(
          padding: EdgeInsets.only(
            top: VipVenueDesignSpec.px(context, 4),
            bottom: VipVenueDesignSpec.px(context, 2),
          ),
          child: Row(
            children: [
              Icon(
                Icons.shopping_cart_outlined,
                color: accent,
                size: VipVenueDesignSpec.px(context, 20),
              ),
              SizedBox(width: VipVenueDesignSpec.px(context, 10)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      title,
                      variant: AppTextVariant.bodyEmphasis,
                      color: VipVenueScreenTheme.title(context),
                      fontSize: VipVenueDesignSpec.px(context, 15),
                      fontWeight: FontWeight.w800,
                    ),
                    SizedBox(height: VipVenueDesignSpec.px(context, 4)),
                    AppText(
                      summaryLine,
                      variant: AppTextVariant.bodyEmphasis,
                      color: accent,
                      fontSize: VipVenueDesignSpec.px(context, 15),
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: VipVenueScreenTheme.muted(context),
                size: VipVenueDesignSpec.px(context, 22),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
