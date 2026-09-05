import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/core/widgets/youpass_logo.dart';
import 'package:youpass/features/vip_venue/presentation/vip_venue_design_spec.dart';
import 'package:youpass/features/vip_venue/presentation/vip_venue_screen_theme.dart';
import 'package:youpass/features/vip_venue/presentation/widgets/vip_primary_button_widget.dart';
import 'package:youpass/features/vip_venue/presentation/widgets/vip_shared_widgets.dart';
import 'package:youpass/features/vip_venue/presentation/widgets/vip_surface_card_widget.dart';

class VipNavigationEntryCardWidget extends StatelessWidget {
  const VipNavigationEntryCardWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.titleColor,
    this.backgroundColor,
    this.borderColor,
    this.iconBackgroundColor,
    this.iconColor,
    this.useFilledIconBadge = false,
    this.accentOverride,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color? titleColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? iconBackgroundColor;
  final Color? iconColor;
  final bool useFilledIconBadge;
  final Color? accentOverride;

  @override
  Widget build(BuildContext context) {
    final accent = accentOverride ?? VipVenueScreenTheme.accent(context);

    return VipSurfaceCardWidget(
      onTap: onTap,
      backgroundColor:
          backgroundColor ?? VipVenueScreenTheme.hintCardBackground(context),
      borderColor: borderColor ?? accent,
      borderWidth: useFilledIconBadge ? 1.2 : 1.5,
      boxShadow: useFilledIconBadge ? const [] : VipVenueScreenTheme.cardShadow(context),
      child: Row(
        children: [
          VipIconBadgeWidget(
            icon: icon,
            size: 44,
            iconSize: useFilledIconBadge ? 22 : 22,
            backgroundColor: useFilledIconBadge
                ? accent
                : iconBackgroundColor ?? VipVenueScreenTheme.accentSurface(context),
            iconColor: useFilledIconBadge ? Colors.white : iconColor ?? accent,
            shape: BoxShape.circle,
          ),
          SizedBox(width: VipVenueDesignSpec.px(context, 12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  title,
                  variant: AppTextVariant.bodyEmphasis,
                  color: titleColor ?? VipVenueScreenTheme.title(context),
                  fontSize: VipVenueDesignSpec.px(context, 15),
                  fontWeight: FontWeight.w800,
                ),
                SizedBox(height: VipVenueDesignSpec.px(context, 4)),
                AppText(
                  subtitle,
                  variant: AppTextVariant.body,
                  color: useFilledIconBadge
                      ? VipVenueScreenTheme.hintCardBody(context)
                      : VipVenueScreenTheme.body(context),
                  fontSize: VipVenueDesignSpec.px(context, 12),
                  fontWeight: FontWeight.w500,
                  height: 1.35,
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right_rounded,
            color: accent,
            size: VipVenueDesignSpec.px(context, 24),
          ),
        ],
      ),
    );
  }
}

class VipSecurePaymentFooterWidget extends StatelessWidget {
  const VipSecurePaymentFooterWidget({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.lock_outline,
          size: VipVenueDesignSpec.px(context, 12),
          color: VipVenueScreenTheme.muted(context),
        ),
        SizedBox(width: VipVenueDesignSpec.px(context, 5)),
        AppText(
          label,
          variant: AppTextVariant.body,
          color: VipVenueScreenTheme.muted(context),
          fontSize: VipVenueDesignSpec.px(context, 11),
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }
}

class VipFlowPageHeaderWidget extends StatelessWidget {
  const VipFlowPageHeaderWidget({
    super.key,
    required this.title,
    this.subtitle,
  });

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          title,
          variant: AppTextVariant.headline,
          color: VipVenueScreenTheme.title(context),
          fontSize: VipVenueDesignSpec.px(context, 26),
          fontWeight: FontWeight.w800,
          height: 1.15,
        ),
        if (subtitle != null) ...[
          SizedBox(height: VipVenueDesignSpec.px(context, 4)),
          AppText(
            subtitle!,
            variant: AppTextVariant.body,
            color: VipVenueScreenTheme.body(context),
            fontSize: VipVenueDesignSpec.px(context, 14),
            fontWeight: FontWeight.w500,
          ),
        ],
      ],
    );
  }
}

