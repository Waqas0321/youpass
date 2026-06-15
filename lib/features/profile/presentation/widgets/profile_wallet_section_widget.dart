import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/widgets/youpass_outline_button.dart';
import 'package:youpass/features/profile/data/models/profile_wallet_card_model.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_design_spec.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_section_header_widget.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_theme.dart';

class ProfileWalletSectionWidget extends StatelessWidget {
  const ProfileWalletSectionWidget({
    super.key,
    this.cards = const [],
    this.isLoading = false,
    this.onViewWalletTap,
    this.onAddCardTap,
    this.showFullList = false,
    this.onCardTap,
    this.compactHeader = false,
    this.previewMode = false,
  });

  final List<ProfileWalletCardModel> cards;
  final bool isLoading;
  final VoidCallback? onViewWalletTap;
  final VoidCallback? onAddCardTap;
  final bool showFullList;
  final ValueChanged<ProfileWalletCardModel>? onCardTap;
  final bool compactHeader;
  final bool previewMode;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final theme = ProfileTheme.of(context);
    final previewCards = showFullList ? cards : cards.take(2).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (!compactHeader) ...[
          ProfileSectionHeaderWidget(
            icon: Icons.account_balance_wallet_outlined,
            title: AppStrings.profileWalletSection(strings),
          ),
          SizedBox(height: ProfileDesignSpec.px(context, 8)),
        ],
        Text(
          AppStrings.profilePaymentMethods(strings),
          style: TextStyle(
            fontSize: ProfileDesignSpec.px(context, 13),
            fontWeight: FontWeight.w600,
            color: theme.labelText,
            height: 1.2,
          ),
        ),
        SizedBox(height: ProfileDesignSpec.px(context, 12)),
        if (isLoading)
          Padding(
            padding: EdgeInsets.all(ProfileDesignSpec.px(context, 24)),
            child: Center(
              child: SizedBox(
                width: ProfileDesignSpec.px(context, 24),
                height: ProfileDesignSpec.px(context, 24),
                child: CircularProgressIndicator(
                  color: theme.primary,
                  strokeWidth: 2.5,
                ),
              ),
            ),
          )
        else if (previewCards.isEmpty)
          _EmptyWalletCard(onAddTap: onAddCardTap)
        else
          ...previewCards.map(
            (card) => ProfilePaymentCardTile(
              card: card,
              onTap: onCardTap == null ? null : () => onCardTap!(card),
              showChevron: previewMode || onCardTap != null,
              showSubtitle: !previewMode,
              expiryOnly: showFullList,
            ),
          ),
        if (showFullList && onAddCardTap != null) ...[
          SizedBox(height: ProfileDesignSpec.px(context, 12)),
          _AddCardButton(onTap: onAddCardTap!),
        ],
        if (!showFullList) ...[
          SizedBox(height: ProfileDesignSpec.px(context, 12)),
          YouPassOutlineButton(
            label: AppStrings.profileViewFullWallet(strings),
            trailingIcon: Icons.chevron_right,
            backgroundColor: theme.walletViewButtonFill,
            onPressed: onViewWalletTap,
          ),
        ],
      ],
    );
  }
}

class _EmptyWalletCard extends StatelessWidget {
  const _EmptyWalletCard({this.onAddTap});

  final VoidCallback? onAddTap;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final theme = ProfileTheme.of(context);

