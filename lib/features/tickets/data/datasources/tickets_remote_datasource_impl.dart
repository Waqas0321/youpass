import 'package:youpass/core/constants/app_constants.dart';
import 'package:youpass/core/locale/locale_provider.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_ticket_entity.dart';
import 'package:youpass/features/tickets/data/datasources/tickets_remote_datasource.dart';
import 'package:youpass/features/tickets/data/services/tickets_api_service.dart';
import 'package:youpass/features/tickets/domain/entities/past_event_entity.dart';
import 'package:youpass/features/tickets/domain/entities/past_tickets_query.dart';
import 'package:youpass/features/tickets/domain/entities/tickets_page_result.dart';
import 'package:youpass/features/tickets/domain/entities/tickets_yearly_summary_entity.dart';
import 'package:youpass/features/tickets/domain/entities/upcoming_ticket_entity.dart';
import 'package:youpass/features/tickets/presentation/data/tickets_mock_data.dart';
import 'package:youpass/l10n/app_localizations.dart';

class TicketsRemoteDataSourceImpl implements TicketsRemoteDataSource {
  TicketsRemoteDataSourceImpl({
    required this.apiService,
    required this.localeProvider,
  });

  final TicketsApiService apiService;
  final LocaleProvider localeProvider;

  AppLocalizations get _l10n => lookupAppLocalizations(localeProvider.locale);

  @override
  Future<TicketsPageResult<UpcomingTicketEntity>> fetchUpcomingTickets({
    int page = 1,
    int limit = 20,
  }) async {
    if (AppConstants.useTicketsMockData) {
      final items = TicketsMockData.upcoming(_l10n);
      return TicketsPageResult(
        items: items,
        total: items.length,
        page: 1,
        limit: limit,
        totalPages: 1,
      );
    }

    return apiService.fetchUpcomingTickets(page: page, limit: limit);
  }

  @override
  Future<TicketsPageResult<PastEventEntity>> fetchPastTickets(
    PastTicketsQuery query,
  ) async {
    if (AppConstants.useTicketsMockData) {
      final items = _filterMockPast(TicketsMockData.past(_l10n), query);
      return TicketsPageResult(
        items: items,
        total: items.length,
        page: 1,
        limit: query.limit,
        totalPages: 1,
      );
    }

    return apiService.fetchPastTicketsPage(query);
  }

  List<PastEventEntity> _filterMockPast(
    List<PastEventEntity> events,
    PastTicketsQuery query,
  ) {
    final search = query.search?.trim().toLowerCase() ?? '';
    return events.where((event) {
      final matchesFilter = query.eventTypeSlug == null ||
          query.eventTypeSlug == event.eventTypeSlug;
      final matchesSearch = search.isEmpty ||
          event.title.toLowerCase().contains(search) ||
          event.locationLabel.toLowerCase().contains(search);
      return matchesFilter && matchesSearch;
    }).toList();
  }

  @override
  Future<TicketsYearlySummaryEntity> fetchYearlySummary() async {
    if (AppConstants.useTicketsMockData) {
      return TicketsMockData.yearlySummary(_l10n);
    }

    return apiService.fetchYearlySummary();
  }

  @override
  Future<InvitationTicketEntity> fetchTicketQr(String ticketId) async {
    return apiService.fetchTicketQr(ticketId);
  }

  @override
  Future<String?> fetchTicketOrderId(String ticketId) {
    return apiService.fetchTicketOrderId(ticketId);
  }

  @override
  Future<PastEventEntity> cancelTicket(String ticketId) {
    return apiService.cancelTicket(ticketId);
  }
}
