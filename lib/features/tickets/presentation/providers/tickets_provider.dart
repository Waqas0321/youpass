import 'package:flutter/foundation.dart';
import 'package:youpass/core/network/api_exception.dart';
import 'package:youpass/core/network/models/api_error_details_model.dart';
import 'package:youpass/features/events/domain/usecases/toggle_event_favorite_usecase.dart'
    as events_usecases;
import 'package:youpass/features/invitations/domain/entities/invitation_ticket_entity.dart';
import 'package:youpass/features/tickets/domain/entities/past_event_entity.dart';
import 'package:youpass/features/tickets/domain/entities/past_event_filter.dart';
import 'package:youpass/features/tickets/domain/entities/past_tickets_query.dart';
import 'package:youpass/features/tickets/domain/entities/tickets_yearly_summary_entity.dart';
import 'package:youpass/features/tickets/domain/entities/upcoming_ticket_entity.dart';
import 'package:youpass/features/tickets/domain/usecases/fetch_past_tickets_usecase.dart';
import 'package:youpass/features/tickets/domain/usecases/fetch_ticket_order_id_usecase.dart';
import 'package:youpass/features/tickets/domain/usecases/fetch_ticket_qr_usecase.dart';
import 'package:youpass/features/tickets/domain/usecases/fetch_tickets_yearly_summary_usecase.dart';
import 'package:youpass/features/tickets/domain/usecases/fetch_upcoming_tickets_usecase.dart';
import 'package:youpass/features/tickets/presentation/providers/tickets_load_status.dart';

class TicketsProvider extends ChangeNotifier {
  TicketsProvider({
    required this.fetchUpcomingTicketsUseCase,
    required this.fetchPastTicketsUseCase,
    required this.fetchTicketsYearlySummaryUseCase,
    required this.fetchTicketQrUseCase,
    required this.fetchTicketOrderIdUseCase,
    required this.toggleEventFavoriteUseCase,
  });

  final FetchUpcomingTicketsUseCase fetchUpcomingTicketsUseCase;
  final FetchPastTicketsUseCase fetchPastTicketsUseCase;
  final FetchTicketsYearlySummaryUseCase fetchTicketsYearlySummaryUseCase;
  final FetchTicketQrUseCase fetchTicketQrUseCase;
  final FetchTicketOrderIdUseCase fetchTicketOrderIdUseCase;
  final events_usecases.ToggleEventFavoriteUseCase toggleEventFavoriteUseCase;

  TicketsLoadStatus upcomingStatus = TicketsLoadStatus.initial;
  TicketsLoadStatus pastStatus = TicketsLoadStatus.initial;

  List<UpcomingTicketEntity> upcomingTickets = const [];
  List<PastEventEntity> pastEvents = const [];
  TicketsYearlySummaryEntity? yearlySummary;

  PastTicketsQuery pastQuery = const PastTicketsQuery();
  String? upcomingErrorMessage;
  String? pastErrorMessage;
  String? errorCode;
  ApiErrorDetailsModel? errorDetails;
  String? loadingQrTicketId;
  final Set<String> favoritePendingIds = {};

  Future<void> ensureUpcomingLoaded() async {
    if (upcomingStatus == TicketsLoadStatus.initial ||
        upcomingStatus == TicketsLoadStatus.error) {
      await loadUpcoming();
    }
  }

  Future<void> ensurePastLoaded() async {
    if (pastStatus == TicketsLoadStatus.initial) {
      await loadPast();
      await loadYearlySummary();
    }
  }

  Future<void> loadUpcoming({bool force = false}) async {
    if (!force &&
        (upcomingStatus == TicketsLoadStatus.loading ||
            upcomingStatus == TicketsLoadStatus.ready)) {
      return;
    }

    upcomingStatus = TicketsLoadStatus.loading;
    upcomingErrorMessage = null;
    errorCode = null;
    errorDetails = null;
    notifyListeners();

    try {
      upcomingTickets = await fetchUpcomingTicketsUseCase();
      upcomingStatus = TicketsLoadStatus.ready;
    } on ApiException catch (error) {
      upcomingStatus = TicketsLoadStatus.error;
      errorCode = error.code;
      upcomingErrorMessage = error.message;
    } catch (error) {
      upcomingStatus = TicketsLoadStatus.error;
      upcomingErrorMessage = error.toString();
    }

    notifyListeners();
  }

