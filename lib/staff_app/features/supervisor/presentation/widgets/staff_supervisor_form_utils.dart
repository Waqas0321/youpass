import 'package:flutter/material.dart';

import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/widgets/staff_supervisor_design.dart';

InputDecoration staffSupervisorInputDecoration(
  ResponsiveLayout layout, {
  required String hint,
  Widget? prefixIcon,
  Widget? suffixIcon,
  EdgeInsetsGeometry? contentPadding,
  bool compact = false,
}) {
  final hintSize = layout.fontSize(compact ? 12 : 14);
  final defaultPadding = compact
      ? EdgeInsets.symmetric(
          horizontal: layout.spacing(10),
          vertical: layout.spacing(10),
        )
      : EdgeInsets.symmetric(
          horizontal: layout.spacing(14),
          vertical: layout.spacing(14),
        );

  return InputDecoration(
    hintText: hint,
    isDense: compact,
    hintStyle: TextStyle(
      color: AppColors.secondaryGrey.withValues(alpha: 0.85),
      fontSize: hintSize,
    ),
    filled: true,
    fillColor: AppColors.backgroundWhite,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    contentPadding: contentPadding ?? defaultPadding,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(layout.radius(12)),
      borderSide: const BorderSide(color: AppColors.homeDividerGrey),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(layout.radius(12)),
      borderSide: const BorderSide(color: AppColors.homeDividerGrey),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(layout.radius(12)),
      borderSide: const BorderSide(color: StaffSupervisorDesign.accent, width: 1.5),
    ),
  );
}
