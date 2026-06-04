import 'package:youpass/features/invitations/domain/entities/invitation_entity.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_ticket_entity.dart';
import 'package:youpass/features/invitations/domain/entities/invitations_summary_entity.dart';
import 'package:youpass/features/invitations/domain/entities/payment_method_request_entity.dart';

abstract class InvitationsRemoteDataSource {
  Future<List<InvitationEntity>> fetchInvitations();

  Future<InvitationsSummaryEntity> fetchSummary();

  Future<bool> hasSavedPaymentMethods();

  Future<InvitationEntity> fetchInvitationDetail(String invitationId);

  Future<InvitationEntity> confirmInvitation(String invitationId);

  Future<InvitationEntity> rejectInvitation(String invitationId);

  Future<InvitationTicketEntity> fetchTicket(String invitationId);

  Future<void> savePaymentMethod(PaymentMethodRequestEntity request);
}
