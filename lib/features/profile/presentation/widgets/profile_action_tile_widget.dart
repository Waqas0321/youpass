import 'package:flutter/material.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_design_spec.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_theme.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_icon_badge_widget.dart';

class ProfileActionTileWidget extends StatelessWidget {
  const ProfileActionTileWidget({
    super.key,
    required this.icon,
    required this.label,
    this.trailing,
    this.labelColor,
    this.onTap,
    this.useIconBadge = false,
    this.showDivider = false,
    this.chevronColor,
  });

  final IconData icon;
  final String label;
  final Widget? trailing;
  final Color? labelColor;
  final Color? chevronColor;
  final VoidCallback? onTap;
  final bool useIconBadge;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final theme = ProfileTheme.of(context);
    final textColor = labelColor ?? theme.valueText;
    final arrowColor = chevronColor ?? theme.chevronMuted;

    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(
              ProfileDesignSpec.px(context, 8),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: ProfileDesignSpec.px(context, 12),
              ),
              child: Row(
                children: [
                  if (useIconBadge)
                    ProfileIconBadgeWidget(icon: icon)
                  else
                    Icon(
                      icon,
                      size: ProfileDesignSpec.px(context, 20),
                      color: textColor,
                    ),
                  SizedBox(width: ProfileDesignSpec.px(context, 12)),
                  Expanded(
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: ProfileDesignSpec.px(context, 15),
                        fontWeight: FontWeight.w600,
                        color: textColor,
                        height: 1.2,
                      ),
                    ),
                  ),
                  trailing ??
                      Icon(
                        Icons.chevron_right,
                        color: arrowColor,
                        size: ProfileDesignSpec.px(context, 22),
                      ),
                ],
              ),
            ),
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            thickness: 1,
            color: theme.rowDivider,
          ),
      ],
    );
  }
}
