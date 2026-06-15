import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';

class WaitlistOfferBannerWidget extends StatelessWidget {
  const WaitlistOfferBannerWidget({
    super.key,
    required this.expiresInLabel,
    required this.onTap,
  });

  final String expiresInLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final strings = context.l10n;

    return Material(
      color: AppColors.primaryMustard.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(layout.radius(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(layout.radius(12)),
        child: Padding(
          padding: EdgeInsets.all(layout.spacing(14)),
          child: Row(
            children: [
              Icon(
                Icons.timer_outlined,
                color: AppColors.primaryMustard,
                size: layout.iconSize,
              ),
              SizedBox(width: layout.spacing(12)),
              Expanded(
                child: AppText(
                  AppStrings.waitlistOfferBanner(strings, expiresInLabel),
                  variant: AppTextVariant.bodyEmphasis,
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: AppColors.profileLabelGrey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
