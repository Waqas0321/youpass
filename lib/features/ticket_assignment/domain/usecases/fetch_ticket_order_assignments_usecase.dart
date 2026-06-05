import 'package:youpass/features/ticket_assignment/domain/entities/ticket_order_assignments_entity.dart';
import 'package:youpass/features/ticket_assignment/domain/repositories/ticket_assignment_repository.dart';

class FetchTicketOrderAssignmentsUseCase {
  FetchTicketOrderAssignmentsUseCase(this.repository);

  final TicketAssignmentRepository repository;

  Future<TicketOrderAssignmentsEntity> call({
    String? orderId,
    String? ticketId,
  }) {
    return repository.fetchAssignments(
      orderId: orderId,
      ticketId: ticketId,
    );
  }
}