  Future<void> loadPast({PastTicketsQuery? query, bool force = false}) async {
    final nextQuery = query ?? pastQuery;

    if (!force &&
        pastStatus == TicketsLoadStatus.loading &&
        nextQuery == pastQuery) {
      return;
    }

    pastQuery = nextQuery;
    pastStatus = TicketsLoadStatus.loading;
    pastErrorMessage = null;
    errorCode = null;
    errorDetails = null;
    notifyListeners();

    try {
      pastEvents = await fetchPastTicketsUseCase(pastQuery);
      pastStatus = TicketsLoadStatus.ready;
    } on ApiException catch (error) {
      pastStatus = TicketsLoadStatus.error;
      errorCode = error.code;
      pastErrorMessage = error.message;
    } catch (error) {
      pastStatus = TicketsLoadStatus.error;
      pastErrorMessage = error.toString();
    }

    notifyListeners();
  }

  Future<void> loadYearlySummary() async {
    try {
      yearlySummary = await fetchTicketsYearlySummaryUseCase();
      notifyListeners();
    } catch (_) {
      // Summary is optional for the header.
    }
  }

  Future<void> applyPastSearch(String search) async {
    await loadPast(
      query: PastTicketsQuery(
        search: search,
        filter: pastQuery.filter,
      ),
      force: true,
    );
  }

  Future<void> applyPastFilter(PastEventFilter filter) async {
    await loadPast(
      query: PastTicketsQuery(
        search: pastQuery.search,
        filter: filter,
      ),
      force: true,
    );
  }

  Future<InvitationTicketEntity?> loadTicketQr(String ticketId) async {
    loadingQrTicketId = ticketId;
    errorCode = null;
    errorDetails = null;
    upcomingErrorMessage = null;
    notifyListeners();

    try {
      return await fetchTicketQrUseCase(ticketId);
    } on ApiException catch (error) {
      errorCode = error.code;
      upcomingErrorMessage = error.message;
      errorDetails = ApiErrorDetailsModel.fromMap(error.details);
      return null;
    } catch (error) {
      upcomingErrorMessage = error.toString();
      return null;
    } finally {
      loadingQrTicketId = null;
      notifyListeners();
    }
  }

  bool isViewQrLoading(String ticketId) => loadingQrTicketId == ticketId;

  Future<String?> resolveTicketOrderId(String ticketId) async {
    try {
      return await fetchTicketOrderIdUseCase(ticketId);
    } on ApiException catch (error) {
      errorCode = error.code;
      upcomingErrorMessage = error.message;
      errorDetails = ApiErrorDetailsModel.fromMap(error.details);
      return null;
    } catch (error) {
      upcomingErrorMessage = error.toString();
      return null;
    }
  }

  Future<bool> togglePastEventFavorite(PastEventEntity event) async {
    final eventId = event.eventId;
    if (eventId == null || eventId.isEmpty || favoritePendingIds.contains(eventId)) {
      return false;
    }

    final previousFavorite = event.isFavorite;
    final nextFavorite = !previousFavorite;

    pastEvents = pastEvents
        .map(
          (item) => item.id == event.id
              ? item.copyWith(isFavorite: nextFavorite)
              : item,
        )
        .toList();
    favoritePendingIds.add(eventId);
    notifyListeners();

    try {
      await toggleEventFavoriteUseCase(
        eventId: eventId,
        isFavorite: previousFavorite,
      );
      return true;
    } catch (_) {
      pastEvents = pastEvents
          .map(
            (item) => item.id == event.id
                ? item.copyWith(isFavorite: previousFavorite)
                : item,
          )
          .toList();
      return false;
    } finally {
      favoritePendingIds.remove(eventId);
      notifyListeners();
    }
  }
}
