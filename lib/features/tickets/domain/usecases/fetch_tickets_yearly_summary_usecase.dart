import 'package:youpass/features/tickets/domain/entities/tickets_yearly_summary_entity.dart';
import 'package:youpass/features/tickets/domain/repositories/tickets_repository.dart';

class FetchTicketsYearlySummaryUseCase {
  FetchTicketsYearlySummaryUseCase(this.repository);

  final TicketsRepository repository;

  Future<TicketsYearlySummaryEntity> call() {
    return repository.fetchYearlySummary();
  }
}
