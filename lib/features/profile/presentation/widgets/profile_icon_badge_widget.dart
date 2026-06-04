import 'package:flutter/material.dart';
import 'package:youpass/core/theme/youpass_theme_extension.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_design_spec.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_instagram_icon.dart';

class ProfileIconBadgeWidget extends StatelessWidget {
  const ProfileIconBadgeWidget({
    super.key,
    required this.icon,
    this.size,
    this.iconSize,
    this.useInstagramIcon = false,
  });

  final IconData icon;
  final double? size;
  final double? iconSize;
  final bool useInstagramIcon;

  @override
  Widget build(BuildContext context) {
    final theme = YouPassThemeExtension.of(context);
    final circleSize = size ??
        ProfileDesignSpec.px(context, ProfileDesignSpec.infoIconCircleSize);
    final innerIconSize = iconSize ??
        ProfileDesignSpec.px(context, ProfileDesignSpec.infoIconInnerSize);

    return Container(
      width: circleSize,
      height: circleSize,
      decoration: BoxDecoration(
        color: theme.profileIconBadgeBackground,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: useInstagramIcon
          ? ProfileInstagramIcon(
              color: ProfileDesignSpec.primary,
              size: innerIconSize,
            )
          : Icon(
              icon,
              size: innerIconSize,
              color: ProfileDesignSpec.primary,
            ),
    );
  }
}
