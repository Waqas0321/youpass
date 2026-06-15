import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/widgets/ios_action_bottom_sheet.dart';
import 'package:youpass/features/profile/data/models/profile_wallet_card_model.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_theme.dart';

class WalletDefaultRequiredSheet {
  WalletDefaultRequiredSheet._();

  static Future<ProfileWalletCardModel?> show({
    required BuildContext context,
    required List<ProfileWalletCardModel> cards,
    required ProfileWalletCardModel currentDefault,
  }) {
    final strings = context.l10n;
    final theme = ProfileTheme.of(context);
    final alternatives =
        cards.where((card) => card.id != currentDefault.id).toList();

    return IosActionBottomSheet.show<ProfileWalletCardModel>(
      context: context,
      child: IosActionBottomSheet.body(
        children: [
          IosActionGroup(
            children: [
              IosSheetTitle(
                title: AppStrings.profileWalletSelectNewDefault(strings),
                subtitle: AppStrings.profileWalletDefaultDeleteRequired(strings),
              ),
              for (var index = 0; index < alternatives.length; index++) ...[
                if (index > 0) const IosSheetDivider(),
                IosSheetAction(
                  label: alternatives[index].maskedLabel,
                  icon: Icons.credit_card,
                  color: theme.valueText,
                  onTap: () => Navigator.pop(context, alternatives[index]),
                ),
              ],
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
}
