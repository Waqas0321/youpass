import 'package:youpass/core/network/api_endpoints.dart';
import 'package:youpass/core/network/base_api_service.dart';
import 'package:youpass/features/ticket_assignment/data/models/assign_ticket_guest_models.dart';
import 'package:youpass/features/ticket_assignment/data/models/event_checkout_models.dart';
import 'package:youpass/features/ticket_assignment/data/models/invitation_claim_model.dart';
import 'package:youpass/features/ticket_assignment/data/models/ticket_order_assignments_model.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/assign_ticket_guest_request_entity.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/event_checkout_request_entity.dart';

class TicketAssignmentApiService extends BaseApiService {
  TicketAssignmentApiService(super.apiClient);

  Future<EventCheckoutResultModel> checkoutEvent(
    String eventId,
    EventCheckoutRequestEntity request,
  ) {
    final body = EventCheckoutRequestModel(
      quantity: request.quantity,
      tier: request.tier,
      type: request.type,
      paymentMethodId: request.paymentMethodId,
      offeringId: request.offeringId,
      items: request.items,
      tableId: request.tableId,
      zoneId: request.zoneId,
    );

    return postModel(
      ApiEndpoints.eventCheckout(eventId),
      body: body.toJson(),
      fromJson: EventCheckoutResultModel.fromJson,
      authenticated: true,
    );
  }

  Future<TicketOrderAssignmentsModel> fetchAssignmentsByOrder(String orderId) {
    return getModel(
      ApiEndpoints.ticketOrderAssignments(orderId),
      fromJson: TicketOrderAssignmentsModel.fromJson,
      authenticated: true,
    );
  }

  Future<TicketOrderAssignmentsModel> fetchAssignmentsByTicket(String ticketId) {
    return getModel(
      ApiEndpoints.ticketAssignments(ticketId),
      fromJson: TicketOrderAssignmentsModel.fromJson,
      authenticated: true,
    );
  }

  Future<TicketOrderAssignmentsModel> fetchAssignments(String orderId) {
    return fetchAssignmentsByOrder(orderId);
  }

  Future<AssignTicketGuestResultModel> assignGuest(
    String orderId,
    String slotId,
    AssignTicketGuestRequestEntity request,
  ) {
    final body = AssignTicketGuestRequestModel(
      guestName: request.guestName,
      guestPhone: request.guestPhone,
      countryCode: request.countryCode,
    );

    return postModel(
      ApiEndpoints.assignTicketSlot(orderId, slotId),
      body: body.toJson(),
      fromJson: AssignTicketGuestResultModel.fromJson,
      authenticated: true,
    );
  }

  Future<AssignTicketGuestResultModel> cancelAssignment(
    String orderId,
    String slotId,
  ) {
    return deleteModel(
      ApiEndpoints.cancelTicketAssignment(orderId, slotId),
      fromJson: AssignTicketGuestResultModel.fromJson,
      authenticated: true,
    );
  }

  Future<AssignTicketGuestResultModel> resendAssignment(
    String orderId,
    String slotId,
  ) {
    return postModel(
      ApiEndpoints.resendTicketAssignment(orderId, slotId),
      body: const <String, dynamic>{},
      fromJson: AssignTicketGuestResultModel.fromJson,
      authenticated: true,
    );
  }

  Future<InvitationClaimModel> fetchInvitationClaim(String token) {
    return getModel(
      ApiEndpoints.invitationClaim(token),
      fromJson: InvitationClaimModel.fromJson,
      authenticated: false,
    );
  }

  Future<T> deleteModel<T>(
    String endpoint, {
    required T Function(Map<String, dynamic> json) fromJson,
    bool authenticated = false,
    String? accessTokenOverride,
  }) async {
    final data = await deleteData(
      endpoint,
      authenticated: authenticated,
      accessTokenOverride: accessTokenOverride,
    );
    return fromJson(data);
  }
}
