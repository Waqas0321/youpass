import 'package:flutter/material.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_design_spec.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_theme.dart';

class NotificationChannelToggleRow extends StatelessWidget {
  const NotificationChannelToggleRow({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.value,
    required this.onChanged,
    this.enabled = true,
    this.showDivider = true,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final bool value;
  final ValueChanged<bool>? onChanged;
  final bool enabled;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final theme = ProfileTheme.of(context);
    final contentOpacity = enabled ? 1.0 : 0.45;

    return Column(
      children: [
        Opacity(
          opacity: contentOpacity,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: ProfileDesignSpec.px(context, 10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: ProfileDesignSpec.px(context, 36),
                  height: ProfileDesignSpec.px(context, 36),
                  decoration: BoxDecoration(
                    color: theme.iconCircleBackground,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    icon,
                    size: ProfileDesignSpec.px(context, 18),
                    color: theme.primary,
                  ),
                ),
                SizedBox(width: ProfileDesignSpec.px(context, 12)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: ProfileDesignSpec.px(context, 15),
                          fontWeight: FontWeight.w700,
                          color: theme.valueText,
                          height: 1.2,
                        ),
                      ),
                      SizedBox(height: ProfileDesignSpec.px(context, 4)),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: ProfileDesignSpec.px(context, 12),
                          color: theme.labelText,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: value,
                  onChanged: onChanged,
                  activeThumbColor: theme.switchThumbColor,
                  activeTrackColor: theme.primary,
                  inactiveThumbColor: theme.switchThumbColor,
                  inactiveTrackColor: theme.switchInactiveTrack,
                ),
              ],
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
