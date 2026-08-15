import 'package:flutter/material.dart';

import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/core/widgets/app_text.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_design.dart';

class StaffSupervisorPrimaryButton extends StatelessWidget {
  const StaffSupervisorPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon = Icons.search_rounded,
  });

  final String label;
  final VoidCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return SizedBox(
      height: layout.buttonHeight,
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: StaffSupervisorDesign.accent,
          foregroundColor: AppColors.backgroundWhite,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(layout.radius(14)),
          ),
        ),
        icon: Icon(icon, size: layout.spacing(20)),
        label: AppText(
          label,
          variant: AppTextVariant.button,
          color: AppColors.backgroundWhite,
          fontWeight: FontWeight.w800,
          fontSize: layout.fontSize(14),
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

class StaffSupervisorExecuteFooter extends StatelessWidget {
  const StaffSupervisorExecuteFooter({
    super.key,
    required this.label,
    required this.enabled,
    required this.onPressed,
    this.icon = Icons.lock_outline_rounded,
    this.isLoading = false,
    this.leading,
  });

  final String label;
  final bool enabled;
  final VoidCallback onPressed;
  final IconData icon;
  final bool isLoading;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return Container(
      color: StaffSupervisorDesign.pageBackground,
      padding: EdgeInsets.fromLTRB(
        layout.spacing(20),
        layout.spacing(8),
        layout.spacing(20),
        layout.spacing(24),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          width: double.infinity,
          height: layout.buttonHeight,
          child: ElevatedButton.icon(
            onPressed: enabled && !isLoading ? onPressed : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: StaffSupervisorDesign.accent,
              disabledBackgroundColor:
                  StaffSupervisorDesign.accent.withValues(alpha: 0.42),
              foregroundColor: AppColors.backgroundWhite,
              disabledForegroundColor:
                  AppColors.backgroundWhite.withValues(alpha: 0.85),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(layout.radius(16)),
              ),
            ),
            icon: isLoading
                ? SizedBox(
                    width: layout.spacing(18),
                    height: layout.spacing(18),
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.backgroundWhite,
                    ),
                  )
                : leading ??
                    Icon(icon, size: layout.spacing(20)),
            label: AppText(
              label,
              variant: AppTextVariant.button,
              color: AppColors.backgroundWhite,
              fontWeight: FontWeight.w800,
              fontSize: layout.fontSize(14),
              letterSpacing: 0.7,
            ),
          ),
        ),
      ),
    );
  }
}
