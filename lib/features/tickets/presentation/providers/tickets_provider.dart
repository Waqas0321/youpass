import 'package:flutter/foundation.dart';
import 'package:youpass/core/network/api_exception.dart';
import 'package:youpass/core/network/models/api_error_details_model.dart';
import 'package:youpass/core/services/ticket_qr_cache_service.dart';
import 'package:youpass/core/services/tickets_cache.dart';
import 'package:youpass/features/events/domain/usecases/toggle_event_favorite_usecase.dart'
    as events_usecases;
import 'package:youpass/features/invitations/domain/entities/invitation_entity.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_status_extensions.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_ticket_entity.dart';
import 'package:youpass/features/invitations/domain/usecases/confirm_invitation_usecase.dart';
import 'package:youpass/features/invitations/domain/usecases/fetch_invitations_usecase.dart';
import 'package:youpass/features/invitations/domain/usecases/reject_invitation_usecase.dart';
import 'package:youpass/features/tickets/domain/entities/past_event_entity.dart';
import 'package:youpass/features/tickets/domain/entities/past_event_filter.dart';
import 'package:youpass/features/tickets/domain/entities/past_tickets_query.dart';
import 'package:youpass/features/tickets/domain/entities/tickets_yearly_summary_entity.dart';
import 'package:youpass/features/tickets/domain/entities/upcoming_ticket_entity.dart';
import 'package:youpass/features/tickets/domain/usecases/cancel_ticket_usecase.dart';
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
    required this.fetchInvitationsUseCase,
    required this.confirmInvitationUseCase,
    required this.rejectInvitationUseCase,
    required this.cancelTicketUseCase,
    required this.ticketsCache,
    required this.ticketQrCacheService,
  });

  final FetchUpcomingTicketsUseCase fetchUpcomingTicketsUseCase;
  final FetchPastTicketsUseCase fetchPastTicketsUseCase;
  final FetchTicketsYearlySummaryUseCase fetchTicketsYearlySummaryUseCase;
  final FetchTicketQrUseCase fetchTicketQrUseCase;
  final FetchTicketOrderIdUseCase fetchTicketOrderIdUseCase;
  final events_usecases.ToggleEventFavoriteUseCase toggleEventFavoriteUseCase;
  final FetchInvitationsUseCase fetchInvitationsUseCase;
  final ConfirmInvitationUseCase confirmInvitationUseCase;
  final RejectInvitationUseCase rejectInvitationUseCase;
  final CancelTicketUseCase cancelTicketUseCase;
  final TicketsCache ticketsCache;
  final TicketQrCacheService ticketQrCacheService;

  static const int pageSize = 20;

  TicketsLoadStatus upcomingStatus = TicketsLoadStatus.initial;
  TicketsLoadStatus pastStatus = TicketsLoadStatus.initial;
  TicketsLoadStatus invitationsStatus = TicketsLoadStatus.initial;

  List<UpcomingTicketEntity> upcomingTickets = const [];
  List<PastEventEntity> pastEvents = const [];
  List<InvitationEntity> pendingInvitations = const [];
  TicketsYearlySummaryEntity? yearlySummary;

  PastTicketsQuery pastQuery = const PastTicketsQuery();
  int upcomingPage = 1;
  int pastPage = 1;
  bool hasMoreUpcoming = false;
  bool hasMorePast = false;
  bool isLoadingMoreUpcoming = false;
  bool isLoadingMorePast = false;
  bool isRefreshingUpcoming = false;
  bool isRefreshingPast = false;
  bool pastHistoryStale = false;

  String? upcomingErrorMessage;
  String? pastErrorMessage;
  String? invitationsErrorMessage;
  String? errorCode;
  ApiErrorDetailsModel? errorDetails;
  String? loadingQrTicketId;
  String? submittingInvitationId;
  String? cancellingTicketId;
  final Set<String> favoritePendingIds = {};

  Future<void> ensureUpcomingLoaded() async {
    _hydrateUpcomingFromCache();
    if (upcomingStatus == TicketsLoadStatus.initial ||
        upcomingStatus == TicketsLoadStatus.error) {
      await loadUpcoming();
      await loadPendingInvitations();
    }
  }

  Future<void> ensurePastLoaded() async {
    if (!pastHistoryStale) {
      _hydratePastFromCache();
    }
    if (pastStatus == TicketsLoadStatus.initial || pastHistoryStale) {
      await loadPast(force: pastHistoryStale, resetPage: true);
      await loadYearlySummary();
      pastHistoryStale = false;
    }
  }

  void _hydrateUpcomingFromCache() {
    final cached = ticketsCache.readUpcoming();
    if (cached.isEmpty) {
      return;
    }
    upcomingTickets = cached;
    upcomingStatus = TicketsLoadStatus.ready;
    notifyListeners();
  }

  void _hydratePastFromCache() {
    final cached = ticketsCache.readPast(pastQuery);
    if (cached.isEmpty) {
      return;
    }
    pastEvents = cached;
    pastStatus = TicketsLoadStatus.ready;
    notifyListeners();
  }

  Future<void> refreshUpcoming() async {
    isRefreshingUpcoming = true;
    notifyListeners();
    await loadUpcoming(force: true);
    await loadPendingInvitations(force: true);
    isRefreshingUpcoming = false;
    notifyListeners();
  }

  Future<void> refreshPast() async {
    isRefreshingPast = true;
    notifyListeners();
    await loadPast(force: true, resetPage: true);
    await loadYearlySummary();
    isRefreshingPast = false;
    notifyListeners();
  }

  Future<void> loadUpcoming({bool force = false}) async {
    if (!force &&
        (upcomingStatus == TicketsLoadStatus.loading ||
            upcomingStatus == TicketsLoadStatus.ready)) {
      return;
    }

    final hadCachedData = upcomingTickets.isNotEmpty;
    if (!hadCachedData) {
      upcomingStatus = TicketsLoadStatus.loading;
    }
    upcomingErrorMessage = null;
    errorCode = null;
    errorDetails = null;
    upcomingPage = 1;
    notifyListeners();

    try {
      final result = await fetchUpcomingTicketsUseCase(page: 1, limit: pageSize);
      upcomingTickets = result.items;
      upcomingPage = result.page;
      hasMoreUpcoming = result.hasMore;
      upcomingStatus = TicketsLoadStatus.ready;
      await ticketsCache.saveUpcoming(upcomingTickets);
      ticketQrCacheService.scheduleMidnightPrecache(upcomingTickets);
    } on ApiException catch (error) {
      if (!hadCachedData) {
        upcomingStatus = TicketsLoadStatus.error;
      }
      errorCode = error.code;
      upcomingErrorMessage = error.message;
    } catch (error) {
      if (!hadCachedData) {
        upcomingStatus = TicketsLoadStatus.error;
      }
      upcomingErrorMessage = error.toString();
    }

    notifyListeners();
  }

  Future<void> loadMoreUpcoming() async {
    if (!hasMoreUpcoming || isLoadingMoreUpcoming) {
      return;
    }

    isLoadingMoreUpcoming = true;
    notifyListeners();

    try {
      final nextPage = upcomingPage + 1;
      final result = await fetchUpcomingTicketsUseCase(
        page: nextPage,
        limit: pageSize,
      );
      upcomingTickets = [...upcomingTickets, ...result.items];
      upcomingPage = result.page;
      hasMoreUpcoming = result.hasMore;
      await ticketsCache.saveUpcoming(upcomingTickets);
    } catch (_) {
      // Keep existing list on pagination failure.
    } finally {
      isLoadingMoreUpcoming = false;
      notifyListeners();
    }
  }

  Future<void> loadPendingInvitations({bool force = false}) async {
    if (!force &&
        (invitationsStatus == TicketsLoadStatus.loading ||
            invitationsStatus == TicketsLoadStatus.ready)) {
      return;
    }

    if (pendingInvitations.isEmpty) {
      invitationsStatus = TicketsLoadStatus.loading;
      notifyListeners();
    }

    try {
      final invitations = await fetchInvitationsUseCase();
      pendingInvitations = invitations
          .where((item) => item.status.isPending)
          .toList();
      invitationsStatus = TicketsLoadStatus.ready;
      invitationsErrorMessage = null;
    } on ApiException catch (error) {
      invitationsStatus = TicketsLoadStatus.error;
      invitationsErrorMessage = error.message;
    } catch (error) {
      invitationsStatus = TicketsLoadStatus.error;
      invitationsErrorMessage = error.toString();
    }

    notifyListeners();
  }

  Future<void> loadPast({
    PastTicketsQuery? query,
    bool force = false,
    bool resetPage = true,
  }) async {
    final nextQuery = query ?? pastQuery;
    final queryChanged = nextQuery.search != pastQuery.search ||
        nextQuery.filter != pastQuery.filter;

    if (!force &&
        pastStatus == TicketsLoadStatus.loading &&
        nextQuery == pastQuery) {
      return;
    }

    pastQuery = nextQuery;
    final hadCachedData = !queryChanged && pastEvents.isNotEmpty;
    if (!hadCachedData || resetPage) {
      if (!hadCachedData) {
        pastStatus = TicketsLoadStatus.loading;
      }
      if (resetPage) {
        pastPage = 1;
      }
    }
    pastErrorMessage = null;
    errorCode = null;
    errorDetails = null;
    notifyListeners();

    try {
      final result = await fetchPastTicketsUseCase(
        pastQuery.copyWith(page: resetPage ? 1 : pastPage),
      );
      pastEvents = resetPage ? result.items : [...pastEvents, ...result.items];
      pastPage = result.page;
      hasMorePast = result.hasMore;
      pastStatus = TicketsLoadStatus.ready;
      if (resetPage) {
        await ticketsCache.savePast(pastQuery, pastEvents);
      }
    } on ApiException catch (error) {
      if (!hadCachedData) {
        pastStatus = TicketsLoadStatus.error;
      }
      errorCode = error.code;
      pastErrorMessage = error.message;
    } catch (error) {
      if (!hadCachedData) {
        pastStatus = TicketsLoadStatus.error;
      }
      pastErrorMessage = error.toString();
    }

    notifyListeners();
  }

  Future<void> loadMorePast() async {
    if (!hasMorePast || isLoadingMorePast) {
      return;
    }

    isLoadingMorePast = true;
    notifyListeners();

    try {
      final nextPage = pastPage + 1;
      final result = await fetchPastTicketsUseCase(
        pastQuery.copyWith(page: nextPage),
      );
      pastEvents = [...pastEvents, ...result.items];
      pastPage = result.page;
      hasMorePast = result.hasMore;
      await ticketsCache.savePast(pastQuery, pastEvents);
    } catch (_) {
      // Keep existing list on pagination failure.
    } finally {
      isLoadingMorePast = false;
      notifyListeners();
    }
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
      resetPage: true,
    );
  }

  Future<void> applyPastFilter(PastEventFilter filter) async {
    await loadPast(
      query: PastTicketsQuery(
        search: pastQuery.search,
        filter: filter,
      ),
      force: true,
      resetPage: true,
    );
  }

  Future<InvitationTicketEntity?> loadTicketQr(String ticketId) async {
    loadingQrTicketId = ticketId;
    errorCode = null;
    errorDetails = null;
    upcomingErrorMessage = null;
    notifyListeners();

    try {
      final cached = ticketQrCacheService.readCached(ticketId);
      if (cached != null) {
        return cached;
      }
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

  bool isInvitationSubmitting(String invitationId) =>
      submittingInvitationId == invitationId;

  bool isTicketCancelling(String ticketId) => cancellingTicketId == ticketId;

  Future<bool> confirmPendingInvitation(String invitationId) async {
    submittingInvitationId = invitationId;
    notifyListeners();

    try {
      await confirmInvitationUseCase(invitationId);
      pendingInvitations = pendingInvitations
          .where((item) => item.id != invitationId)
          .toList();
      await loadUpcoming(force: true);
      return true;
    } on ApiException catch (error) {
      errorCode = error.code;
      upcomingErrorMessage = error.message;
      return false;
    } catch (error) {
      upcomingErrorMessage = error.toString();
      return false;
    } finally {
      submittingInvitationId = null;
      notifyListeners();
    }
  }

  Future<bool> rejectPendingInvitation(String invitationId) async {
    submittingInvitationId = invitationId;
    notifyListeners();

    try {
      await rejectInvitationUseCase(invitationId);
      pendingInvitations = pendingInvitations
          .where((item) => item.id != invitationId)
          .toList();
      return true;
    } on ApiException catch (error) {
      errorCode = error.code;
      upcomingErrorMessage = error.message;
      return false;
    } catch (error) {
      upcomingErrorMessage = error.toString();
      return false;
    } finally {
      submittingInvitationId = null;
      notifyListeners();
    }
  }

  Future<bool> cancelTicket(String ticketId) async {
    cancellingTicketId = ticketId;
    notifyListeners();

    try {
      final canceledEvent = await cancelTicketUseCase(ticketId);
      upcomingTickets =
          upcomingTickets.where((item) => item.id != ticketId).toList();
      await ticketsCache.saveUpcoming(upcomingTickets);

      pastHistoryStale = true;
      await ticketsCache.clearPast(pastQuery);
      pastEvents = [
        canceledEvent,
        ...pastEvents.where((event) => event.id != ticketId),
      ];
      pastStatus = TicketsLoadStatus.ready;
      await ticketsCache.savePast(pastQuery, pastEvents);
      await loadPast(force: true, resetPage: true);
      pastHistoryStale = false;
      return true;
    } on ApiException catch (error) {
      errorCode = error.code;
      upcomingErrorMessage = error.message;
      return false;
    } catch (error) {
      upcomingErrorMessage = error.toString();
      return false;
    } finally {
      cancellingTicketId = null;
      notifyListeners();
    }
  }

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

  void reset() {
    upcomingStatus = TicketsLoadStatus.initial;
    pastStatus = TicketsLoadStatus.initial;
    invitationsStatus = TicketsLoadStatus.initial;
    upcomingTickets = const [];
    pastEvents = const [];
    pendingInvitations = const [];
    yearlySummary = null;
    upcomingPage = 1;
    pastPage = 1;
    hasMoreUpcoming = false;
    hasMorePast = false;
    pastHistoryStale = false;
    notifyListeners();
  }
}
