import 'package:youpass/core/constants/app_assets.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/features/invitations/data/models/invitation_model.dart';
import 'package:youpass/features/invitations/data/models/invitation_ticket_model.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_qr_status.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_status.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_tier.dart';
import 'package:youpass/l10n/app_localizations.dart';

class InvitationsMockData {
  InvitationsMockData._();

  static const String youfestId = 'inv-youfest-2026';
  static const String festivalVeranoId = 'inv-festival-verano-2026';

  static String? _localeName;
  static List<InvitationModel> _invitations = [];

  static List<InvitationModel> invitationsFor(AppLocalizations l10n) {
    if (_localeName != l10n.localeName) {
      _localeName = l10n.localeName;
      _invitations = _buildInitial(l10n);
    }
    return _invitations;
  }

  static List<InvitationModel> _buildInitial(AppLocalizations l10n) => [
        InvitationModel(
          id: youfestId,
          eventTitle: AppStrings.mockEventYoufest2026(l10n),
          locationLabel: AppStrings.mockLocationCentroEventosHilaria(l10n),
          dateTimeLabel: AppStrings.mockDateSaturdayJuly4(l10n),
          imageAssetPath: AppAssets.dummyImage,
          tier: InvitationTier.vip,
          type: 'courtesy',
          status: InvitationStatus.pending,
          requiresPaymentMethod: true,
          qrStatus: InvitationQrStatus.locked,
        ),
        InvitationModel(
          id: 'inv-concierto-x',
          eventTitle: AppStrings.mockEventConciertoX(l10n),
          locationLabel: AppStrings.mockLocationMovistarArena(l10n),
          dateTimeLabel: AppStrings.mockDateSaturdayMay15(l10n),
          imageAssetPath: AppAssets.dummyImage,
          tier: InvitationTier.general,
          status: InvitationStatus.pending,
          qrStatus: InvitationQrStatus.locked,
        ),
        InvitationModel(
          id: festivalVeranoId,
          eventTitle: AppStrings.mockEventYoufest2026(l10n),
          locationLabel: AppStrings.mockLocationClubAmanda(l10n),
          dateTimeLabel: AppStrings.mockDateSaturdayMay15Long(l10n),
          imageAssetPath: AppAssets.dummyImage,
          tier: InvitationTier.vip,
          status: InvitationStatus.confirmed,
          entryCode: '8F7A2B',
          qrPayload: 'YOUPASS-TICKET-8F7A2B',
          qrStatus: InvitationQrStatus.available,
        ),
      ];

  static InvitationModel confirm(String invitationId, AppLocalizations l10n) {
    final invitations = invitationsFor(l10n);
    _invitations = invitations
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

    return _invitations.firstWhere((item) => item.id == invitationId);
  }

  static InvitationModel reject(String invitationId, AppLocalizations l10n) {
    final invitations = invitationsFor(l10n);
    _invitations = invitations
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

    return _invitations.firstWhere((item) => item.id == invitationId);
  }

  static InvitationTicketModel ticketFor(
    String invitationId,
    AppLocalizations l10n,
  ) {
    final invitation =
        invitationsFor(l10n).firstWhere((item) => item.id == invitationId);
    return InvitationTicketModel(
      invitationId: invitationId,
      eventTitle: invitation.eventTitle,
      dateTimeLabel: invitation.dateTimeLabel,
      locationLabel: invitation.locationLabel,
      entryCode: invitation.entryCode ?? '8F7A2B',
      qrPayload: invitation.qrPayload ?? 'YOUPASS-TICKET-8F7A2B',
      seatLabel: invitation.tier == InvitationTier.vip
          ? AppStrings.mockSeatVipTable(l10n)
          : null,
    );
  }
}
