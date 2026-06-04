import 'package:flutter/material.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_design_spec.dart';

class ProfilePhotoCameraBadgeWidget extends StatelessWidget {
  const ProfilePhotoCameraBadgeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cameraSize =
        ProfileDesignSpec.px(context, ProfileDesignSpec.cameraBadgeSize);

    return Container(
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
        size: ProfileDesignSpec.px(context, ProfileDesignSpec.cameraIconSize),
        color: ProfileDesignSpec.cameraIcon,
      ),
    );
  }
}
