import 'package:flutter/material.dart';

import 'package:youpass/staff_app/core/constants/app_colors.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/staff_app/core/utils/responsive_layout.dart';
import 'package:youpass/staff_app/core/widgets/app_text.dart';
import 'package:youpass/staff_app/core/widgets/app_text_variant.dart';

class StaffActiveEventBanner extends StatelessWidget {
  const StaffActiveEventBanner({
    super.key,
    required this.eventName,
    this.onTap,
  });

  final String eventName;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final layout = ResponsiveLayout(context);

    return Material(
      color: AppColors.backgroundWhite,
      borderRadius: BorderRadius.circular(layout.radius(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(layout.radius(16)),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: layout.spacing(14),
            vertical: layout.spacing(14),
          ),
          decoration: BoxDecoration(
            color: AppColors.backgroundWhite,
            borderRadius: BorderRadius.circular(layout.radius(16)),
            border: Border.all(color: AppColors.homeDividerGrey),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: layout.spacing(10),
                offset: Offset(0, layout.spacing(3)),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: layout.spacing(40),
                height: layout.spacing(40),
                decoration: const BoxDecoration(
                  color: Color(0xFFFFF8EB),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.event_outlined,
                  color: AppColors.primaryMustard,
                  size: layout.spacing(20),
                ),
              ),
              SizedBox(width: layout.spacing(12)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      l10n.staffActiveEventPrefix,
                      variant: AppTextVariant.label,
                      color: AppColors.secondaryGrey,
                      fontSize: layout.fontSize(12),
                    ),
                    SizedBox(height: layout.spacing(2)),
                    AppText(
                      eventName,
                      variant: AppTextVariant.bodyEmphasis,
                      color: AppColors.homeBlack,
                      fontWeight: FontWeight.w700,
                      fontSize: layout.fontSize(15),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: AppColors.secondaryGrey,
                size: layout.spacing(22),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
