import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/theme/qr_screen_theme.dart';
import 'package:youpass/core/widgets/qr/youpass_qr_success_badge_widget.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';

class EventTicketReadyHeaderWidget extends StatelessWidget {
  const EventTicketReadyHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return Column(
      children: [
        const YouPassQrSuccessBadgeWidget(),
        SizedBox(height: InvitationsDesignSpec.px(context, 20)),
        Text(
          AppStrings.eventTicketReadyTitle(strings),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: InvitationsDesignSpec.px(context, 22),
            fontWeight: FontWeight.w700,
            color: QrScreenTheme.headline(context),
            height: 1.2,
          ),
        ),
        SizedBox(height: InvitationsDesignSpec.px(context, 10)),
        Text(
          AppStrings.eventTicketReadySubtitle(strings),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: InvitationsDesignSpec.px(context, 14),
            color: QrScreenTheme.subtitle(context),
            height: 1.45,
          ),
        ),
      ],
    );
  }
}
