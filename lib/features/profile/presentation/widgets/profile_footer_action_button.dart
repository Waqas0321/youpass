import 'package:flutter/material.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_design_spec.dart';

class ProfileFooterActionButton extends StatelessWidget {
  const ProfileFooterActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.borderColor,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color borderColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final radius =
        ProfileDesignSpec.px(context, ProfileDesignSpec.footerButtonRadius);
    final verticalPadding = ProfileDesignSpec.px(
      context,
      ProfileDesignSpec.footerButtonPaddingVertical,
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(radius),
        child: Ink(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
              color: borderColor,
              width: 1,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ProfileDesignSpec.px(context, 16),
              vertical: verticalPadding,
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: ProfileDesignSpec.px(context, 20),
                  color: foregroundColor,
                ),
                SizedBox(width: ProfileDesignSpec.px(context, 12)),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: ProfileDesignSpec.px(context, 15),
                      fontWeight: FontWeight.w700,
                      color: foregroundColor,
                      height: 1.2,
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  size: ProfileDesignSpec.px(context, 22),
                  color: foregroundColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
