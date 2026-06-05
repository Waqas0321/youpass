import 'package:youpass/features/ticket_assignment/domain/entities/assign_ticket_guest_result_entity.dart';
import 'package:youpass/features/ticket_assignment/domain/repositories/ticket_assignment_repository.dart';

class CancelTicketAssignmentUseCase {
  CancelTicketAssignmentUseCase(this.repository);

  final TicketAssignmentRepository repository;

  Future<AssignTicketGuestResultEntity> call({
    required String orderId,
    required String slotId,
  }) {
    return repository.cancelAssignment(orderId, slotId);
  }
}
