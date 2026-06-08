import 'package:flutter/material.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/features/vip_venue/presentation/vip_venue_design_spec.dart';
import 'package:youpass/features/vip_venue/presentation/vip_venue_screen_theme.dart';

enum VipLegendIndicatorShape {
  dot,
  square,
}

class VipLegendItemWidget extends StatelessWidget {
  const VipLegendItemWidget({
    super.key,
    required this.color,
    required this.label,
    this.shape = VipLegendIndicatorShape.square,
    this.labelColor,
  });

  final Color color;
  final String label;
  final VipLegendIndicatorShape shape;
  final Color? labelColor;

  @override
  Widget build(BuildContext context) {
    final indicatorSize = shape == VipLegendIndicatorShape.dot
        ? VipVenueDesignSpec.px(context, 10)
        : VipVenueDesignSpec.px(context, 12);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: indicatorSize,
          height: indicatorSize,
          decoration: BoxDecoration(
            color: color,
            shape: shape == VipLegendIndicatorShape.dot
                ? BoxShape.circle
                : BoxShape.rectangle,
            borderRadius: shape == VipLegendIndicatorShape.square
                ? BorderRadius.circular(VipVenueDesignSpec.px(context, 2))
                : null,
          ),
        ),
        SizedBox(width: VipVenueDesignSpec.px(context, 6)),
        AppText(
          label,
          variant: AppTextVariant.body,
          color: labelColor ?? VipVenueScreenTheme.body(context),
          fontSize: VipVenueDesignSpec.px(context, 12),
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }
}

class VipMetaRowWidget extends StatelessWidget {
  const VipMetaRowWidget({
    super.key,
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: VipVenueDesignSpec.px(context, 14),
          color: VipVenueScreenTheme.muted(context),
        ),
        SizedBox(width: VipVenueDesignSpec.px(context, 6)),
        Expanded(
          child: AppText(
            label,
            variant: AppTextVariant.body,
            color: VipVenueScreenTheme.body(context),
            fontSize: VipVenueDesignSpec.px(context, 12),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class VipAmountRowWidget extends StatelessWidget {
  const VipAmountRowWidget({
    super.key,
    required this.label,
    required this.amount,
    required this.amountColor,
    this.amountSize = 14,
    this.labelWeight = FontWeight.w500,
    this.amountWeight = FontWeight.w600,
  });

  final String label;
  final String amount;
  final Color amountColor;
  final double amountSize;
  final FontWeight labelWeight;
  final FontWeight amountWeight;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(
          label,
          variant: AppTextVariant.bodyEmphasis,
          color: VipVenueScreenTheme.title(context),
          fontSize: VipVenueDesignSpec.px(context, 14),
          fontWeight: labelWeight,
        ),
        AppText(
          amount,
          variant: AppTextVariant.bodyEmphasis,
          color: amountColor,
          fontSize: VipVenueDesignSpec.px(context, amountSize),
          fontWeight: amountWeight,
        ),
      ],
    );
  }
}

class VipIconBadgeWidget extends StatelessWidget {
  const VipIconBadgeWidget({
    super.key,
    required this.icon,
    this.size = 48,
    this.iconSize = 24,
    this.backgroundColor,
    this.iconColor,
    this.borderRadius,
    this.shape = BoxShape.circle,
  });

  final IconData icon;
  final double size;
  final double iconSize;
  final Color? backgroundColor;
  final Color? iconColor;
  final double? borderRadius;
  final BoxShape shape;

  @override
  Widget build(BuildContext context) {
    final accent = VipVenueScreenTheme.accent(context);
    final resolvedSize = VipVenueDesignSpec.px(context, size);
    final resolvedIconSize = VipVenueDesignSpec.px(context, iconSize);

    return Container(
      width: resolvedSize,
      height: resolvedSize,
      decoration: BoxDecoration(
        color: backgroundColor ?? VipVenueScreenTheme.accentSurface(context),
        shape: shape,
        borderRadius: shape == BoxShape.rectangle
            ? BorderRadius.circular(
                borderRadius ?? VipVenueDesignSpec.px(context, 10),
              )
            : null,
      ),
      child: Icon(
        icon,
        color: iconColor ?? accent,
        size: resolvedIconSize,
      ),
    );
  }
}

class VipPriceColumnWidget extends StatelessWidget {
  const VipPriceColumnWidget({
    super.key,
    required this.amount,
    this.currencyLabel = 'CLP',
  });

  final String amount;
  final String currencyLabel;

  @override
  Widget build(BuildContext context) {
    final accent = VipVenueScreenTheme.accent(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        AppText(
          amount,
          variant: AppTextVariant.bodyEmphasis,
          color: accent,
          fontSize: VipVenueDesignSpec.px(context, 20),
          fontWeight: FontWeight.w800,
        ),
        AppText(
          currencyLabel,
          variant: AppTextVariant.sectionCaption,
          color: VipVenueScreenTheme.title(context),
          fontSize: VipVenueDesignSpec.px(context, 11),
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }
}

class VipCardDividerWidget extends StatelessWidget {
  const VipCardDividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: VipVenueDesignSpec.px(context, 12),
      ),
      child: Divider(
        height: 1,
        color: VipVenueScreenTheme.cardBorder(context).withValues(alpha: 0.7),
      ),
    );
  }
}
