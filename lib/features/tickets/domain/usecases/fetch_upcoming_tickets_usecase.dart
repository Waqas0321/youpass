import 'package:youpass/features/tickets/domain/entities/upcoming_ticket_entity.dart';
import 'package:youpass/features/tickets/domain/repositories/tickets_repository.dart';

class FetchUpcomingTicketsUseCase {
  FetchUpcomingTicketsUseCase(this.repository);

  final TicketsRepository repository;

  Future<List<UpcomingTicketEntity>> call({
    int page = 1,
    int limit = 20,
  }) {
    return repository.fetchUpcomingTickets(page: page, limit: limit);
  }
}
