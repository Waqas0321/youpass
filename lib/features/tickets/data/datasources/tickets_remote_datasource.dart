import 'package:youpass/features/invitations/domain/entities/invitation_ticket_entity.dart';
import 'package:youpass/features/tickets/domain/entities/past_event_entity.dart';
import 'package:youpass/features/tickets/domain/entities/past_tickets_query.dart';
import 'package:youpass/features/tickets/domain/entities/tickets_page_result.dart';
import 'package:youpass/features/tickets/domain/entities/tickets_yearly_summary_entity.dart';
import 'package:youpass/features/tickets/domain/entities/upcoming_ticket_entity.dart';

abstract class TicketsRemoteDataSource {
  Future<TicketsPageResult<UpcomingTicketEntity>> fetchUpcomingTickets({
    int page = 1,
    int limit = 20,
  });

  Future<TicketsPageResult<PastEventEntity>> fetchPastTickets(
    PastTicketsQuery query,
  );

  Future<TicketsYearlySummaryEntity> fetchYearlySummary();

  Future<InvitationTicketEntity> fetchTicketQr(String ticketId);

  Future<String?> fetchTicketOrderId(String ticketId);

  Future<PastEventEntity> cancelTicket(String ticketId);
}
