import 'package:flutter/material.dart';

import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/core/widgets/app_text.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';

/// Page header used on supervisor tool screens (Anulaciones, etc.).
class StaffSupervisorPageHeader extends StatelessWidget {
  const StaffSupervisorPageHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.onBack,
  });

  final String title;
  final String subtitle;
  final VoidCallback? onBack;

  static const _accent = AppColors.homeAccentYellow;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return ColoredBox(
      color: AppColors.backgroundWhite,
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                layout.spacing(4),
                layout.spacing(4),
                layout.spacing(16),
                layout.spacing(12),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: onBack ?? () => Navigator.of(context).maybePop(),
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: _accent,
                      size: layout.spacing(20),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                layout.spacing(20),
                0,
                layout.spacing(20),
                layout.spacing(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    title,
                    variant: AppTextVariant.headline,
                    color: _accent,
                    fontWeight: FontWeight.w800,
                    fontSize: layout.fontSize(24),
                  ),
                  SizedBox(height: layout.spacing(4)),
                  AppText(
                    subtitle,
                    variant: AppTextVariant.body,
                    color: AppColors.secondaryGrey,
                    fontSize: layout.fontSize(13),
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: AppColors.homeDividerGrey,
            ),
          ],
        ),
      ),
    );
  }
}
