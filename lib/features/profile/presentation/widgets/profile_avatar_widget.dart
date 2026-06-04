import 'package:flutter/material.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_design_spec.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_photo_camera_badge_widget.dart';

class ProfileAvatarWidget extends StatelessWidget {
  const ProfileAvatarWidget({
    super.key,
    this.photoUrl,
    this.isUploading = false,
    this.onPhotoTap,
  });

  final String? photoUrl;
  final bool isUploading;
  final VoidCallback? onPhotoTap;

  @override
  Widget build(BuildContext context) {
    final outerSize =
        ProfileDesignSpec.px(context, ProfileDesignSpec.avatarOuterSize);
    final ringWidth =
        ProfileDesignSpec.px(context, ProfileDesignSpec.avatarRingWidth);
    final ringGap = ProfileDesignSpec.px(context, ProfileDesignSpec.avatarRingGap);
    final hasPhoto = photoUrl != null && photoUrl!.trim().isNotEmpty;

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
              child: ClipOval(
                child: SizedBox.expand(
                  child: ColoredBox(
                    color: ProfileDesignSpec.avatarInner,
                    child: buildAvatarContent(context, hasPhoto),
                  ),
                ),
              ),
            ),
          ),
          if (isUploading)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withValues(alpha: 0.35),
                ),
                alignment: Alignment.center,
                child: const SizedBox(
                  width: 28,
                  height: 28,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          Positioned(
            right: ProfileDesignSpec.px(context, 2),
            bottom: ProfileDesignSpec.px(context, 2),
            child: GestureDetector(
              onTap: isUploading ? null : onPhotoTap,
              child: const ProfilePhotoCameraBadgeWidget(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAvatarContent(BuildContext context, bool hasPhoto) {
    if (hasPhoto) {
      return Image.network(
        photoUrl!,
        fit: BoxFit.cover,
        alignment: Alignment.center,
        errorBuilder: (context, error, stackTrace) =>
            buildPlaceholderIcon(context),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return SizedBox.expand(child: child);
          }

          return Center(
            child: SizedBox(
              width: ProfileDesignSpec.px(context, 24),
              height: ProfileDesignSpec.px(context, 24),
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: ProfileDesignSpec.primary,
                value: loadingProgress.expectedTotalBytes == null
                    ? null
                    : loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!,
              ),
            ),
          );
        },
      );
    }

    return buildPlaceholderIcon(context);
  }

  Widget buildPlaceholderIcon(BuildContext context) {
    return Center(
      child: Icon(
        Icons.person,
        size: ProfileDesignSpec.px(context, ProfileDesignSpec.avatarIconSize),
        color: ProfileDesignSpec.avatarIcon,
      ),
    );
  }
}
