import 'package:youpass/features/invitations/domain/entities/invitation_entity.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_ticket_entity.dart';
import 'package:youpass/features/invitations/domain/entities/payment_method_request_entity.dart';

abstract class InvitationsRepository {
  Future<List<InvitationEntity>> fetchInvitations();

  Future<InvitationEntity> confirmInvitation(String invitationId);

  Future<InvitationEntity> rejectInvitation(String invitationId);

  Future<InvitationTicketEntity> fetchTicket(String invitationId);

  Future<void> savePaymentMethod(PaymentMethodRequestEntity request);
}
