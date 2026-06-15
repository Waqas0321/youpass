import 'package:flutter/material.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/home/domain/entities/drawer_membership_tier.dart';
import 'package:youpass/features/home/presentation/utils/drawer_tier_label_formatter.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/drawer_profile_avatar_widget.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/drawer_design_spec.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/drawer_profile_tier_theme.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/drawer_profile_waves_painter.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/drawer_theme.dart';

class DrawerProfileCardWidget extends StatelessWidget {
  const DrawerProfileCardWidget({
    super.key,
    required this.firstName,
    required this.tier,
    this.profilePhotoUrl,
    this.onTap,
  });

  final String firstName;
  final DrawerMembershipTier tier;
  final String? profilePhotoUrl;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final tierTheme = DrawerProfileTierTheme.forTier(tier);
    final drawerTheme = HomeDrawerTheme.of(context);
    final tierLabel = DrawerTierLabelFormatter.label(context.l10n, tier);
    final displayName = firstName.trim().isEmpty ? firstName : firstName.trim();
    final firstInitial = displayName.isEmpty ? '?' : displayName[0];

    final radius = DrawerDesignSpec.px(context, DrawerDesignSpec.profileCardRadius);
    final avatarSize = DrawerDesignSpec.px(context, DrawerDesignSpec.avatarSize);
    final minHeight =
        DrawerDesignSpec.px(context, DrawerDesignSpec.profileCardMinHeight);

    final waveWidth =
        DrawerDesignSpec.px(context, DrawerDesignSpec.profileWaveWidth);

    final cardContent = Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(radius),
        splashColor: tierTheme.splashColor,
        highlightColor: tierTheme.highlightColor,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: Stack(
              children: [
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          drawerTheme.profileCardGradientStart,
                          drawerTheme.profileCardGradientEnd,
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: tierTheme.backgroundGradient,
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  width: waveWidth,
                  child: CustomPaint(
                    painter: DrawerProfileWavesPainter(
                      waveBands: drawerTheme.profileWaveBands,
                    ),
                    size: Size(waveWidth, minHeight),
                  ),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(minHeight: minHeight),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: DrawerDesignSpec.px(
                        context,
                        DrawerDesignSpec.profileCardPaddingHorizontal,
                      ),
                      vertical: DrawerDesignSpec.px(
                        context,
                        DrawerDesignSpec.profileCardPaddingVertical,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        DrawerProfileAvatarWidget(
                          size: avatarSize,
                          firstInitial: firstInitial,
                          profilePhotoUrl: profilePhotoUrl,
                          ringColor: tierTheme.avatarRingColor,
                          placeholderBackground: drawerTheme.isDark
                              ? const Color(0xFF1A1A1A)
                              : tierTheme.avatarPlaceholderBackground,
                          placeholderIconColor: tierTheme.avatarPlaceholderIconColor,
                          placeholderInitialColor: drawerTheme.isDark
                              ? Colors.white
                              : tierTheme.avatarInitialColor,
                        ),
                        SizedBox(
                          width: DrawerDesignSpec.px(
                            context,
                            DrawerDesignSpec.avatarToNameGap,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                displayName,
                                style: TextStyle(
                                  fontSize: DrawerDesignSpec.px(
                                    context,
                                    DrawerDesignSpec.nameFontSize,
                                  ),
                                  fontWeight: FontWeight.w700,
                                  color: drawerTheme.isDark
                                      ? Colors.white
                                      : tierTheme.nameColor,
                                  height: 1.15,
                                ),
                              ),
                              SizedBox(
                                height: DrawerDesignSpec.px(
                                  context,
                                  DrawerDesignSpec.nameToBadgeGap,
                                ),
                              ),
                        _TierBadge(
                          label: tierLabel,
                          theme: tierTheme,
                        ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: drawerTheme.isDark
                        ? drawerTheme.gold.withValues(alpha: 0.7)
                        : tierTheme.chevronColor,
                          size: DrawerDesignSpec.px(
                            context,
                            DrawerDesignSpec.menuChevronSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    if (tierTheme.outerBorderGradient == null || tierTheme.outerBorderWidth <= 0) {
      return cardContent;
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        gradient: tierTheme.outerBorderGradient,
      ),
      padding: EdgeInsets.all(tierTheme.outerBorderWidth),
      child: cardContent,
    );
  }
}

class _TierBadge extends StatelessWidget {
  const _TierBadge({
    required this.label,
    required this.theme,
  });

  final String label;
  final DrawerProfileTierTheme theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: DrawerDesignSpec.px(
          context,
          DrawerDesignSpec.tierBadgePaddingHorizontal,
        ),
        vertical: DrawerDesignSpec.px(
          context,
          DrawerDesignSpec.tierBadgePaddingVertical,
        ),
      ),
      decoration: BoxDecoration(
        color: theme.badgeBackground,
        borderRadius: BorderRadius.circular(
          DrawerDesignSpec.px(
            context,
            DrawerDesignSpec.tierBadgeRadius,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: theme.badgeBackground.withValues(alpha: 0.35),
            blurRadius: DrawerDesignSpec.px(context, 6),
            offset: Offset(0, DrawerDesignSpec.px(context, 2)),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.emoji_events,
            size: DrawerDesignSpec.px(
              context,
              DrawerDesignSpec.tierIconSize,
            ),
            color: theme.badgeIconColor,
          ),
          SizedBox(
            width: DrawerDesignSpec.px(context, 5),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: DrawerDesignSpec.px(
                context,
                DrawerDesignSpec.tierFontSize,
              ),
              fontWeight: FontWeight.w700,
              color: theme.badgeTextColor,
              letterSpacing: DrawerDesignSpec.tierLetterSpacing,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}
