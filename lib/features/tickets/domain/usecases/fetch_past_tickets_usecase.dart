import 'package:youpass/features/tickets/domain/entities/past_event_entity.dart';
import 'package:youpass/features/tickets/domain/entities/past_tickets_query.dart';
import 'package:youpass/features/tickets/domain/entities/tickets_page_result.dart';
import 'package:youpass/features/tickets/domain/repositories/tickets_repository.dart';

class FetchPastTicketsUseCase {
  FetchPastTicketsUseCase(this.repository);

  final TicketsRepository repository;

  Future<TicketsPageResult<PastEventEntity>> call(PastTicketsQuery query) {
    return repository.fetchPastTickets(query);
  }
}
