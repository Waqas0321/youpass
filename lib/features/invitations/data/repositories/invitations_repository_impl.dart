import 'package:youpass/features/invitations/data/datasources/invitations_remote_datasource.dart';
import 'package:youpass/features/invitations/domain/entities/confirm_invitation_params.dart';
import 'package:youpass/features/invitations/domain/entities/invitations_feed_entity.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_entity.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_ticket_entity.dart';
import 'package:youpass/features/invitations/domain/entities/invitations_summary_entity.dart';
import 'package:youpass/features/invitations/domain/entities/payment_method_request_entity.dart';
import 'package:youpass/features/invitations/domain/repositories/invitations_repository.dart';

class InvitationsRepositoryImpl implements InvitationsRepository {
  InvitationsRepositoryImpl(this.remoteDataSource);

  final InvitationsRemoteDataSource remoteDataSource;

  @override
  Future<InvitationsFeedEntity> fetchInvitationsFeed() {
    return remoteDataSource.fetchInvitationsFeed();
  }

  @override
  Future<List<InvitationEntity>> fetchInvitations() {
    return remoteDataSource.fetchInvitations();
  }

  @override
  Future<InvitationsSummaryEntity> fetchSummary() {
    return remoteDataSource.fetchSummary();
  }

  @override
  Future<bool> hasSavedPaymentMethods() {
    return remoteDataSource.hasSavedPaymentMethods();
  }

  @override
  Future<InvitationEntity> fetchInvitationDetail(String invitationId) {
    return remoteDataSource.fetchInvitationDetail(invitationId);
  }

  @override
  Future<InvitationEntity> confirmInvitation(
    String invitationId, {
    ConfirmInvitationParams params = const ConfirmInvitationParams(),
  }) {
    return remoteDataSource.confirmInvitation(invitationId, params: params);
  }

  @override
  Future<void> rejectInvitation(String invitationId) {
    return remoteDataSource.rejectInvitation(invitationId);
  }

  @override
  Future<void> cancelInvitation(String invitationId) {
    return remoteDataSource.cancelInvitation(invitationId);
  }

  @override
  Future<InvitationTicketEntity> fetchTicket(String invitationId) {
    return remoteDataSource.fetchTicket(invitationId);
  }

  @override
  Future<void> savePaymentMethod(PaymentMethodRequestEntity request) {
    return remoteDataSource.savePaymentMethod(request);
  }

  @override
  Future<Map<String, dynamic>> fetchWaitlistJoinPreview(String eventId) {
    return remoteDataSource.fetchWaitlistJoinPreview(eventId);
  }

  @override
  Future<Map<String, dynamic>> joinWaitlist(String eventId) {
    return remoteDataSource.joinWaitlist(eventId);
  }

  @override
  Future<void> leaveWaitlist(String eventId) {
    return remoteDataSource.leaveWaitlist(eventId);
  }

  @override
  Future<InvitationEntity> claimWaitlistOffer(String offerId) {
    return remoteDataSource.claimWaitlistOffer(offerId);
  }
}
