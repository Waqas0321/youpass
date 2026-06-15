import 'package:flutter/material.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_design_spec.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_theme.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_icon_badge_widget.dart';

class ProfileSectionHeaderWidget extends StatelessWidget {
  const ProfileSectionHeaderWidget({
    super.key,
    required this.icon,
    required this.title,
    this.useIconBadge = true,
  });

  final IconData icon;
  final String title;
  final bool useIconBadge;

  @override
  Widget build(BuildContext context) {
    final theme = ProfileTheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            if (useIconBadge)
              ProfileIconBadgeWidget(
                icon: icon,
                size: ProfileDesignSpec.px(
                  context,
                  ProfileDesignSpec.sectionHeaderIconCircleSize,
                ),
                iconSize: ProfileDesignSpec.px(
                  context,
                  ProfileDesignSpec.sectionHeaderIconInnerSize,
                ),
              )
            else
              Icon(
                icon,
                size: ProfileDesignSpec.px(
                  context,
                  ProfileDesignSpec.sectionHeaderIconInnerSize,
                ),
                color: theme.primary,
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
                color: theme.primary,
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
          color: theme.sectionDivider,
        ),
      ],
    );
  }
}
