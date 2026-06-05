import 'package:youpass/features/ticket_assignment/domain/entities/event_checkout_request_entity.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/event_checkout_result_entity.dart';
import 'package:youpass/features/ticket_assignment/domain/repositories/ticket_assignment_repository.dart';

class CheckoutEventTicketsUseCase {
  CheckoutEventTicketsUseCase(this.repository);

  final TicketAssignmentRepository repository;

  Future<EventCheckoutResultEntity> call({
    required String eventId,
    required EventCheckoutRequestEntity request,
  }) {
    return repository.checkoutEvent(eventId, request);
  }
}
