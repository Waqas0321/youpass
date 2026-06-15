import 'package:youpass/features/tickets/domain/entities/past_event_entity.dart';
import 'package:youpass/features/tickets/domain/repositories/tickets_repository.dart';

class CancelTicketUseCase {
  CancelTicketUseCase(this.repository);

  final TicketsRepository repository;

  Future<PastEventEntity> call(String ticketId) {
    return repository.cancelTicket(ticketId);
  }
}
