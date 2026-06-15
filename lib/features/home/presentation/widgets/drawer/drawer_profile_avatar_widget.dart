import 'package:flutter/material.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/drawer_design_spec.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/drawer_profile_avatar_placeholder_widget.dart';

class DrawerProfileAvatarWidget extends StatelessWidget {
  const DrawerProfileAvatarWidget({
    super.key,
    required this.size,
    required this.firstInitial,
    required this.ringColor,
    required this.placeholderBackground,
    required this.placeholderIconColor,
    required this.placeholderInitialColor,
    this.profilePhotoUrl,
    this.ringWidth,
  });

  final double size;
  final String firstInitial;
  final Color ringColor;
  final Color placeholderBackground;
  final Color placeholderIconColor;
  final Color placeholderInitialColor;
  final String? profilePhotoUrl;
  final double? ringWidth;

  @override
  Widget build(BuildContext context) {
    final resolvedUrl = profilePhotoUrl?.trim();
    final hasPhoto = resolvedUrl != null && resolvedUrl.isNotEmpty;
    final initial = firstInitial.isEmpty ? '?' : firstInitial[0].toUpperCase();
    final resolvedRingWidth = ringWidth ??
        DrawerDesignSpec.px(context, DrawerDesignSpec.avatarRingWidth);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: ringColor, width: resolvedRingWidth),
      ),
      child: Padding(
        padding: EdgeInsets.all(resolvedRingWidth),
        child: ClipOval(
          child: hasPhoto
              ? Image.network(
                  resolvedUrl,
                  fit: BoxFit.cover,
                  width: size,
                  height: size,
                  errorBuilder: (context, error, stackTrace) {
                    return DrawerProfileAvatarPlaceholderWidget(
                      initial: initial,
                      size: size,
                      backgroundColor: placeholderBackground,
                      iconColor: placeholderIconColor,
                      initialColor: placeholderInitialColor,
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return DrawerProfileAvatarPlaceholderWidget(
                      initial: initial,
                      size: size,
                      backgroundColor: placeholderBackground,
                      iconColor: placeholderIconColor,
                      initialColor: placeholderInitialColor,
                    );
                  },
                )
              : DrawerProfileAvatarPlaceholderWidget(
                  initial: initial,
                  size: size,
                  backgroundColor: placeholderBackground,
                  iconColor: placeholderIconColor,
                  initialColor: placeholderInitialColor,
                ),
        ),
      ),
    );
  }
}
