import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_section_header_widget.dart';

class ProfileWalletSectionWidget extends StatelessWidget {
  const ProfileWalletSectionWidget({
    super.key,
    this.onViewWalletTap,
  });

  final VoidCallback? onViewWalletTap;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final strings = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ProfileSectionHeaderWidget(
          icon: Icons.account_balance_wallet_outlined,
          title: AppStrings.profileWalletSection(strings),
        ),
        SizedBox(height: layout.spacing(8)),
        AppText(
          AppStrings.profilePaymentMethods(strings),
          variant: AppTextVariant.body,
          color: AppColors.secondaryGrey,
          fontSize: layout.fontSize(13),
        ),
        SizedBox(height: layout.spacing(12)),
        ProfilePaymentCardTile(
          brandLabel: 'VISA',
          brandColor: AppColors.profileVisaBrand,
          cardLabel: AppStrings.profileCardVisa(strings),
          isDefault: true,
        ),
        ProfilePaymentCardTile(
          brandLabel: 'MC',
          brandColor: AppColors.profileMastercardBrand,
          cardLabel: AppStrings.profileCardMastercard(strings),
        ),
        SizedBox(height: layout.spacing(8)),
        GestureDetector(
          onTap: onViewWalletTap,
          child: Row(
            children: [
              AppText(
                AppStrings.profileViewFullWallet(strings),
                variant: AppTextVariant.body,
                color: AppColors.primaryMustard,
                fontWeight: FontWeight.w600,
                fontSize: layout.fontSize(14),
              ),
              Icon(
                Icons.chevron_right,
                size: layout.fontSize(18),
                color: AppColors.primaryMustard,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ProfilePaymentCardTile extends StatelessWidget {
  const ProfilePaymentCardTile({
    super.key,
    required this.brandLabel,
    required this.brandColor,
    required this.cardLabel,
    this.isDefault = false,
  });

  final String brandLabel;
  final Color brandColor;
  final String cardLabel;
  final bool isDefault;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final strings = context.l10n;

    return Padding(
      padding: EdgeInsets.only(bottom: layout.spacing(10)),
      child: Row(
        children: [
          Container(
            width: layout.spacing(40),
            height: layout.spacing(28),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: brandColor,
              borderRadius: BorderRadius.circular(layout.radius(6)),
            ),
            child: AppText(
              brandLabel,
              variant: AppTextVariant.sectionCaption,
              color: AppColors.backgroundWhite,
              fontWeight: FontWeight.w800,
              fontSize: layout.fontSize(10),
            ),
          ),
          SizedBox(width: layout.spacing(12)),
          Expanded(
            child: AppText(
              cardLabel,
              variant: AppTextVariant.bodyEmphasis,
              fontSize: layout.fontSize(14),
            ),
          ),
          if (isDefault) ...[
            Icon(
              Icons.star,
              size: layout.fontSize(16),
              color: AppColors.primaryMustard,
            ),
            SizedBox(width: layout.spacing(4)),
            AppText(
              AppStrings.profileDefaultCard(strings),
              variant: AppTextVariant.body,
              color: AppColors.primaryMustard,
              fontSize: layout.fontSize(12),
              fontWeight: FontWeight.w600,
            ),
          ],
          Icon(
            Icons.chevron_right,
            color: AppColors.primaryMustard,
            size: layout.fontSize(22),
          ),
        ],
      ),
    );
  }
}