    return Container(
      padding: EdgeInsets.all(ProfileDesignSpec.px(context, 20)),
      decoration: BoxDecoration(
        color: theme.walletCardBackground,
        borderRadius: BorderRadius.circular(
          ProfileDesignSpec.px(context, ProfileDesignSpec.walletCardRadius),
        ),
        border: Border.all(color: theme.walletCardBorder),
      ),
      child: Column(
        children: [
          Icon(
            Icons.credit_card_off_outlined,
            size: ProfileDesignSpec.px(context, 32),
            color: theme.labelText,
          ),
          SizedBox(height: ProfileDesignSpec.px(context, 8)),
          Text(
            AppStrings.vipAddPaymentMethod(strings),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: ProfileDesignSpec.px(context, 14),
              color: theme.labelText,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

class _AddCardButton extends StatelessWidget {
  const _AddCardButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final theme = ProfileTheme.of(context);

    return YouPassOutlineButton(
      label: AppStrings.profileWalletAddCard(strings),
      icon: Icons.add_card_outlined,
      backgroundColor: theme.walletViewButtonFill,
      onPressed: onTap,
    );
  }
}

class ProfilePaymentCardTile extends StatelessWidget {
  const ProfilePaymentCardTile({
    super.key,
    required this.card,
    this.onTap,
    this.showChevron = true,
    this.showSubtitle = true,
    this.expiryOnly = false,
  });

  final ProfileWalletCardModel card;
  final VoidCallback? onTap;
  final bool showChevron;
  final bool showSubtitle;
  final bool expiryOnly;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final theme = ProfileTheme.of(context);
    final brandColor = _brandColor(card.brand);
    final isDefault = card.isDefault;
    final radius =
        ProfileDesignSpec.px(context, ProfileDesignSpec.walletCardRadius);
    final subtitle = expiryOnly ? card.displayExpiry : card.displaySubtitle;

    return Padding(
      padding: EdgeInsets.only(bottom: ProfileDesignSpec.px(context, 10)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(radius),
          child: Ink(
            decoration: BoxDecoration(
              color: theme.walletCardBackground,
              borderRadius: BorderRadius.circular(radius),
              border: Border.all(
                color: isDefault
                    ? theme.primary.withValues(alpha: 0.35)
                    : theme.walletCardBorder,
                width: isDefault ? 1.5 : 1,
              ),
              boxShadow: theme.isDark
                  ? null
                  : const [
                      BoxShadow(
                        color: Color(0x0A000000),
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ProfileDesignSpec.px(context, 14),
                vertical: ProfileDesignSpec.px(context, 12),
              ),
              child: Row(
                children: [
                  Container(
                    width: ProfileDesignSpec.px(context, 44),
                    height: ProfileDesignSpec.px(context, 30),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: brandColor,
                      borderRadius: BorderRadius.circular(
                        ProfileDesignSpec.px(context, 6),
                      ),
                    ),
                    child: Text(
                      _brandLabel(card.brand, strings),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: ProfileDesignSpec.px(context, 10),
                        height: 1,
                      ),
                    ),
                  ),
                  SizedBox(width: ProfileDesignSpec.px(context, 12)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          card.maskedLabel,
                          style: TextStyle(
                            fontSize: ProfileDesignSpec.px(context, 15),
                            fontWeight: FontWeight.w700,
                            color: theme.valueText,
                            height: 1.2,
                          ),
                        ),
                        if (showSubtitle && subtitle.isNotEmpty) ...[
                          SizedBox(height: ProfileDesignSpec.px(context, 2)),
                          Text(
                            subtitle,
                            style: TextStyle(
                              fontSize: ProfileDesignSpec.px(context, 12),
                              color: theme.labelText,
                              height: 1.2,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (isDefault)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: ProfileDesignSpec.px(context, 8),
                        vertical: ProfileDesignSpec.px(context, 4),
                      ),
                      decoration: BoxDecoration(
                        color: theme.primary.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(
                          ProfileDesignSpec.px(context, 20),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.star_rounded,
                            size: ProfileDesignSpec.px(context, 14),
                            color: theme.primary,
                          ),
                          SizedBox(width: ProfileDesignSpec.px(context, 3)),
                          Text(
                            AppStrings.profileDefaultCard(strings),
                            style: TextStyle(
                              color: theme.primary,
                              fontSize: ProfileDesignSpec.px(context, 11),
                              fontWeight: FontWeight.w700,
                              height: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (showChevron) ...[
                    SizedBox(width: ProfileDesignSpec.px(context, 6)),
                    Icon(
                      Icons.chevron_right,
                      color: theme.primary,
                      size: ProfileDesignSpec.px(context, 22),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _brandColor(String brand) {
    switch (brand.toLowerCase()) {
      case 'mastercard':
        return const Color(0xFFEB001B);
      case 'amex':
        return const Color(0xFF2E77BC);
      case 'diners':
        return const Color(0xFF0079BE);
      default:
        return const Color(0xFF1A1F71);
    }
  }

  String _brandLabel(String brand, dynamic strings) {
    switch (brand.toLowerCase()) {
      case 'mastercard':
        return AppStrings.paymentBrandMastercard(strings);
      case 'amex':
        return 'AMEX';
      case 'diners':
        return 'DINERS';
      default:
        return AppStrings.paymentBrandVisa(strings);
    }
  }
}
