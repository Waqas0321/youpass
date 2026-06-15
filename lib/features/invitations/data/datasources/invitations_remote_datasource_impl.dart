import 'package:youpass/core/constants/app_constants.dart';
import 'package:youpass/core/locale/locale_provider.dart';
import 'package:youpass/features/invitations/data/datasources/invitations_mock_data.dart';
import 'package:youpass/features/invitations/data/datasources/invitations_remote_datasource.dart';
import 'package:youpass/features/invitations/data/services/invitations_api_service.dart';
import 'package:youpass/features/waitlist/data/services/waitlist_api_service.dart';
import 'package:youpass/features/invitations/domain/entities/confirm_invitation_params.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_entity.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_ticket_entity.dart';
import 'package:youpass/features/invitations/domain/entities/invitations_feed_entity.dart';
import 'package:youpass/features/invitations/domain/entities/invitations_summary_entity.dart';
import 'package:youpass/features/invitations/domain/entities/payment_method_request_entity.dart';
import 'package:youpass/l10n/app_localizations.dart';

class InvitationsRemoteDataSourceImpl implements InvitationsRemoteDataSource {
  InvitationsRemoteDataSourceImpl({
    required this.apiService,
    required this.waitlistApiService,
    required this.localeProvider,
  });

  final InvitationsApiService apiService;
  final WaitlistApiService waitlistApiService;
  final LocaleProvider localeProvider;

  AppLocalizations get _l10n => lookupAppLocalizations(localeProvider.locale);

  @override
  Future<InvitationsFeedEntity> fetchInvitationsFeed() async {
    if (AppConstants.useInvitationsMockData) {
      final invitations = List<InvitationEntity>.from(
        InvitationsMockData.invitationsFor(_l10n),
      );
      return InvitationsFeedEntity(
        invitations: invitations,
        waitlistEntries: const [],
      );
    }

    final response = await apiService.fetchInvitationsResponse();
    return InvitationsFeedEntity(
      invitations: response.invitations,
      waitlistEntries: response.waitlistEntries,
    );
  }

  @override
  Future<List<InvitationEntity>> fetchInvitations() async {
    final feed = await fetchInvitationsFeed();
    return feed.invitations;
  }

  @override
  Future<InvitationsSummaryEntity> fetchSummary() async {
    if (AppConstants.useInvitationsMockData) {
      final invitations = InvitationsMockData.invitationsFor(_l10n);
      final pending = invitations
          .where((item) => item.status.name == 'pending')
          .length;
      return InvitationsSummaryEntity(
        pendingCount: pending,
        newCount: pending,
        totalCount: invitations.length,
      );
    }

    return apiService.fetchSummary();
  }

  @override
  Future<bool> hasSavedPaymentMethods() async {
    if (AppConstants.useInvitationsMockData) {
      return false;
    }

    return apiService.hasSavedPaymentMethods();
  }

  @override
  Future<InvitationEntity> fetchInvitationDetail(String invitationId) async {
    if (AppConstants.useInvitationsMockData) {
      return InvitationsMockData.invitationsFor(_l10n)
          .firstWhere((item) => item.id == invitationId);
    }

    return apiService.fetchInvitationDetail(invitationId);
  }

  @override
  Future<InvitationEntity> confirmInvitation(
    String invitationId, {
    ConfirmInvitationParams params = const ConfirmInvitationParams(),
  }) async {
    if (AppConstants.useInvitationsMockData) {
      return InvitationsMockData.confirm(invitationId, _l10n);
    }

    return apiService.confirmInvitation(invitationId, params: params);
  }

  @override
  Future<void> rejectInvitation(String invitationId) async {
    if (AppConstants.useInvitationsMockData) {
      InvitationsMockData.reject(invitationId, _l10n);
      return;
    }

    await apiService.rejectInvitation(invitationId);
  }

  @override
  Future<void> cancelInvitation(String invitationId) async {
    if (AppConstants.useInvitationsMockData) {
      InvitationsMockData.reject(invitationId, _l10n);
      return;
    }

    await apiService.cancelInvitation(invitationId);
  }

  @override
  Future<InvitationTicketEntity> fetchTicket(String invitationId) async {
    if (AppConstants.useInvitationsMockData) {
      return InvitationsMockData.ticketFor(invitationId, _l10n);
    }

    return apiService.fetchTicket(invitationId);
  }

  @override
  Future<void> savePaymentMethod(PaymentMethodRequestEntity request) async {
    if (AppConstants.useInvitationsMockData) {
      return;
    }

    await apiService.savePaymentMethod(request);
  }

  @override
  Future<Map<String, dynamic>> fetchWaitlistJoinPreview(String eventId) {
    return waitlistApiService.fetchJoinPreview(eventId);
  }

  @override
  Future<Map<String, dynamic>> joinWaitlist(String eventId) {
    return waitlistApiService.join(eventId);
  }

  @override
  Future<void> leaveWaitlist(String eventId) {
    return waitlistApiService.leave(eventId);
  }

  @override
  Future<InvitationEntity> claimWaitlistOffer(String offerId) {
    return waitlistApiService.claimOffer(offerId);
  }
}
