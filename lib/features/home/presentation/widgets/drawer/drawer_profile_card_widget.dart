import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/drawer_design_spec.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/drawer_profile_waves_painter.dart';

class DrawerProfileCardWidget extends StatelessWidget {
  const DrawerProfileCardWidget({
    super.key,
    required this.fullName,
    this.profilePhotoUrl,
  });

  final String fullName;
  final String? profilePhotoUrl;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final displayName = fullName.trim().isEmpty ? fullName : fullName.trim();

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
                  _DrawerProfileAvatar(
                    size: avatarSize,
                    profilePhotoUrl: profilePhotoUrl,
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

class _DrawerProfileAvatar extends StatelessWidget {
  const _DrawerProfileAvatar({
    required this.size,
    this.profilePhotoUrl,
  });

  final double size;
  final String? profilePhotoUrl;

  @override
  Widget build(BuildContext context) {
    final resolvedUrl = profilePhotoUrl?.trim();
    final hasPhoto = resolvedUrl != null && resolvedUrl.isNotEmpty;

    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: DrawerDesignSpec.avatarBackground,
        shape: BoxShape.circle,
      ),
      clipBehavior: Clip.antiAlias,
      child: hasPhoto
          ? Image.network(
              resolvedUrl,
              fit: BoxFit.cover,
              width: size,
              height: size,
              errorBuilder: (context, error, stackTrace) =>
                  _buildPlaceholder(context),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return _buildPlaceholder(context);
              },
            )
          : _buildPlaceholder(context),
    );
  }

  Widget _buildPlaceholder(BuildContext context) {
    return Center(
      child: Icon(
        Icons.person,
        size: DrawerDesignSpec.px(context, DrawerDesignSpec.avatarIconSize),
        color: DrawerDesignSpec.avatarIcon,
      ),
    );
  }
}
