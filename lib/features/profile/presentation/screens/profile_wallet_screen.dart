import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/network/api_exception.dart';
import 'package:youpass/core/widgets/app_snack_bar.dart';
import 'package:youpass/dependency_injection/injection_container.dart';
import 'package:youpass/features/profile/data/models/profile_wallet_balance_model.dart';
import 'package:youpass/features/profile/data/models/profile_wallet_card_model.dart';
import 'package:youpass/features/profile/data/models/profile_wallet_transaction_model.dart';
import 'package:youpass/features/profile/data/services/profile_api_service.dart';
import 'package:youpass/features/profile/presentation/utils/wallet_add_card_flow.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_app_bar_widget.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_design_spec.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_theme.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_wallet_balance_section_widget.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_wallet_section_widget.dart';
import 'package:youpass/features/profile/presentation/widgets/profile_wallet_transactions_section_widget.dart';
import 'package:youpass/features/profile/presentation/widgets/wallet_card_action_sheet.dart';
import 'package:youpass/features/profile/presentation/widgets/wallet_default_required_sheet.dart';

class ProfileWalletScreen extends StatefulWidget {
  const ProfileWalletScreen({super.key});

  @override
  State<ProfileWalletScreen> createState() => _ProfileWalletScreenState();
}

class _ProfileWalletScreenState extends State<ProfileWalletScreen> {
  final profileApi = sl<ProfileApiService>();
  List<ProfileWalletCardModel> cards = [];
  ProfileWalletBalanceModel balance = ProfileWalletBalanceModel.empty;
  List<ProfileWalletTransactionModel> transactions = [];
  bool isLoadingCards = true;
  bool isLoadingTransactions = true;

  @override
  void initState() {
    super.initState();
    loadWallet();
  }

  Future<void> loadWallet() async {
    setState(() {
      isLoadingCards = true;
      isLoadingTransactions = true;
    });

    try {
      final walletData = await profileApi.fetchWalletData();
      final transactionList = await profileApi.fetchWalletTransactions();

      if (!mounted) {
        return;
      }

      setState(() {
        cards = walletData.cards;
        balance = walletData.balance;
        transactions = transactionList;
        isLoadingCards = false;
        isLoadingTransactions = false;
      });
    } catch (_) {
      if (mounted) {
        setState(() {
          isLoadingCards = false;
          isLoadingTransactions = false;
        });
      }
    }
  }

  Future<void> handleAddCard() async {
    final saved = await WalletAddCardFlow(profileApi: profileApi).start(context);
    if (!mounted) {
      return;
    }
    if (saved) {
      await loadWallet();
      AppSnackBar.show(
        context,
        AppStrings.invitationsSaveCard(context.l10n),
      );
    }
  }

  Future<void> handleCardTap(ProfileWalletCardModel card) async {
    final action = await WalletCardActionSheet.show(
      context: context,
      card: card,
      isDefaultCard: card.isDefault,
    );

    if (!mounted || action == null) {
      return;
    }

    switch (action) {
      case WalletCardSheetAction.setDefault:
        await applySetDefault(card);
      case WalletCardSheetAction.delete:
        await applyDelete(card);
      case WalletCardSheetAction.confirmDelete:
        break;
    }
  }

  Future<void> applySetDefault(ProfileWalletCardModel card) async {
    final strings = context.l10n;

    if (card.id.isEmpty || card.isDefault) {
      return;
    }

    try {
      await profileApi.setDefaultWalletCard(card.id);
      await loadWallet();
      if (mounted) {
        AppSnackBar.show(context, AppStrings.profileDefaultCardUpdated(strings));
      }
    } catch (_) {
      if (mounted) {
        AppSnackBar.show(context, strings.errorGeneric);
      }
    }
  }

  Future<void> applyDelete(ProfileWalletCardModel card) async {
    final strings = context.l10n;
    final otherCards = cards.where((item) => item.id != card.id).toList();

    if (card.isDefault && otherCards.isNotEmpty) {
      final replacement = await WalletDefaultRequiredSheet.show(
        context: context,
        cards: cards,
        currentDefault: card,
      );

      if (!mounted || replacement == null) {
        return;
      }

      try {
        await profileApi.setDefaultWalletCard(replacement.id);
      } catch (_) {
        if (mounted) {
          AppSnackBar.show(context, strings.errorGeneric);
        }
        return;
      }
    }

    final confirmed = await WalletCardActionSheet.confirmDelete(
      context: context,
      card: card,
    );

    if (!mounted || !confirmed) {
      return;
    }

    try {
      await profileApi.deleteWalletCard(card.id);
      await loadWallet();
    } on ApiException catch (error) {
      if (!mounted) {
        return;
      }

      if (error.code == 'DEFAULT_CARD_REQUIRED') {
        AppSnackBar.show(
          context,
          AppStrings.profileWalletDefaultDeleteRequired(strings),
        );
      } else {
        AppSnackBar.show(context, strings.errorGeneric);
      }
    } catch (_) {
      if (mounted) {
        AppSnackBar.show(context, strings.errorGeneric);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final horizontalPadding =
        ProfileDesignSpec.px(context, ProfileDesignSpec.horizontalPadding);
    final theme = ProfileTheme.of(context);

    return Scaffold(
      backgroundColor: theme.screenBackground,
      appBar: ProfileAppBarWidget(
        onBack: () => Navigator.of(context).pop(),
        title: AppStrings.profileWalletSection(strings),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          horizontalPadding,
          ProfileDesignSpec.px(context, 12),
          horizontalPadding,
          MediaQuery.paddingOf(context).bottom + 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProfileWalletSectionWidget(
              cards: cards,
              isLoading: isLoadingCards,
              showFullList: true,
              compactHeader: true,
              onCardTap: handleCardTap,
              onAddCardTap: handleAddCard,
            ),
            SizedBox(height: ProfileDesignSpec.px(context, 24)),
            ProfileWalletBalanceSectionWidget(balance: balance),
            SizedBox(height: ProfileDesignSpec.px(context, 24)),
            ProfileWalletTransactionsSectionWidget(
              transactions: transactions,
              isLoading: isLoadingTransactions,
            ),
          ],
        ),
      ),
    );
  }
}
