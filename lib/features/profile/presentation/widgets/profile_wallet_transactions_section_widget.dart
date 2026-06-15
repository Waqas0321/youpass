import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/profile/data/models/profile_wallet_transaction_model.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_design_spec.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_section_card_widget.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_theme.dart';

class ProfileWalletTransactionsSectionWidget extends StatelessWidget {
  const ProfileWalletTransactionsSectionWidget({
    super.key,
    required this.transactions,
    this.isLoading = false,
  });

  final List<ProfileWalletTransactionModel> transactions;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final theme = ProfileTheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          AppStrings.profileWalletTransactionHistory(strings),
          style: TextStyle(
            fontSize: ProfileDesignSpec.px(context, 13),
            fontWeight: FontWeight.w800,
            color: theme.primary,
            letterSpacing: 0.4,
          ),
        ),
        SizedBox(height: ProfileDesignSpec.px(context, 12)),
        if (isLoading)
          ProfileSectionCardWidget(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: ProfileDesignSpec.px(context, 20),
              ),
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
            ),
          )
        else if (transactions.isEmpty)
          ProfileSectionCardWidget(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: ProfileDesignSpec.px(context, 16),
              ),
              child: Text(
                AppStrings.profileWalletNoTransactions(strings),
                style: TextStyle(
                  fontSize: ProfileDesignSpec.px(context, 14),
                  color: theme.labelText,
                ),
              ),
            ),
          )
        else
          ProfileSectionCardWidget(
            padding: EdgeInsets.symmetric(
              horizontal: ProfileDesignSpec.px(context, 12),
              vertical: ProfileDesignSpec.px(context, 4),
            ),
            child: Column(
              children: [
                for (var index = 0; index < transactions.length; index++) ...[
                  if (index > 0)
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: theme.rowDivider,
                    ),
                  _TransactionRow(
                    transaction: transactions[index],
                    theme: theme,
                  ),
                ],
              ],
            ),
          ),
      ],
    );
  }
}

class _TransactionRow extends StatelessWidget {
  const _TransactionRow({
    required this.transaction,
    required this.theme,
  });

  final ProfileWalletTransactionModel transaction;
  final ProfileTheme theme;

  @override
  Widget build(BuildContext context) {
    final amount = transaction.amount == transaction.amount.roundToDouble()
        ? transaction.amount.toInt().toString()
        : transaction.amount.toStringAsFixed(0);

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: ProfileDesignSpec.px(context, 12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.description,
                  style: TextStyle(
                    fontSize: ProfileDesignSpec.px(context, 14),
                    fontWeight: FontWeight.w600,
                    color: theme.valueText,
                  ),
                ),
                SizedBox(height: ProfileDesignSpec.px(context, 2)),
                Text(
                  _formatDate(transaction.createdAt),
                  style: TextStyle(
                    fontSize: ProfileDesignSpec.px(context, 12),
                    color: theme.labelText,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '-$amount ${transaction.currency}',
            style: TextStyle(
              fontSize: ProfileDesignSpec.px(context, 14),
              fontWeight: FontWeight.w700,
              color: theme.valueText,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String raw) {
    final parsed = DateTime.tryParse(raw);
    if (parsed == null) {
      return raw;
    }
    final day = parsed.day.toString().padLeft(2, '0');
    final month = parsed.month.toString().padLeft(2, '0');
    final year = parsed.year;
    return '$day/$month/$year';
  }
}
