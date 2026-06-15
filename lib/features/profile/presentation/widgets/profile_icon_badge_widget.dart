import 'package:flutter/material.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_design_spec.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_theme.dart';
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
    final theme = ProfileTheme.of(context);
    final circleSize = size ??
        ProfileDesignSpec.px(context, ProfileDesignSpec.infoIconCircleSize);
    final innerIconSize = iconSize ??
        ProfileDesignSpec.px(context, ProfileDesignSpec.infoIconInnerSize);

    return Container(
      width: circleSize,
      height: circleSize,
      decoration: BoxDecoration(
        color: theme.iconCircleBackground,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: useInstagramIcon
          ? ProfileInstagramIcon(
              color: theme.primary,
              size: innerIconSize,
            )
          : Icon(
              icon,
              size: innerIconSize,
              color: theme.primary,
            ),
    );
  }
}
