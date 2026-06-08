import 'package:flutter/material.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/features/vip_venue/presentation/vip_venue_design_spec.dart';
import 'package:youpass/features/vip_venue/presentation/vip_venue_screen_theme.dart';

class VipSurfaceCardWidget extends StatelessWidget {
  const VipSurfaceCardWidget({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 1,
    this.radius,
    this.boxShadow,
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderWidth;
  final double? radius;
  final List<BoxShadow>? boxShadow;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final resolvedRadius = radius ?? VipVenueDesignSpec.px(context, 14);
    final decoration = BoxDecoration(
      color: backgroundColor ?? VipVenueScreenTheme.cardBackground(context),
      borderRadius: BorderRadius.circular(resolvedRadius),
      border: borderColor == null
          ? Border.all(color: VipVenueScreenTheme.cardBorder(context))
          : Border.all(color: borderColor!, width: borderWidth),
      boxShadow: boxShadow ?? VipVenueScreenTheme.cardShadow(context),
    );

    final content = Padding(
      padding: padding ?? EdgeInsets.all(VipVenueDesignSpec.px(context, 14)),
      child: child,
    );

    final card = Container(
      margin: margin,
      decoration: decoration,
      child: onTap == null
          ? content
          : Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(resolvedRadius),
                child: content,
              ),
            ),
    );

    return card;
  }
}

class VipSectionCaptionWidget extends StatelessWidget {
  const VipSectionCaptionWidget({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: VipVenueDesignSpec.px(context, 10),
        top: VipVenueDesignSpec.px(context, 4),
      ),
      child: AppText(
        label,
        variant: AppTextVariant.sectionCaption,
        color: VipVenueScreenTheme.muted(context),
        fontSize: VipVenueDesignSpec.px(context, 11),
        fontWeight: FontWeight.w700,
        letterSpacing: 0.8,
      ),
    );
  }
}

class VipPurchaseSectionLabelWidget extends StatelessWidget {
  const VipPurchaseSectionLabelWidget({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return AppText(
      label,
      variant: AppTextVariant.sectionCaption,
      color: VipVenueScreenTheme.muted(context),
      fontSize: VipVenueDesignSpec.px(context, 11),
      fontWeight: FontWeight.w700,
      letterSpacing: 0.8,
    );
  }
}
