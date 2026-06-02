import 'package:youpass/core/constants/app_assets.dart';
import 'package:youpass/features/invitations/data/models/invitation_model.dart';
import 'package:youpass/features/invitations/data/models/invitation_ticket_model.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_status.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_tier.dart';

class InvitationsMockData {
  InvitationsMockData._();

  static const String youfestId = 'inv-youfest-2026';
  static const String festivalVeranoId = 'inv-festival-verano-2026';

  static List<InvitationModel> invitations = [
    const InvitationModel(
      id: youfestId,
      eventTitle: 'YouFest 2026',
      locationLabel: 'Centro Eventos Hilaria',
      dateTimeLabel: 'Sáb 4 Julio · 22:00',
      imageAssetPath: AppAssets.dummyImage,
      tier: InvitationTier.vip,
      status: InvitationStatus.pending,
    ),
    const InvitationModel(
      id: 'inv-concierto-x',
      eventTitle: 'Concierto X',
      locationLabel: 'Movistar Arena',
      dateTimeLabel: 'Sábado 15 May · 22:00',
      imageAssetPath: AppAssets.dummyImage,
      tier: InvitationTier.general,
      status: InvitationStatus.pending,
    ),
    const InvitationModel(
      id: festivalVeranoId,
      eventTitle: 'Festival Verano 2026',
      locationLabel: 'Club Amanda',
      dateTimeLabel: 'Sábado 15 May · 22:00',
      imageAssetPath: AppAssets.dummyImage,
      tier: InvitationTier.vip,
      status: InvitationStatus.confirmed,
      entryCode: '8F7A2B',
      qrPayload: 'YOUPASS-TICKET-8F7A2B',
    ),
  ];

  static InvitationModel confirm(String invitationId) {
    invitations = invitations
        .map(
          (item) => item.id == invitationId
              ? InvitationModel(
                  id: item.id,
                  eventTitle: item.eventTitle,
                  locationLabel: item.locationLabel,
                  dateTimeLabel: item.dateTimeLabel,
                  imageAssetPath: item.imageAssetPath,
                  tier: item.tier,
                  status: InvitationStatus.confirmed,
                  entryCode: item.entryCode ?? '8F7A2B',
                  qrPayload: item.qrPayload ?? 'YOUPASS-TICKET-8F7A2B',
                )
              : item,
        )
        .toList();

    return invitations.firstWhere((item) => item.id == invitationId);
  }

  static InvitationModel reject(String invitationId) {
    invitations = invitations
        .map(
          (item) => item.id == invitationId
              ? InvitationModel(
                  id: item.id,
                  eventTitle: item.eventTitle,
                  locationLabel: item.locationLabel,
                  dateTimeLabel: item.dateTimeLabel,
                  imageAssetPath: item.imageAssetPath,
                  tier: item.tier,
                  status: InvitationStatus.rejected,
                )
              : item,
        )
        .toList();

    return invitations.firstWhere((item) => item.id == invitationId);
  }

  static InvitationTicketModel ticketFor(String invitationId) {
    final invitation = invitations.firstWhere((item) => item.id == invitationId);
    return InvitationTicketModel(
      invitationId: invitationId,
      eventTitle: invitation.eventTitle,
      dateTimeLabel: invitation.dateTimeLabel,
      locationLabel: invitation.locationLabel,
      entryCode: invitation.entryCode ?? '8F7A2B',
      qrPayload: invitation.qrPayload ?? 'YOUPASS-TICKET-8F7A2B',
    );
  }
}
