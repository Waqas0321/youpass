import 'package:youpass/features/ticket_assignment/domain/entities/assign_ticket_guest_request_entity.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/assign_ticket_guest_result_entity.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/event_checkout_request_entity.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/event_checkout_result_entity.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/invitation_claim_entity.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/ticket_order_assignments_entity.dart';

abstract class TicketAssignmentRepository {
  Future<EventCheckoutResultEntity> checkoutEvent(
    String eventId,
    EventCheckoutRequestEntity request,
  );

  Future<TicketOrderAssignmentsEntity> fetchAssignments({
    String? orderId,
    String? ticketId,
  });

  Future<AssignTicketGuestResultEntity> assignGuest(
    String orderId,
    String slotId,
    AssignTicketGuestRequestEntity request,
  );

  Future<AssignTicketGuestResultEntity> cancelAssignment(
    String orderId,
    String slotId,
  );

  Future<AssignTicketGuestResultEntity> resendAssignment(
    String orderId,
    String slotId,
  );

  Future<InvitationClaimEntity> fetchInvitationClaim(String token);
}
