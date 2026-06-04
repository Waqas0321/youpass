import 'package:flutter/material.dart';
import 'package:youpass/core/theme/youpass_themed_colors.dart';
import 'package:youpass/core/theme/youpass_theme_extension.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_design_spec.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_icon_badge_widget.dart';

class ProfileInfoRowWidget extends StatelessWidget {
  const ProfileInfoRowWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.useInstagramIcon = false,
    this.showDivider = true,
    this.showIconCircle = false,
  });

  final IconData icon;
  final String label;
  final String value;
  final bool useInstagramIcon;
  final bool showDivider;
  final bool showIconCircle;

  @override
  Widget build(BuildContext context) {
    final theme = YouPassThemeExtension.of(context);
    final labelColor = YouPassThemedColors.secondaryText(context);
    final valueColor = YouPassThemedColors.primaryText(context);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: ProfileDesignSpec.px(
              context,
              ProfileDesignSpec.infoRowPaddingVertical,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (showIconCircle)
                ProfileIconBadgeWidget(
                  icon: icon,
                  useInstagramIcon: useInstagramIcon,
                )
              else
                Icon(
                  icon,
                  size: ProfileDesignSpec.px(
                    context,
                    ProfileDesignSpec.infoIconInnerSize,
                  ),
                  color: ProfileDesignSpec.primary,
                ),
              SizedBox(
                width: ProfileDesignSpec.px(
                  context,
                  ProfileDesignSpec.infoIconToTextGap,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: ProfileDesignSpec.px(
                          context,
                          ProfileDesignSpec.infoLabelFontSize,
                        ),
                        fontWeight: FontWeight.w400,
                        color: labelColor,
                        height: 1.2,
                      ),
                    ),
                    SizedBox(
                      height: ProfileDesignSpec.px(
                        context,
                        ProfileDesignSpec.infoLabelToValueGap,
                      ),
                    ),
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: ProfileDesignSpec.px(
                          context,
                          ProfileDesignSpec.infoValueFontSize,
                        ),
                        fontWeight: FontWeight.w700,
                        color: valueColor,
                        height: 1.25,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            thickness: 1,
            color: theme.profileRowDivider,
          ),
      ],
    );
  }
}
