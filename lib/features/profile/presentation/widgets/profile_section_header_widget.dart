import 'package:flutter/material.dart';
import 'package:youpass/core/theme/youpass_theme_extension.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_design_spec.dart';

class ProfileSectionHeaderWidget extends StatelessWidget {
  const ProfileSectionHeaderWidget({
    super.key,
    required this.icon,
    required this.title,
  });

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = YouPassThemeExtension.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: ProfileDesignSpec.px(
                context,
                ProfileDesignSpec.sectionHeaderIconInnerSize,
              ),
              color: ProfileDesignSpec.primary,
            ),
            SizedBox(
              width: ProfileDesignSpec.px(
                context,
                ProfileDesignSpec.sectionHeaderGap,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: ProfileDesignSpec.px(
                  context,
                  ProfileDesignSpec.sectionHeaderFontSize,
                ),
                fontWeight: FontWeight.w800,
                color: ProfileDesignSpec.primary,
                letterSpacing: 0.6,
                height: 1.2,
              ),
            ),
          ],
        ),
        SizedBox(
          height: ProfileDesignSpec.px(
            context,
            ProfileDesignSpec.sectionHeaderBottomGap,
          ),
        ),
        Divider(
          height: 1,
          thickness: 1,
          color: theme.profileSectionDivider,
        ),
      ],
    );
  }
}
