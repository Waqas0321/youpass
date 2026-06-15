import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/profile/data/models/profile_wallet_balance_model.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_design_spec.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_section_card_widget.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_theme.dart';

class ProfileWalletBalanceSectionWidget extends StatelessWidget {
  const ProfileWalletBalanceSectionWidget({
    super.key,
    required this.balance,
  });

  final ProfileWalletBalanceModel balance;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final theme = ProfileTheme.of(context);
    final amount = balance.credits == balance.credits.roundToDouble()
        ? balance.credits.toInt().toString()
        : balance.credits.toStringAsFixed(2);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          AppStrings.profileWalletAvailableBalance(strings),
          style: TextStyle(
            fontSize: ProfileDesignSpec.px(context, 13),
            fontWeight: FontWeight.w800,
            color: theme.primary,
            letterSpacing: 0.4,
          ),
        ),
        SizedBox(height: ProfileDesignSpec.px(context, 12)),
        ProfileSectionCardWidget(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: ProfileDesignSpec.px(context, 14),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.account_balance_wallet_outlined,
                  color: theme.primary,
                  size: ProfileDesignSpec.px(context, 22),
                ),
                SizedBox(width: ProfileDesignSpec.px(context, 12)),
                Expanded(
                  child: Text(
                    AppStrings.profileWalletCredits(strings, amount),
                    style: TextStyle(
                      fontSize: ProfileDesignSpec.px(context, 16),
                      fontWeight: FontWeight.w700,
                      color: theme.valueText,
                    ),
                  ),
                ),
                Text(
                  balance.currency,
                  style: TextStyle(
                    fontSize: ProfileDesignSpec.px(context, 13),
                    fontWeight: FontWeight.w600,
                    color: theme.labelText,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
