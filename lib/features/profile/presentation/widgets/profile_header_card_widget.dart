import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/drawer_design_spec.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/drawer_profile_waves_painter.dart';
import 'package:youpass/features/profile/presentation/models/profile_view_data.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_avatar_widget.dart';
import 'package:youpass/core/theme/youpass_theme_extension.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_design_spec.dart';

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

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final theme = YouPassThemeExtension.of(context);
    final radius = ProfileDesignSpec.px(context, ProfileDesignSpec.cardRadius);
    final waveWidth = ProfileDesignSpec.px(context, ProfileDesignSpec.cardWaveWidth);
    final waveHeight = ProfileDesignSpec.px(context, ProfileDesignSpec.cardWaveHeight);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onHeaderTap,
        borderRadius: BorderRadius.circular(radius),
        child: Ink(
          width: double.infinity,
          decoration: BoxDecoration(
            color: theme.profileCardBackground,
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
              color: theme.profileCardBorder,
              width: ProfileDesignSpec.cardBorderWidth,
            ),
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
                    painter: DrawerProfileWavesPainter(),
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
                          color: DrawerDesignSpec.profileName,
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
                            color: AppColors.profileLabelGrey,
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
                              color: AppColors.profileLabelGrey,
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
                          color: AppColors.profileLabelGrey.withValues(alpha: 0.35),
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
                          color: DrawerDesignSpec.tierBadgeBackground,
                          borderRadius: BorderRadius.circular(
                            ProfileDesignSpec.px(
                              context,
                              ProfileDesignSpec.tierBadgeRadius,
                            ),
                          ),
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
                              color: AppColors.backgroundWhite,
                            ),
                            SizedBox(width: ProfileDesignSpec.px(context, 6)),
                            Text(
                              AppStrings.drawerTierGold(strings),
                              style: TextStyle(
                                fontSize: ProfileDesignSpec.px(
                                  context,
                                  ProfileDesignSpec.tierFontSize,
                                ),
                                fontWeight: FontWeight.w700,
                                color: AppColors.backgroundWhite,
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
                                color: ProfileDesignSpec.primary,
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
        ),
      ),
    );
  }
}