class VipFlowNotificationButtonWidget extends StatelessWidget {
  const VipFlowNotificationButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final accent = VipVenueScreenTheme.accent(context);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.notifications_outlined,
            color: VipVenueScreenTheme.title(context),
            size: VipVenueDesignSpec.px(context, 24),
          ),
        ),
        Positioned(
          top: VipVenueDesignSpec.px(context, 10),
          right: VipVenueDesignSpec.px(context, 10),
          child: Container(
            width: VipVenueDesignSpec.px(context, 8),
            height: VipVenueDesignSpec.px(context, 8),
            decoration: BoxDecoration(
              color: accent,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}

class VipFlowTopBarWidget extends StatelessWidget {
  const VipFlowTopBarWidget({
    super.key,
    this.onMenuTap,
    this.brandedHeader = false,
    this.showNotification = false,
  });

  final VoidCallback? onMenuTap;
  final bool brandedHeader;
  final bool showNotification;

  @override
  Widget build(BuildContext context) {
    final horizontalPadding =
        VipVenueDesignSpec.px(context, VipVenueDesignSpec.horizontalPadding);
    final iconSize = VipVenueDesignSpec.px(context, 24);
    final showMenu = onMenuTap != null;

    return SizedBox(
      height: kToolbarHeight,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Row(
          children: [
            if (showMenu)
              _VipFlowHeaderIconButton(
                icon: Icons.menu,
                color: AppColors.homeAccentYellow,
                iconSize: iconSize,
                onPressed: onMenuTap!,
              )
            else
              SizedBox(width: iconSize + VipVenueDesignSpec.px(context, 16)),
            if (brandedHeader)
              const Expanded(child: Center(child: YouPassLogo()))
            else
              const Spacer(),
            if (brandedHeader && showNotification)
              const VipFlowNotificationButtonWidget(),
          ],
        ),
      ),
    );
  }
}

class VipFlowBottomActionRowWidget extends StatelessWidget {
  const VipFlowBottomActionRowWidget({
    super.key,
    required this.backLabel,
    required this.onBack,
    required this.primaryLabel,
    required this.onPrimary,
    this.primaryEnabled = true,
    this.primaryLoading = false,
  });

  final String backLabel;
  final VoidCallback onBack;
  final String primaryLabel;
  final VoidCallback? onPrimary;
  final bool primaryEnabled;
  final bool primaryLoading;

  @override
  Widget build(BuildContext context) {
    final buttonHeight = VipVenueDesignSpec.primaryButtonHeightPx(context);
    final gap = VipVenueDesignSpec.px(context, 8);

    return SizedBox(
      height: buttonHeight,
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: VipSecondaryButtonWidget(
              label: backLabel,
              onPressed: onBack,
            ),
          ),
          SizedBox(width: gap),
          Expanded(
            child: VipPrimaryButtonWidget(
              label: primaryLabel,
              onPressed: primaryEnabled ? onPrimary : null,
              isLoading: primaryLoading,
            ),
          ),
        ],
      ),
    );
  }
}

class _VipFlowHeaderIconButton extends StatelessWidget {
  const _VipFlowHeaderIconButton({
    required this.icon,
    required this.color,
    required this.iconSize,
    required this.onPressed,
  });

  final IconData icon;
  final Color color;
  final double iconSize;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final iconSlot = VipVenueDesignSpec.headerIconSlotPx(context);
    return IconButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      constraints: BoxConstraints(
        minWidth: iconSlot,
        minHeight: iconSlot,
      ),
      visualDensity: VisualDensity.compact,
      icon: Icon(icon, color: color, size: iconSize),
    );
  }
}
