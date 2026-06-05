import 'package:youpass/features/tickets/domain/repositories/tickets_repository.dart';

class FetchTicketOrderIdUseCase {
  FetchTicketOrderIdUseCase(this.repository);

  final TicketsRepository repository;

  Future<String?> call(String ticketId) {
    return repository.fetchTicketOrderId(ticketId);
  }
}
