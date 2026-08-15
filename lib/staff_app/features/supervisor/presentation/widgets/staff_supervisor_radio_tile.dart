import 'package:flutter/material.dart';

import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/core/widgets/app_text.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_design.dart';

class StaffSupervisorRadioTile extends StatelessWidget {
  const StaffSupervisorRadioTile({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    this.fontSize,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(layout.radius(8)),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: layout.spacing(8)),
          child: Row(
            children: [
              Container(
                width: layout.spacing(18),
                height: layout.spacing(18),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: selected
                        ? StaffSupervisorDesign.accent
                        : AppColors.lightGreyBorder,
                    width: selected ? 2 : 1.5,
                  ),
                ),
                child: selected
                    ? Center(
                        child: Container(
                          width: layout.spacing(8),
                          height: layout.spacing(8),
                          decoration: const BoxDecoration(
                            color: StaffSupervisorDesign.accent,
                            shape: BoxShape.circle,
                          ),
                        ),
                      )
                    : null,
              ),
              SizedBox(width: layout.spacing(8)),
              Expanded(
                child: AppText(
                  label,
                  variant: AppTextVariant.body,
                  color: AppColors.homeBlack,
                  fontSize: fontSize ?? layout.fontSize(12),
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StaffSupervisorActionTile extends StatelessWidget {
  const StaffSupervisorActionTile({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.borderColor,
    this.foregroundColor,
    this.selected = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? borderColor;
  final Color? foregroundColor;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final color = foregroundColor ?? StaffSupervisorDesign.accent;
    final defaultBorder = borderColor ?? StaffSupervisorDesign.tileBorder;

    return Material(
      color: selected
          ? color.withValues(alpha: 0.12)
          : StaffSupervisorDesign.tileBackground,
      borderRadius: BorderRadius.circular(layout.radius(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(layout.radius(12)),
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: layout.spacing(12),
            horizontal: layout.spacing(4),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(layout.radius(12)),
            border: Border.all(
              color: selected ? color : defaultBorder,
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color, size: layout.spacing(22)),
              SizedBox(height: layout.spacing(6)),
              AppText(
                label,
                variant: AppTextVariant.label,
                color: color,
                fontWeight: FontWeight.w700,
                fontSize: layout.fontSize(9),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
