import 'package:flutter/foundation.dart';
import 'package:youpass/core/network/api_exception.dart';
import 'package:youpass/core/network/models/api_error_details_model.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/assign_ticket_guest_request_entity.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/event_checkout_request_entity.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/event_checkout_result_entity.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/invitation_claim_entity.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/ticket_order_assignments_entity.dart';
import 'package:youpass/features/ticket_assignment/domain/usecases/assign_ticket_guest_usecase.dart';
import 'package:youpass/features/ticket_assignment/domain/usecases/cancel_ticket_assignment_usecase.dart';
import 'package:youpass/features/ticket_assignment/domain/usecases/checkout_event_tickets_usecase.dart';
import 'package:youpass/features/ticket_assignment/domain/usecases/fetch_invitation_claim_usecase.dart';
import 'package:youpass/features/ticket_assignment/domain/usecases/fetch_ticket_order_assignments_usecase.dart';
import 'package:youpass/features/ticket_assignment/domain/usecases/resend_ticket_assignment_usecase.dart';
import 'package:youpass/features/ticket_assignment/presentation/providers/ticket_assignment_action.dart';
import 'package:youpass/features/ticket_assignment/presentation/providers/ticket_assignment_load_status.dart';

class TicketAssignmentProvider extends ChangeNotifier {
  TicketAssignmentProvider({
    required this.checkoutEventTicketsUseCase,
    required this.fetchTicketOrderAssignmentsUseCase,
    required this.assignTicketGuestUseCase,
    required this.cancelTicketAssignmentUseCase,
    required this.resendTicketAssignmentUseCase,
    required this.fetchInvitationClaimUseCase,
  });

  final CheckoutEventTicketsUseCase checkoutEventTicketsUseCase;
  final FetchTicketOrderAssignmentsUseCase fetchTicketOrderAssignmentsUseCase;
  final AssignTicketGuestUseCase assignTicketGuestUseCase;
  final CancelTicketAssignmentUseCase cancelTicketAssignmentUseCase;
  final ResendTicketAssignmentUseCase resendTicketAssignmentUseCase;
  final FetchInvitationClaimUseCase fetchInvitationClaimUseCase;

  TicketAssignmentLoadStatus loadStatus = TicketAssignmentLoadStatus.initial;
  TicketAssignmentLoadStatus claimStatus = TicketAssignmentLoadStatus.initial;
  TicketOrderAssignmentsEntity? assignments;
  InvitationClaimEntity? claim;
  String? errorMessage;
  String? errorCode;
  ApiErrorDetailsModel? errorDetails;
  String? loadingSlotId;
  TicketAssignmentAction? loadingAction;
  bool isCheckoutSubmitting = false;

  Future<EventCheckoutResultEntity?> checkoutEvent({
    required String eventId,
    required int quantity,
    required String tier,
    String type = 'general',
    String? paymentMethodId,
  }) async {
    isCheckoutSubmitting = true;
    errorMessage = null;
    errorCode = null;
    notifyListeners();

    try {
      return await checkoutEventTicketsUseCase(
        eventId: eventId,
        request: EventCheckoutRequestEntity(
          quantity: quantity,
          tier: tier,
          type: type,
          paymentMethodId: paymentMethodId,
        ),
      );
    } on ApiException catch (error) {
      errorCode = error.code;
      errorMessage = error.message;
      return null;
    } catch (error) {
      errorMessage = error.toString();
      return null;
    } finally {
      isCheckoutSubmitting = false;
      notifyListeners();
    }
  }

  String? _lastOrderId;
  String? _lastTicketId;

  Future<void> loadAssignments({
    String? orderId,
    String? ticketId,
  }) async {
    _lastOrderId = orderId?.trim().isEmpty == true ? null : orderId?.trim();
    _lastTicketId = ticketId?.trim().isEmpty == true ? null : ticketId?.trim();

    loadStatus = TicketAssignmentLoadStatus.loading;
    errorMessage = null;
    errorCode = null;
    assignments = null;
    notifyListeners();

    try {
      assignments = await fetchTicketOrderAssignmentsUseCase(
        orderId: _lastOrderId,
        ticketId: _lastTicketId,
      );
      loadStatus = TicketAssignmentLoadStatus.ready;
    } on ApiException catch (error) {
      loadStatus = TicketAssignmentLoadStatus.error;
      errorCode = error.code;
      errorMessage = error.message;
    } catch (error) {
      loadStatus = TicketAssignmentLoadStatus.error;
      errorMessage = error.toString();
    }

    notifyListeners();
  }

