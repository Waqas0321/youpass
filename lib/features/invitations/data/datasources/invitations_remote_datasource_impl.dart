import 'package:youpass/core/constants/app_constants.dart';
import 'package:youpass/core/locale/locale_provider.dart';
import 'package:youpass/features/invitations/data/datasources/invitations_mock_data.dart';
import 'package:youpass/features/invitations/data/datasources/invitations_remote_datasource.dart';
import 'package:youpass/features/invitations/data/services/invitations_api_service.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_entity.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_ticket_entity.dart';
import 'package:youpass/features/invitations/domain/entities/invitations_summary_entity.dart';
import 'package:youpass/features/invitations/domain/entities/payment_method_request_entity.dart';
import 'package:youpass/l10n/app_localizations.dart';

class InvitationsRemoteDataSourceImpl implements InvitationsRemoteDataSource {
  InvitationsRemoteDataSourceImpl({
    required this.apiService,
    required this.localeProvider,
  });

  final InvitationsApiService apiService;
  final LocaleProvider localeProvider;

  AppLocalizations get _l10n => lookupAppLocalizations(localeProvider.locale);

  @override
  Future<List<InvitationEntity>> fetchInvitations() async {
    if (AppConstants.useInvitationsMockData) {
      return List<InvitationEntity>.from(
        InvitationsMockData.invitationsFor(_l10n),
      );
    }

    return apiService.fetchInvitations();
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
  Future<InvitationEntity> confirmInvitation(String invitationId) async {
    if (AppConstants.useInvitationsMockData) {
      return InvitationsMockData.confirm(invitationId, _l10n);
    }

    return apiService.confirmInvitation(invitationId);
  }

  @override
  Future<InvitationEntity> rejectInvitation(String invitationId) async {
    if (AppConstants.useInvitationsMockData) {
      return InvitationsMockData.reject(invitationId, _l10n);
    }

    return apiService.rejectInvitation(invitationId);
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
}
