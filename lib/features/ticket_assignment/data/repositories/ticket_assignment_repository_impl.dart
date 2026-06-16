import 'package:youpass/features/ticket_assignment/data/datasources/ticket_assignment_remote_datasource.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/assign_guest_lookup_entity.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/assign_ticket_guest_request_entity.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/assign_ticket_guest_result_entity.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/event_checkout_request_entity.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/event_checkout_result_entity.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/invitation_claim_entity.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/ticket_order_assignments_entity.dart';
import 'package:youpass/features/ticket_assignment/domain/repositories/ticket_assignment_repository.dart';

class TicketAssignmentRepositoryImpl implements TicketAssignmentRepository {
  TicketAssignmentRepositoryImpl(this.remoteDataSource);

  final TicketAssignmentRemoteDataSource remoteDataSource;

  @override
  Future<EventCheckoutResultEntity> checkoutEvent(
    String eventId,
    EventCheckoutRequestEntity request,
  ) {
    return remoteDataSource.checkoutEvent(eventId, request);
  }

  @override
  Future<TicketOrderAssignmentsEntity> fetchAssignments({
    String? orderId,
    String? ticketId,
  }) {
    return remoteDataSource.fetchAssignments(
      orderId: orderId,
      ticketId: ticketId,
    );
  }

  @override
  Future<List<AssignGuestLookupEntity>> lookupAssignGuests(String query) {
    return remoteDataSource.lookupAssignGuests(query);
  }

  @override
  Future<AssignTicketGuestResultEntity> assignGuest(
    String orderId,
    String slotId,
    AssignTicketGuestRequestEntity request,
  ) {
    return remoteDataSource.assignGuest(orderId, slotId, request);
  }

  @override
  Future<AssignTicketGuestResultEntity> cancelAssignment(
    String orderId,
    String slotId,
  ) {
    return remoteDataSource.cancelAssignment(orderId, slotId);
  }

  @override
  Future<AssignTicketGuestResultEntity> resendAssignment(
    String orderId,
    String slotId,
  ) {
    return remoteDataSource.resendAssignment(orderId, slotId);
  }

  @override
  Future<InvitationClaimEntity> fetchInvitationClaim(String token) {
    return remoteDataSource.fetchInvitationClaim(token);
  }
}
