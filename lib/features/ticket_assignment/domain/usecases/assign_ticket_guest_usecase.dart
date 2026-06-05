import 'package:youpass/features/ticket_assignment/domain/entities/assign_ticket_guest_request_entity.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/assign_ticket_guest_result_entity.dart';
import 'package:youpass/features/ticket_assignment/domain/repositories/ticket_assignment_repository.dart';

class AssignTicketGuestUseCase {
  AssignTicketGuestUseCase(this.repository);

  final TicketAssignmentRepository repository;

  Future<AssignTicketGuestResultEntity> call({
    required String orderId,
    required String slotId,
    required AssignTicketGuestRequestEntity request,
  }) {
    return repository.assignGuest(orderId, slotId, request);
  }
}
