import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_ticket_entity.dart';
import 'package:youpass/features/vip_venue/data/vip_venue_mock_data.dart';
import 'package:youpass/features/vip_venue/domain/entities/ticket_offering_entity.dart';
import 'package:youpass/features/vip_venue/domain/entities/vip_purchase_session.dart';
import 'package:youpass/l10n/app_localizations.dart';

class VipPurchaseLabelHelper {
  VipPurchaseLabelHelper._();

  static String ticketDetailsLine(
    AppLocalizations l10n,
    TicketOfferingEntity offering,
  ) {
    return AppStrings.vipPurchaseTicketDetailsLine(
      l10n,
      AppStrings.vipTicketCount(l10n, offering.quantity),
      AppStrings.vipGeneralAccessLabel(l10n),
      AppStrings.vipVoucherCount(l10n, offering.totalVouchers),
    );
  }

  static String? ticketSeatLabel(
    AppLocalizations l10n,
    VipPurchaseSession session,
  ) {
    if (session.isVipTablePurchase) {
      return session.seatLabel;
    }

    final selected = session.selectedOfferings;
    if (selected.isEmpty) {
      return null;
    }

    if (selected.length == 1) {
      final offering = selected.first;
      return '${offering.label} | ${AppStrings.vipTicketCount(l10n, offering.quantity)}';
    }

    return AppStrings.vipTicketCount(l10n, session.selectedTicketCount);
  }

  static InvitationTicketEntity buildFallbackTicket(
    AppLocalizations l10n,
    VipPurchaseSession session, {
    String? seatLabel,
  }) {
    return InvitationTicketEntity(
      invitationId: 'vip-${session.event.id}',
      eventTitle: session.event.title,
      dateTimeLabel: session.event.dateTimeLabel,
      locationLabel: session.event.locationLabel,
      entryCode: VipVenueMockData.mockEntryCode,
      qrPayload: 'youpass://ticket/${session.event.id}',
      seatLabel: seatLabel ?? ticketSeatLabel(l10n, session),
    );
  }
}
