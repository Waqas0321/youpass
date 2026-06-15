import 'package:youpass/features/invitations/domain/entities/confirm_invitation_params.dart';
import 'package:youpass/features/invitations/domain/entities/invitations_feed_entity.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_entity.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_ticket_entity.dart';
import 'package:youpass/features/invitations/domain/entities/invitations_summary_entity.dart';
import 'package:youpass/features/invitations/domain/entities/payment_method_request_entity.dart';

abstract class InvitationsRemoteDataSource {
  Future<InvitationsFeedEntity> fetchInvitationsFeed();

  Future<List<InvitationEntity>> fetchInvitations();

  Future<InvitationsSummaryEntity> fetchSummary();

  Future<bool> hasSavedPaymentMethods();

  Future<InvitationEntity> fetchInvitationDetail(String invitationId);

  Future<InvitationEntity> confirmInvitation(
    String invitationId, {
    ConfirmInvitationParams params = const ConfirmInvitationParams(),
  });

  Future<void> rejectInvitation(String invitationId);

  Future<void> cancelInvitation(String invitationId);

  Future<InvitationTicketEntity> fetchTicket(String invitationId);

  Future<void> savePaymentMethod(PaymentMethodRequestEntity request);

  Future<Map<String, dynamic>> fetchWaitlistJoinPreview(String eventId);

  Future<Map<String, dynamic>> joinWaitlist(String eventId);

  Future<void> leaveWaitlist(String eventId);

  Future<InvitationEntity> claimWaitlistOffer(String offerId);
}
