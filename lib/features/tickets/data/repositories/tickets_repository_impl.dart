import 'package:youpass/features/invitations/domain/entities/invitation_ticket_entity.dart';
import 'package:youpass/features/tickets/data/datasources/tickets_remote_datasource.dart';
import 'package:youpass/features/tickets/domain/entities/past_event_entity.dart';
import 'package:youpass/features/tickets/domain/entities/past_tickets_query.dart';
import 'package:youpass/features/tickets/domain/entities/tickets_page_result.dart';
import 'package:youpass/features/tickets/domain/entities/tickets_yearly_summary_entity.dart';
import 'package:youpass/features/tickets/domain/entities/upcoming_ticket_entity.dart';
import 'package:youpass/features/tickets/domain/repositories/tickets_repository.dart';

class TicketsRepositoryImpl implements TicketsRepository {
  TicketsRepositoryImpl(this.remoteDataSource);

  final TicketsRemoteDataSource remoteDataSource;

  @override
  Future<TicketsPageResult<UpcomingTicketEntity>> fetchUpcomingTickets({
    int page = 1,
    int limit = 20,
  }) {
    return remoteDataSource.fetchUpcomingTickets(page: page, limit: limit);
  }

  @override
  Future<TicketsPageResult<PastEventEntity>> fetchPastTickets(
    PastTicketsQuery query,
  ) {
    return remoteDataSource.fetchPastTickets(query);
  }

  @override
  Future<TicketsYearlySummaryEntity> fetchYearlySummary() {
    return remoteDataSource.fetchYearlySummary();
  }

  @override
  Future<InvitationTicketEntity> fetchTicketQr(String ticketId) {
    return remoteDataSource.fetchTicketQr(ticketId);
  }

  @override
  Future<String?> fetchTicketOrderId(String ticketId) {
    return remoteDataSource.fetchTicketOrderId(ticketId);
  }

  @override
  Future<PastEventEntity> cancelTicket(String ticketId) {
    return remoteDataSource.cancelTicket(ticketId);
  }
}
