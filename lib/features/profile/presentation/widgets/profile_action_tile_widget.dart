import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';

class ProfileActionTileWidget extends StatelessWidget {
  const ProfileActionTileWidget({
    super.key,
    required this.icon,
    required this.label,
    this.trailing,
    this.labelColor,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final Widget? trailing;
  final Color? labelColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final textColor = labelColor ?? AppColors.primaryMustard;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(layout.radius(8)),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: layout.spacing(10)),
          child: Row(
            children: [
              Icon(
                icon,
                size: layout.fontSize(20),
                color: textColor,
              ),
              SizedBox(width: layout.spacing(12)),
              Expanded(
                child: AppText(
                  label,
                  variant: AppTextVariant.bodyEmphasis,
                  color: textColor,
                  fontSize: layout.fontSize(15),
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing ??
                  Icon(
                    Icons.chevron_right,
                    color: textColor,
                    size: layout.fontSize(22),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
