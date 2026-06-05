import 'package:youpass/core/network/api_endpoints.dart';
import 'package:youpass/core/network/base_api_service.dart';
import 'package:youpass/features/invitations/data/models/invitation_ticket_model.dart';
import 'package:youpass/features/tickets/data/models/past_ticket_model.dart';
import 'package:youpass/features/tickets/data/models/past_tickets_list_response_model.dart';
import 'package:youpass/features/tickets/data/models/tickets_list_response_model.dart';
import 'package:youpass/features/tickets/data/models/tickets_yearly_summary_model.dart';
import 'package:youpass/features/tickets/data/models/upcoming_ticket_model.dart';
import 'package:youpass/features/tickets/domain/entities/past_tickets_query.dart';

class TicketsApiService extends BaseApiService {
  TicketsApiService(super.apiClient);

  static const int defaultPageSize = 20;

  Future<List<UpcomingTicketModel>> fetchUpcomingTickets({
    int page = 1,
    int limit = defaultPageSize,
  }) async {
    final response = await getModel(
      _withQuery(
        ApiEndpoints.ticketsUpcoming,
        {
          'page': '$page',
          'limit': '$limit',
        },
      ),
      fromJson: UpcomingTicketsResponseModel.fromJson,
      authenticated: true,
    );

    return response.tickets;
  }

  Future<List<PastTicketModel>> fetchPastTickets(PastTicketsQuery query) async {
    final response = await getModel(
      _withQuery(ApiEndpoints.ticketsPast, query.toQueryParameters()),
      fromJson: PastTicketsListResponseModel.fromJson,
      authenticated: true,
    );

    return response.tickets;
  }

  Future<TicketsYearlySummaryModel> fetchYearlySummary() {
    return getModel(
      ApiEndpoints.ticketsYearlySummary,
      fromJson: TicketsYearlySummaryModel.fromJson,
      authenticated: true,
    );
  }

  Future<String?> fetchTicketOrderId(String ticketId) async {
    final data = await getData(
      ApiEndpoints.ticketById(ticketId),
      authenticated: true,
    );

    return UpcomingTicketModel.readTicketOrderId(data);
  }

  Future<InvitationTicketModel> fetchTicketQr(String ticketId) {
    return getModel(
      ApiEndpoints.ticketQr(ticketId),
      fromJson: (json) => InvitationTicketModel.fromJson(
        json,
        invitationId: json['invitation_id']?.toString() ??
            json['invitationId']?.toString() ??
            ticketId,
      ),
      authenticated: true,
    );
  }

  String _withQuery(String endpoint, Map<String, String> params) {
    if (params.isEmpty) {
      return endpoint;
    }

    return '$endpoint?${Uri(queryParameters: params).query}';
  }
}
