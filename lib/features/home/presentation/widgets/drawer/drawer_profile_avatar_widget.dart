import 'package:flutter/material.dart';
import 'package:youpass/core/theme/youpass_theme_extension.dart';
import 'package:youpass/features/home/presentation/widgets/drawer/drawer_profile_avatar_placeholder_widget.dart';

class DrawerProfileAvatarWidget extends StatelessWidget {
  const DrawerProfileAvatarWidget({
    super.key,
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
      decoration: BoxDecoration(
        color: YouPassThemeExtension.of(context).drawerAvatarBackground,
        shape: BoxShape.circle,
      ),
      clipBehavior: Clip.antiAlias,
      child: hasPhoto
          ? Image.network(
              resolvedUrl,
              fit: BoxFit.cover,
              width: size,
              height: size,
              errorBuilder: (context, error, stackTrace) {
                return const DrawerProfileAvatarPlaceholderWidget();
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return const DrawerProfileAvatarPlaceholderWidget();
              },
            )
          : const DrawerProfileAvatarPlaceholderWidget(),
    );
  }
}
