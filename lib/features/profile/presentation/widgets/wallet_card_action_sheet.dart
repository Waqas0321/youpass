import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/ios_action_bottom_sheet.dart';
import 'package:youpass/features/profile/data/models/profile_wallet_card_model.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_theme.dart';

enum WalletCardSheetAction { setDefault, delete, confirmDelete }

class WalletCardActionSheet {
  WalletCardActionSheet._();

  static Future<WalletCardSheetAction?> show({
    required BuildContext context,
    required ProfileWalletCardModel card,
    required bool isDefaultCard,
  }) {
    final strings = context.l10n;
    final theme = ProfileTheme.of(context);

    return IosActionBottomSheet.show<WalletCardSheetAction>(
      context: context,
      child: IosActionBottomSheet.body(
        children: [
          IosActionGroup(
            children: [
              IosSheetTitle(
                title: card.maskedLabel,
                subtitle: card.displaySubtitle,
              ),
              if (!isDefaultCard) ...[
                const IosSheetDivider(),
                IosSheetAction(
                  label: AppStrings.profileSetDefaultCard(strings),
                  icon: Icons.star_outline,
                  color: theme.primary,
                  fontWeight: FontWeight.w600,
                  onTap: () => Navigator.pop(
                    context,
                    WalletCardSheetAction.setDefault,
                  ),
                ),
              ],
              const IosSheetDivider(),
              IosSheetAction(
                label: AppStrings.profileDeleteCard(strings),
                icon: Icons.delete_outline,
                color: AppColors.profileDeleteRed,
                onTap: () => Navigator.pop(context, WalletCardSheetAction.delete),
              ),
            ],
          ),
          IosActionBottomSheet.gap(),
          IosActionGroup(
            children: [
              IosSheetCancelButton(
                label: AppStrings.confirmDialogCancel(strings),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Future<bool> confirmDelete({
    required BuildContext context,
    required ProfileWalletCardModel card,
  }) async {
    final strings = context.l10n;
    final layout = ResponsiveLayout(context);

    final result = await IosActionBottomSheet.show<WalletCardSheetAction>(
      context: context,
      child: IosActionBottomSheet.body(
        children: [
          IosActionGroup(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                  layout.spacing(16),
                  layout.spacing(16),
                  layout.spacing(16),
                  layout.spacing(8),
                ),
                child: Text(
                  AppStrings.profileDeleteCard(strings),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: layout.fontSize(13),
                    color: CupertinoColors.secondaryLabel.resolveFrom(context),
                  ),
                ),
              ),
              IosSheetTitle(
                title: card.maskedLabel,
                subtitle: card.displaySubtitle,
              ),
              const IosSheetDivider(),
              IosSheetAction(
                label: AppStrings.profileDeleteCard(strings),
                icon: Icons.delete_outline,
                color: AppColors.profileDeleteRed,
                fontWeight: FontWeight.w600,
                onTap: () => Navigator.pop(
                  context,
                  WalletCardSheetAction.confirmDelete,
                ),
              ),
            ],
          ),
          IosActionBottomSheet.gap(),
          IosActionGroup(
            children: [
              IosSheetCancelButton(
                label: AppStrings.confirmDialogCancel(strings),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        ],
      ),
    );
    return result == WalletCardSheetAction.confirmDelete;
  }
}
