import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/widgets/qr/youpass_qr_code_card_widget.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_ticket_entity.dart';

class EventTicketQrSectionWidget extends StatelessWidget {
  const EventTicketQrSectionWidget({
    super.key,
    required this.ticket,
  });

  final InvitationTicketEntity ticket;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return YouPassQrCodeCardWidget(
      qrPayload: ticket.qrPayload,
      entryCode: ticket.entryCode,
      manualIdLabel: AppStrings.eventTicketManualIdLabel(strings),
    );
  }
}
