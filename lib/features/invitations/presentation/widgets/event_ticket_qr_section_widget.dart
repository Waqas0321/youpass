import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_ticket_entity.dart';
import 'package:youpass/features/invitations/presentation/invitations_design_spec.dart';

class EventTicketQrSectionWidget extends StatelessWidget {
  const EventTicketQrSectionWidget({
    super.key,
    required this.ticket,
  });

  final InvitationTicketEntity ticket;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return Column(
      children: [
        Center(
          child: Container(
            padding: EdgeInsets.all(InvitationsDesignSpec.px(context, 16)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                InvitationsDesignSpec.px(context, 12),
              ),
              border: Border.all(
                color: InvitationsDesignSpec.primary,
                width: 2,
              ),
            ),
            child: QrImageView(
              data: ticket.qrPayload,
              version: QrVersions.auto,
              size: InvitationsDesignSpec.px(context, 200),
              backgroundColor: Colors.white,
            ),
          ),
        ),
        SizedBox(height: InvitationsDesignSpec.px(context, 16)),
        Text(
          AppStrings.eventTicketManualIdLabel(strings),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: InvitationsDesignSpec.px(context, 13),
            color: InvitationsDesignSpec.bodyText,
          ),
        ),
        SizedBox(height: InvitationsDesignSpec.px(context, 4)),
        Text(
          ticket.entryCode,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: InvitationsDesignSpec.px(context, 22),
            fontWeight: FontWeight.w700,
            color: InvitationsDesignSpec.primary,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }
}
