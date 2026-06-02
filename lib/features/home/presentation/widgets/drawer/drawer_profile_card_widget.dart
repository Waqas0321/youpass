import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/drawer_design_spec.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/drawer_profile_waves_painter.dart';

class DrawerProfileCardWidget extends StatelessWidget {
  const DrawerProfileCardWidget({
    super.key,
    required this.userName,
  });

  final String userName;

  static String displayFirstName(String fullName) {
    final trimmed = fullName.trim();
    if (trimmed.isEmpty) {
      return fullName;
    }

    return trimmed.split(RegExp(r'\s+')).first;
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final firstName = displayFirstName(userName);

    final radius = DrawerDesignSpec.px(context, DrawerDesignSpec.profileCardRadius);
    final avatarSize = DrawerDesignSpec.px(context, DrawerDesignSpec.avatarSize);
    final minHeight =
        DrawerDesignSpec.px(context, DrawerDesignSpec.profileCardMinHeight);
    final waveWidth =
        DrawerDesignSpec.px(context, DrawerDesignSpec.profileWaveWidth);

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(minHeight: minHeight),
        child: Stack(
          children: [
            const Positioned.fill(
              child: ColoredBox(color: DrawerDesignSpec.profileBackground),
            ),
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              width: waveWidth,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return CustomPaint(
                    painter: DrawerProfileWavesPainter(),
                    size: Size(waveWidth, constraints.maxHeight),
                  );
                },
              ),
            ),
            Padding(
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
                  Container(
                    width: avatarSize,
                    height: avatarSize,
                    decoration: const BoxDecoration(
                      color: DrawerDesignSpec.avatarBackground,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.person,
                      size: DrawerDesignSpec.px(
                        context,
                        DrawerDesignSpec.avatarIconSize,
                      ),
                      color: DrawerDesignSpec.avatarIcon,
                    ),
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
                          firstName,
                          style: TextStyle(
                            fontSize: DrawerDesignSpec.px(
                              context,
                              DrawerDesignSpec.nameFontSize,
                            ),
                            fontWeight: FontWeight.w700,
                            color: DrawerDesignSpec.profileName,
                            height: 1.15,
                          ),
                        ),
                        SizedBox(
                          height: DrawerDesignSpec.px(
                            context,
                            DrawerDesignSpec.nameToBadgeGap,
                          ),
                        ),
                        Container(
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
                            color: DrawerDesignSpec.tierBadgeBackground,
                            borderRadius: BorderRadius.circular(
                              DrawerDesignSpec.px(
                                context,
                                DrawerDesignSpec.tierBadgeRadius,
                              ),
                            ),
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
                                color: DrawerDesignSpec.screenBackground,
                              ),
                              SizedBox(
                                width: DrawerDesignSpec.px(context, 5),
                              ),
                              Text(
                                AppStrings.drawerTierGold(strings),
                                style: TextStyle(
                                  fontSize: DrawerDesignSpec.px(
                                    context,
                                    DrawerDesignSpec.tierFontSize,
                                  ),
                                  fontWeight: FontWeight.w700,
                                  color: DrawerDesignSpec.screenBackground,
                                  letterSpacing:
                                      DrawerDesignSpec.tierLetterSpacing,
                                  height: 1,
                                ),
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
          ],
        ),
      ),
    );
  }
}
