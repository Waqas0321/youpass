import 'package:youpass/core/constants/app_constants.dart';
import 'package:youpass/core/locale/locale_provider.dart';
import 'package:youpass/core/network/api_exception.dart';
import 'package:youpass/features/ticket_assignment/data/datasources/ticket_assignment_mock_data.dart';
import 'package:youpass/features/ticket_assignment/data/datasources/ticket_assignment_remote_datasource.dart';
import 'package:youpass/features/ticket_assignment/data/models/assign_guest_lookup_model.dart';
import 'package:youpass/features/ticket_assignment/data/models/assign_ticket_guest_models.dart';
import 'package:youpass/features/ticket_assignment/data/models/ticket_assignment_slot_model.dart';
import 'package:youpass/features/ticket_assignment/data/services/ticket_assignment_api_service.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/assign_guest_lookup_entity.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/assign_ticket_guest_request_entity.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/assign_ticket_guest_result_entity.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/event_checkout_request_entity.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/event_checkout_result_entity.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/invitation_claim_entity.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/ticket_order_assignments_entity.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/ticket_slot_status.dart';
import 'package:youpass/l10n/app_localizations.dart';

class TicketAssignmentRemoteDataSourceImpl
    implements TicketAssignmentRemoteDataSource {
  TicketAssignmentRemoteDataSourceImpl({
    required this.apiService,
    required this.localeProvider,
  });

  final TicketAssignmentApiService apiService;
  final LocaleProvider localeProvider;

  AppLocalizations get l10n => lookupAppLocalizations(localeProvider.locale);

  @override
  Future<EventCheckoutResultEntity> checkoutEvent(
    String eventId,
    EventCheckoutRequestEntity request,
  ) {
    if (AppConstants.useTicketsMockData) {
      final quantity = request.quantity ?? 1;
      return Future.value(
        EventCheckoutResultEntity(
          orderId: 'mock-order-$eventId',
          eventTitle: 'Mock Event',
          quantity: quantity,
          totalAmount: 0,
          currency: 'CLP',
          availableToAssign: quantity > 1 ? quantity - 1 : 0,
        ),
      );
    }

    return apiService.checkoutEvent(eventId, request);
  }

  @override
  Future<TicketOrderAssignmentsEntity> fetchAssignments({
    String? orderId,
    String? ticketId,
  }) async {
    final resolvedOrderId = orderId?.trim();
    final resolvedTicketId = ticketId?.trim();
    final mockReference = resolvedOrderId ?? resolvedTicketId ?? '';

    if (AppConstants.useTicketsMockData) {
      return TicketAssignmentMockData.assignmentsFor(l10n, mockReference);
    }

    if (resolvedOrderId != null && resolvedOrderId.isNotEmpty) {
      return apiService.fetchAssignmentsByOrder(resolvedOrderId);
    }

    if (resolvedTicketId != null && resolvedTicketId.isNotEmpty) {
      return apiService.fetchAssignmentsByTicket(resolvedTicketId);
    }

    throw ApiException(
      code: 'VALIDATION_ERROR',
      message: 'Missing ticket assignment reference',
    );
  }

  @override
  Future<List<AssignGuestLookupEntity>> lookupAssignGuests(String query) async {
    if (AppConstants.useTicketsMockData) {
      final normalized = query.trim().toLowerCase();
      if (normalized.contains('carla')) {
        return const [
          AssignGuestLookupModel(
            userId: 'mock-user-1',
            fullName: 'Carla Pérez',
            phone: '+56987654321',
            phoneDisplay: '+56 9 8765 4321',
            countryCode: 'CL',
          ),
        ];
      }
      return const [];
    }

    final response = await apiService.lookupAssignGuests(query);
    return response.results;
  }

  @override
  Future<AssignTicketGuestResultEntity> assignGuest(
    String orderId,
    String slotId,
    AssignTicketGuestRequestEntity request,
  ) async {
    if (AppConstants.useTicketsMockData) {
      final slot = TicketAssignmentSlotModel(
        id: slotId,
        slotNumber: 2,
        label: 'Entrada 2',
        status: TicketSlotStatus.pending,
        guestName: request.guestName,
        guestPhone: request.guestPhone,
        canCancel: true,
        canResend: true,
      );
      return AssignTicketGuestResultModel(
        slot: slot,
        claimUrl: 'https://youpass.app/claim/mock-token',
        whatsappUrl:
            'https://wa.me/56987654321?text=${Uri.encodeComponent('YouPass mock invite')}',
        message: 'Open WhatsApp and tap Send to deliver the invitation to your guest.',
      );
    }

    return apiService.assignGuest(orderId, slotId, request);
  }

  @override
  Future<AssignTicketGuestResultEntity> cancelAssignment(
    String orderId,
    String slotId,
  ) {
    if (AppConstants.useTicketsMockData) {
      final assignments = TicketAssignmentMockData.assignmentsFor(l10n, orderId);
      final slot = assignments.slots.firstWhere(
        (item) => item.id == slotId,
        orElse: () => assignments.slots.first,
      );
      return Future.value(
        AssignTicketGuestResultModel(
          slot: TicketAssignmentSlotModel(
            id: slot.id,
            slotNumber: slot.slotNumber,
            label: slot.label,
            status: TicketSlotStatus.available,
            canSend: true,
          ),
          message: 'Assignment cancelled',
        ),
      );
    }

    return apiService.cancelAssignment(orderId, slotId);
  }

  @override
  Future<AssignTicketGuestResultEntity> resendAssignment(
    String orderId,
    String slotId,
  ) {
    if (AppConstants.useTicketsMockData) {
      final assignments = TicketAssignmentMockData.assignmentsFor(l10n, orderId);
      final slot = assignments.slots.firstWhere(
        (item) => item.id == slotId,
        orElse: () => assignments.slots.first,
      );
      return Future.value(
        AssignTicketGuestResultModel(
          slot: TicketAssignmentSlotModel(
            id: slot.id,
            slotNumber: slot.slotNumber,
            label: slot.label,
            status: TicketSlotStatus.pending,
            guestName: slot.guestName,
            guestPhone: slot.guestPhone,
            canCancel: true,
            canResend: true,
          ),
          claimUrl: 'https://youpass.app/claim/mock-token',
          whatsappUrl:
              'https://wa.me/56987654321?text=${Uri.encodeComponent('YouPass mock invite')}',
          message: 'Open WhatsApp and tap Send to resend the invitation to your guest.',
        ),
      );
    }

    return apiService.resendAssignment(orderId, slotId);
  }

  @override
  Future<InvitationClaimEntity> fetchInvitationClaim(String token) {
    if (AppConstants.useTicketsMockData) {
      return Future.value(
        InvitationClaimEntity(
          eventTitle: 'Santiago Live Tonight',
          invitedBy: 'Juan Pérez',
          guestName: 'Carla Pérez',
          steps: const [
            'Download the YouPass app',
            'Register or log in with the invited phone number',
            'Open Invitations and accept your ticket',
          ],
        ),
      );
    }

    return apiService.fetchInvitationClaim(token);
  }
}
