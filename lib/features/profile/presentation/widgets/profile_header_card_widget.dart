import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/home/domain/entities/drawer_membership_tier.dart';
import 'package:youpass/features/home/presentation/utils/drawer_tier_label_formatter.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/drawer_profile_tier_theme.dart';
import 'package:youpass/features/profile/presentation/models/profile_view_data.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_avatar_widget.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_card_waves_painter.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_design_spec.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_theme.dart';

class ProfileHeaderCardWidget extends StatelessWidget {
  const ProfileHeaderCardWidget({
    super.key,
    required this.data,
    this.isUploadingPhoto = false,
    this.onHeaderTap,
    this.onPhotoTap,
    this.onViewBenefitsTap,
  });

  final ProfileViewData data;
  final bool isUploadingPhoto;
  final VoidCallback? onHeaderTap;
  final VoidCallback? onPhotoTap;
  final VoidCallback? onViewBenefitsTap;

  Color _tierBadgeForeground(DrawerMembershipTier tier) {
    return switch (tier) {
      DrawerMembershipTier.platinum => const Color(0xFF3A3A44),
      _ => Colors.white,
    };
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final tier = DrawerMembershipTierMapper.fromCategory(data.membershipCategory);
    final tierTheme = DrawerProfileTierTheme.forTier(tier);
    final tierLabel = DrawerTierLabelFormatter.label(strings, tier);
    final tierBadgeForeground = _tierBadgeForeground(tier);
    final theme = ProfileTheme.of(context);
    final radius = ProfileDesignSpec.px(context, ProfileDesignSpec.cardRadius);
    final waveWidth = ProfileDesignSpec.px(context, ProfileDesignSpec.cardWaveWidth);
    final waveHeight = ProfileDesignSpec.px(context, ProfileDesignSpec.cardWaveHeight);

    final card = Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.cardBackground,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: theme.cardBorder,
          width: ProfileDesignSpec.cardBorderWidth,
        ),
        boxShadow: theme.cardShadow == Colors.transparent
            ? null
            : [
                BoxShadow(
                  color: theme.cardShadow,
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Stack(
          children: [
            Positioned(
              right: 0,
              top: 0,
              height: waveHeight,
              width: waveWidth,
              child: CustomPaint(
                painter: ProfileCardWavesPainter(waveBands: theme.cardWaveBands),
                size: Size(waveWidth, waveHeight),
              ),
            ),
            Padding(
                  padding: EdgeInsets.fromLTRB(
                    ProfileDesignSpec.px(
                      context,
                      ProfileDesignSpec.cardPaddingHorizontal,
                    ),
                    ProfileDesignSpec.px(context, ProfileDesignSpec.cardPaddingTop),
                    ProfileDesignSpec.px(
                      context,
                      ProfileDesignSpec.cardPaddingHorizontal,
                    ),
                    ProfileDesignSpec.px(
                      context,
                      ProfileDesignSpec.cardPaddingBottom,
                    ),
                  ),
                  child: Column(
                    children: [
                      Center(
                        child: ProfileAvatarWidget(
                          photoUrl: data.profilePhotoUrl,
                          displayName: data.fullName,
                          isUploading: isUploadingPhoto,
                          onPhotoTap: onPhotoTap,
                        ),
                      ),
                      SizedBox(height: ProfileDesignSpec.px(context, 16)),
                      Text(
                        data.fullName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: ProfileDesignSpec.px(
                            context,
                            ProfileDesignSpec.nameFontSize,
                          ),
                          fontWeight: FontWeight.w700,
                          color: theme.valueText,
                          height: 1.2,
                        ),
                      ),
                      SizedBox(
                        height: ProfileDesignSpec.px(
                          context,
                          ProfileDesignSpec.nameToPhoneGap,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.phone_outlined,
                            size: ProfileDesignSpec.px(
                              context,
                              ProfileDesignSpec.phoneIconSize,
                            ),
                            color: theme.phoneIcon,
                          ),
                          SizedBox(width: ProfileDesignSpec.px(context, 6)),
                          Text(
                            data.phone,
                            style: TextStyle(
                              fontSize: ProfileDesignSpec.px(
                                context,
                                ProfileDesignSpec.phoneFontSize,
                              ),
                              fontWeight: FontWeight.w400,
                              color: theme.labelText,
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: ProfileDesignSpec.px(
                          context,
                          ProfileDesignSpec.phoneToDividerGap,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: ProfileDesignSpec.px(
                            context,
                            ProfileDesignSpec.dividerHorizontalInset,
                          ),
                        ),
                        child: Divider(
                          height: 1,
                          thickness: 1,
                          color: theme.divider,
                        ),
                      ),
                      SizedBox(
                        height: ProfileDesignSpec.px(
                          context,
                          ProfileDesignSpec.dividerToBadgeGap,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: ProfileDesignSpec.px(
                            context,
                            ProfileDesignSpec.tierBadgePaddingH,
                          ),
                          vertical: ProfileDesignSpec.px(
                            context,
                            ProfileDesignSpec.tierBadgePaddingV,
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: tierTheme.badgeBackground,
                          borderRadius: BorderRadius.circular(
                            ProfileDesignSpec.px(
                              context,
                              ProfileDesignSpec.tierBadgeRadius,
                            ),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: tierTheme.badgeBackground.withValues(alpha: 0.3),
                              blurRadius: ProfileDesignSpec.px(context, 4),
                              offset: Offset(0, ProfileDesignSpec.px(context, 1)),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.emoji_events,
                              size: ProfileDesignSpec.px(
                                context,
                                ProfileDesignSpec.tierIconSize,
                              ),
                              color: tierBadgeForeground,
                            ),
                            SizedBox(width: ProfileDesignSpec.px(context, 6)),
                            Text(
                              tierLabel,
                              style: TextStyle(
                                fontSize: ProfileDesignSpec.px(
                                  context,
                                  ProfileDesignSpec.tierFontSize,
                                ),
                                fontWeight: FontWeight.w700,
                                color: tierBadgeForeground,
                                letterSpacing: 0.5,
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: ProfileDesignSpec.px(
                          context,
                          ProfileDesignSpec.badgeToBenefitsGap,
                        ),
                      ),
                      GestureDetector(
                        onTap: onViewBenefitsTap ?? onHeaderTap,
                        behavior: HitTestBehavior.opaque,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              AppStrings.profileViewBenefits(strings),
                              style: TextStyle(
                                fontSize: ProfileDesignSpec.px(
                                  context,
                                  ProfileDesignSpec.benefitsFontSize,
                                ),
                                fontWeight: FontWeight.w600,
                                color: theme.primary,
                                height: 1.2,
                              ),
                            ),
                            Icon(
                              Icons.chevron_right,
                              size: ProfileDesignSpec.px(
                                context,
                                ProfileDesignSpec.benefitsChevronSize,
                              ),
                              color: ProfileDesignSpec.primary,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
          ],
        ),
      ),
    );

    if (onHeaderTap == null) {
      return card;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onHeaderTap,
        borderRadius: BorderRadius.circular(radius),
        child: card,
      ),
    );
  }
}
