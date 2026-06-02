import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/profile/presentation/models/profile_view_data.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_card_waves_painter.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_design_spec.dart';

class ProfileHeaderCardWidget extends StatelessWidget {
  const ProfileHeaderCardWidget({
    super.key,
    required this.data,
    this.onHeaderTap,
    this.onViewBenefitsTap,
  });

  final ProfileViewData data;
  final VoidCallback? onHeaderTap;
  final VoidCallback? onViewBenefitsTap;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
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
            color: ProfileDesignSpec.cardBackground,
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
              color: ProfileDesignSpec.cardBorder,
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
                painter: ProfileCardWavesPainter(),
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
                  const Center(child: _ProfileAvatar()),
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
                      color: ProfileDesignSpec.valueText,
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
                        color: ProfileDesignSpec.phoneIcon,
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
                          color: ProfileDesignSpec.labelText,
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
                    child: const Divider(
                      height: 1,
                      thickness: 1,
                      color: ProfileDesignSpec.divider,
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
                      color: ProfileDesignSpec.tierBadge,
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
                          color: ProfileDesignSpec.avatarInner,
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
                            color: ProfileDesignSpec.avatarInner,
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

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar();

  @override
  Widget build(BuildContext context) {
    final outerSize =
        ProfileDesignSpec.px(context, ProfileDesignSpec.avatarOuterSize);
    final ringWidth =
        ProfileDesignSpec.px(context, ProfileDesignSpec.avatarRingWidth);
    final ringGap = ProfileDesignSpec.px(context, ProfileDesignSpec.avatarRingGap);
    final whiteBorder = ProfileDesignSpec.px(
      context,
      ProfileDesignSpec.avatarWhiteBorderWidth,
    );
    final cameraSize =
        ProfileDesignSpec.px(context, ProfileDesignSpec.cameraBadgeSize);

    return SizedBox(
      width: outerSize,
      height: outerSize,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            width: outerSize,
            height: outerSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: ProfileDesignSpec.avatarRing,
                width: ringWidth,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(ringGap),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ProfileDesignSpec.avatarInner,
                  border: Border.all(
                    color: ProfileDesignSpec.avatarInner,
                    width: whiteBorder,
                  ),
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.person,
                  size: ProfileDesignSpec.px(
                    context,
                    ProfileDesignSpec.avatarIconSize,
                  ),
                  color: ProfileDesignSpec.avatarIcon,
                ),
              ),
            ),
          ),
          Positioned(
            right: ProfileDesignSpec.px(context, 2),
            bottom: ProfileDesignSpec.px(context, 2),
            child: Container(
              width: cameraSize,
              height: cameraSize,
              decoration: BoxDecoration(
                color: ProfileDesignSpec.cameraBadgeBackground,
                shape: BoxShape.circle,
                border: Border.all(
                  color: ProfileDesignSpec.cameraBadgeRing,
                  width: 2,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x26000000),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.photo_camera_outlined,
                size: ProfileDesignSpec.px(
                  context,
                  ProfileDesignSpec.cameraIconSize,
                ),
                color: ProfileDesignSpec.cameraIcon,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
