import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/constants/app_constants.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';

class HomeTopBarWidget extends StatelessWidget {
  const HomeTopBarWidget({
    super.key,
    this.onMenuTap,
  });

  final VoidCallback? onMenuTap;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: layout.spacing(4),
        vertical: layout.spacing(8),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: onMenuTap ?? () {},
            icon: Icon(
              Icons.menu,
              color: AppColors.homeAccentYellow,
              size: layout.iconSize,
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: layout.spacing(20),
                  vertical: layout.spacing(8),
                ),
                decoration: BoxDecoration(
                  color: AppColors.homeBlack,
                  borderRadius: BorderRadius.circular(layout.radius(30)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: layout.spacing(28),
                      height: layout.spacing(28),
                      decoration: const BoxDecoration(
                        color: AppColors.homeAccentYellow,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: AppText(
                        AppStrings.brandBadgeOff(context.l10n),
                        variant: AppTextVariant.sectionCaption,
                        color: AppColors.homeBlack,
                        fontSize: layout.fontSize(7),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(width: layout.spacing(8)),
                    AppText(
                      AppConstants.appName,
                      variant: AppTextVariant.bodyEmphasis,
                      color: AppColors.homeAccentYellow,
                      fontSize: layout.fontSize(18),
                      fontWeight: FontWeight.w800,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: layout.iconSize + layout.spacing(16)),
        ],
      ),
    );
  }
}
