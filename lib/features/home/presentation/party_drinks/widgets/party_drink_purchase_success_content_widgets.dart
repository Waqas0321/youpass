import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/theme/qr_screen_theme.dart';
import 'package:youpass/core/widgets/qr/youpass_qr_code_card_widget.dart';
import 'package:youpass/core/widgets/qr/youpass_qr_success_badge_widget.dart';
import 'package:youpass/features/home/presentation/party_drinks/party_drinks_design_spec.dart';
import 'package:youpass/features/home/presentation/party_drinks/utils/party_drink_purchase_confirmation_factory.dart';

class PartyDrinkPurchaseSuccessHeaderWidget extends StatelessWidget {
  const PartyDrinkPurchaseSuccessHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return Column(
      children: [
        const YouPassQrSuccessBadgeWidget(),
        SizedBox(height: PartyDrinksDesignSpec.px(context, 20)),
        Text(
          AppStrings.partyDrinkPurchaseSuccessTitle(strings),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: PartyDrinksDesignSpec.px(context, 22),
            fontWeight: FontWeight.w800,
            color: QrScreenTheme.headline(context),
            height: 1.2,
          ),
        ),
        SizedBox(height: PartyDrinksDesignSpec.px(context, 10)),
        Text(
          AppStrings.partyDrinkPurchaseSuccessSubtitle(strings),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: PartyDrinksDesignSpec.px(context, 14),
            color: QrScreenTheme.subtitle(context),
            height: 1.45,
          ),
        ),
      ],
    );
  }
}

class PartyDrinkPurchaseSuccessFooterWidget extends StatelessWidget {
  const PartyDrinkPurchaseSuccessFooterWidget({
    super.key,
    required this.confirmation,
  });

  final PartyDrinkPurchaseConfirmation confirmation;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return Column(
      children: [
        Text(
          AppStrings.partyDrinkPurchaseValidity(strings, confirmation.validityTarget),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: PartyDrinksDesignSpec.px(context, 14),
            color: QrScreenTheme.footer(context),
            height: 1.45,
          ),
        ),
        SizedBox(height: PartyDrinksDesignSpec.px(context, 8)),
        Text(
          AppStrings.partyDrinkPurchaseShowBartender(strings),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: PartyDrinksDesignSpec.px(context, 14),
            color: QrScreenTheme.footer(context),
            height: 1.45,
          ),
        ),
      ],
    );
  }
}

class PartyDrinkPurchaseSuccessQrSectionWidget extends StatelessWidget {
  const PartyDrinkPurchaseSuccessQrSectionWidget({
    super.key,
    required this.confirmation,
  });

  final PartyDrinkPurchaseConfirmation confirmation;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return YouPassQrCodeCardWidget(
      qrPayload: confirmation.qrPayload,
      entryCode: confirmation.entryCode,
      manualIdLabel: AppStrings.eventTicketManualIdLabel(strings),
    );
  }
}