  Future<void> refreshAssignments({String? orderId}) async {
    final resolvedOrderId = orderId?.trim().isEmpty == true
        ? null
        : orderId?.trim() ?? _lastOrderId;

    try {
      assignments = await fetchTicketOrderAssignmentsUseCase(
        orderId: resolvedOrderId,
        ticketId: _lastTicketId,
      );
      loadStatus = TicketAssignmentLoadStatus.ready;
      errorMessage = null;
      errorCode = null;
    } on ApiException catch (error) {
      errorCode = error.code;
      errorMessage = error.message;
    } catch (error) {
      errorMessage = error.toString();
    }

    notifyListeners();
  }

  String? get resolvedOrderId {
    final value = assignments?.orderId.trim();
    if (value == null || value.isEmpty) {
      return null;
    }
    return value;
  }

  Future<bool> assignGuest({
    required String orderId,
    required String slotId,
    required AssignTicketGuestRequestEntity request,
  }) async {
    beginSlotAction(slotId, TicketAssignmentAction.assign);

    try {
      await assignTicketGuestUseCase(
        orderId: orderId,
        slotId: slotId,
        request: request,
      );
      await refreshAssignments(orderId: orderId);
      return true;
    } on ApiException catch (error) {
      errorCode = error.code;
      errorMessage = error.message;
      errorDetails = ApiErrorDetailsModel.fromMap(error.details);
      return false;
    } catch (error) {
      errorMessage = error.toString();
      return false;
    } finally {
      endSlotAction();
    }
  }

  Future<bool> cancelAssignment({
    required String orderId,
    required String slotId,
  }) async {
    beginSlotAction(slotId, TicketAssignmentAction.cancel);

    try {
      await cancelTicketAssignmentUseCase(
        orderId: orderId,
        slotId: slotId,
      );
      await refreshAssignments(orderId: orderId);
      return true;
    } on ApiException catch (error) {
      errorCode = error.code;
      errorMessage = error.message;
      return false;
    } catch (error) {
      errorMessage = error.toString();
      return false;
    } finally {
      endSlotAction();
    }
  }

  Future<bool> resendAssignment({
    required String orderId,
    required String slotId,
  }) async {
    beginSlotAction(slotId, TicketAssignmentAction.resend);

    try {
      await resendTicketAssignmentUseCase(
        orderId: orderId,
        slotId: slotId,
      );
      await refreshAssignments(orderId: orderId);
      return true;
    } on ApiException catch (error) {
      errorCode = error.code;
      errorMessage = error.message;
      return false;
    } catch (error) {
      errorMessage = error.toString();
      return false;
    } finally {
      endSlotAction();
    }
  }

  Future<void> loadClaim(String token) async {
    claimStatus = TicketAssignmentLoadStatus.loading;
    errorMessage = null;
    errorCode = null;
    notifyListeners();

    try {
      claim = await fetchInvitationClaimUseCase(token);
      claimStatus = TicketAssignmentLoadStatus.ready;
    } on ApiException catch (error) {
      claimStatus = TicketAssignmentLoadStatus.error;
      errorCode = error.code;
      errorMessage = error.message;
    } catch (error) {
      claimStatus = TicketAssignmentLoadStatus.error;
      errorMessage = error.toString();
    }

    notifyListeners();
  }

  bool isSlotLoading(String slotId, TicketAssignmentAction action) {
    return loadingSlotId == slotId && loadingAction == action;
  }

  void beginSlotAction(String slotId, TicketAssignmentAction action) {
    loadingSlotId = slotId;
    loadingAction = action;
    errorMessage = null;
    errorCode = null;
    notifyListeners();
  }

  void endSlotAction() {
    loadingSlotId = null;
    loadingAction = null;
    notifyListeners();
  }
}
