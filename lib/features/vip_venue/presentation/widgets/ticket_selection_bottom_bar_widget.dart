import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/vip_venue/domain/entities/vip_purchase_session.dart';
import 'package:youpass/features/vip_venue/presentation/utils/vip_currency_formatter.dart';
import 'package:youpass/features/vip_venue/presentation/vip_venue_design_spec.dart';
import 'package:youpass/features/vip_venue/presentation/vip_venue_screen_theme.dart';
import 'package:youpass/features/vip_venue/presentation/widgets/vip_navigation_widgets.dart';
import 'package:youpass/features/vip_venue/presentation/widgets/vip_primary_button_widget.dart';
import 'package:youpass/features/vip_venue/presentation/widgets/vip_purchase_widgets.dart';

class TicketSelectionBottomBarWidget extends StatelessWidget {
  const TicketSelectionBottomBarWidget({
    super.key,
    required this.session,
    required this.onSummaryTap,
    required this.onContinue,
  });

  final VipPurchaseSession session;
  final VoidCallback onSummaryTap;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final padding = VipVenueDesignSpec.px(context, VipVenueDesignSpec.horizontalPadding);
    final ticketCountLabel = AppStrings.vipTicketCount(strings, session.selectedTicketCount);
    final summaryAmount = VipCurrencyFormatter.formatClpCompact(
      context,
      session.generalTicketsTotal,
    );
    final canContinue = session.hasSelectedTickets;

    return Container(
      decoration: BoxDecoration(
        color: VipVenueScreenTheme.screenBackground(context),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(padding, VipVenueDesignSpec.px(context, 12), padding, padding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          VipTicketSelectionSummaryRowWidget(
            title: AppStrings.vipPurchaseSummaryTitle(strings),
            summaryLine: AppStrings.vipTicketSelectionSummaryLine(
              strings,
              ticketCountLabel,
              summaryAmount,
            ),
            onTap: onSummaryTap,
            enabled: canContinue,
          ),
          SizedBox(height: VipVenueDesignSpec.px(context, 10)),
          VipPrimaryButtonWidget(
            label: AppStrings.vipContinueWithTickets(strings, ticketCountLabel),
            onPressed: canContinue ? onContinue : null,
            trailingIcon: Icons.arrow_forward_rounded,
          ),
          SizedBox(height: VipVenueDesignSpec.px(context, 10)),
          VipSecurePaymentFooterWidget(
            label: AppStrings.vipSecurePayment(strings),
          ),
        ],
      ),
    );
  }
}
