import 'package:flutter/foundation.dart';
import 'package:youpass/core/network/api_exception.dart';
import 'package:youpass/core/network/models/api_error_details_model.dart';
import 'package:youpass/features/invitations/domain/entities/confirm_invitation_params.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_entity.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_ticket_entity.dart';
import 'package:youpass/features/invitations/domain/entities/payment_method_request_entity.dart';
import 'package:youpass/features/events/domain/entities/event_type_entity.dart';
import 'package:youpass/features/events/domain/repositories/events_repository.dart';
import 'package:youpass/features/invitations/domain/usecases/cancel_invitation_usecase.dart';
import 'package:youpass/features/invitations/domain/usecases/check_saved_payment_methods_usecase.dart';
import 'package:youpass/features/invitations/domain/usecases/confirm_invitation_usecase.dart';
import 'package:youpass/features/invitations/domain/usecases/fetch_invitation_detail_usecase.dart';
import 'package:youpass/features/invitations/domain/usecases/fetch_invitation_ticket_usecase.dart';
import 'package:youpass/features/invitations/domain/usecases/fetch_invitations_summary_usecase.dart';
import 'package:youpass/features/invitations/domain/usecases/fetch_invitations_feed_usecase.dart';
import 'package:youpass/features/waitlist/domain/entities/waitlist_entry_entity.dart';
import 'package:youpass/features/invitations/domain/usecases/reject_invitation_usecase.dart';
import 'package:youpass/features/invitations/domain/usecases/save_payment_method_usecase.dart';
import 'package:youpass/features/invitations/presentation/providers/invitation_submit_action.dart';
import 'package:youpass/features/invitations/presentation/providers/invitations_status.dart';

class InvitationsProvider extends ChangeNotifier {
  InvitationsProvider({
    required this.fetchInvitationsFeedUseCase,
    required this.fetchInvitationsSummaryUseCase,
    required this.fetchInvitationDetailUseCase,
    required this.checkSavedPaymentMethodsUseCase,
    required this.confirmInvitationUseCase,
    required this.rejectInvitationUseCase,
    required this.cancelInvitationUseCase,
    required this.fetchInvitationTicketUseCase,
    required this.savePaymentMethodUseCase,
    required this.eventsRepository,
  });

  final FetchInvitationsFeedUseCase fetchInvitationsFeedUseCase;
  final FetchInvitationsSummaryUseCase fetchInvitationsSummaryUseCase;
  final FetchInvitationDetailUseCase fetchInvitationDetailUseCase;
  final CheckSavedPaymentMethodsUseCase checkSavedPaymentMethodsUseCase;
  final ConfirmInvitationUseCase confirmInvitationUseCase;
  final RejectInvitationUseCase rejectInvitationUseCase;
  final CancelInvitationUseCase cancelInvitationUseCase;
  final FetchInvitationTicketUseCase fetchInvitationTicketUseCase;
  final SavePaymentMethodUseCase savePaymentMethodUseCase;
  final EventsRepository eventsRepository;

  InvitationsStatus status = InvitationsStatus.initial;
  List<InvitationEntity> invitations = const [];
  List<EventTypeEntity> eventTypeFilters = const [];
  List<WaitlistEntryEntity> waitlistEntries = const [];
  bool isSubmitting = false;
  String? submittingInvitationId;
  InvitationSubmitAction? submittingAction;
  String? errorMessage;
  String? errorCode;
  ApiErrorDetailsModel? errorDetails;
  bool hasPaymentMethod = false;
  int invitationsBadgeCount = 0;

  void reset() {
    status = InvitationsStatus.initial;
    invitations = const [];
    eventTypeFilters = const [];
    waitlistEntries = const [];
    isSubmitting = false;
    submittingInvitationId = null;
    submittingAction = null;
    errorMessage = null;
    errorCode = null;
    errorDetails = null;
    hasPaymentMethod = false;
    invitationsBadgeCount = 0;
    notifyListeners();
  }

  Future<void> ensureLoaded() async {
    if (status == InvitationsStatus.initial ||
        status == InvitationsStatus.error) {
      await _loadEventTypeFilters();
      await loadInvitations();
      return;
    }

    if (eventTypeFilters.isEmpty) {
      await _loadEventTypeFilters();
    }
  }

  Future<void> _loadEventTypeFilters() async {
    try {
      eventTypeFilters = await eventsRepository.fetchEventTypes();
      notifyListeners();
    } catch (_) {
      // Filters fall back to "All" when types cannot be loaded.
    }
  }

  Future<void> refreshDrawerBadge() async {
    try {
      final summary = await fetchInvitationsSummaryUseCase();
      invitationsBadgeCount = summary.newCount;
      notifyListeners();
    } catch (_) {
      // Badge is non-critical; keep the previous count.
    }
  }

  Future<void> loadInvitations({bool force = false}) async {
    if (!force &&
        (status == InvitationsStatus.loading ||
            status == InvitationsStatus.ready)) {
      return;
    }
    status = InvitationsStatus.loading;
    errorMessage = null;
    errorCode = null;
    errorDetails = null;
    notifyListeners();

    try {
      final feedFuture = fetchInvitationsFeedUseCase();
      final summaryFuture = fetchInvitationsSummaryUseCase();
      final paymentMethodsFuture = checkSavedPaymentMethodsUseCase();

      final feed = await feedFuture;
      final summary = await summaryFuture;
      final savedPaymentMethods = await loadHasPaymentMethodSafely(
        paymentMethodsFuture,
      );

      invitations = feed.invitations;
      waitlistEntries = feed.waitlistEntries;
      hasPaymentMethod = savedPaymentMethods;
      invitationsBadgeCount = summary.newCount;
      status = InvitationsStatus.ready;
    } on ApiException catch (error) {
      status = InvitationsStatus.error;
      errorCode = error.code;
      errorMessage = error.message;
    } catch (error) {
      status = InvitationsStatus.error;
      errorMessage = error.toString();
    }

    notifyListeners();
  }

  Future<bool> loadHasPaymentMethodSafely(Future<bool> future) async {
    try {
      return await future;
    } catch (_) {
      return false;
    }
  }

  Future<void> refreshPaymentMethodStatus() async {
    try {
      hasPaymentMethod = await checkSavedPaymentMethodsUseCase();
      notifyListeners();
    } catch (_) {
      hasPaymentMethod = false;
    }
  }

  bool isActionLoading(String invitationId, InvitationSubmitAction action) {
    return isSubmitting &&
        submittingInvitationId == invitationId &&
        submittingAction == action;
  }

  bool isAnyActionLoading(String invitationId) {
    return isSubmitting && submittingInvitationId == invitationId;
  }

  void beginSubmit(String invitationId, InvitationSubmitAction action) {
    isSubmitting = true;
    submittingInvitationId = invitationId;
    submittingAction = action;
    notifyListeners();
  }

  void endSubmit() {
    isSubmitting = false;
    submittingInvitationId = null;
    submittingAction = null;
    notifyListeners();
  }

  Future<bool> savePaymentMethod(PaymentMethodRequestEntity request) async {
    isSubmitting = true;
    submittingInvitationId = null;
    submittingAction = null;
    errorMessage = null;
    errorCode = null;
    errorDetails = null;
    notifyListeners();

    try {
      await savePaymentMethodUseCase(request);
      hasPaymentMethod = true;
      return true;
    } on ApiException catch (error) {
      errorCode = error.code;
      errorMessage = error.message;
      return false;
    } catch (error) {
      errorMessage = error.toString();
      return false;
    } finally {
      endSubmit();
    }
  }

  Future<InvitationEntity?> loadInvitationDetail(String invitationId) async {
    beginSubmit(invitationId, InvitationSubmitAction.viewQr);
    errorMessage = null;
    errorCode = null;
    errorDetails = null;

    try {
      final detail = await fetchInvitationDetailUseCase(invitationId);
      invitations = replaceInvitation(detail);
      return detail;
    } on ApiException catch (error) {
      errorCode = error.code;
      errorMessage = error.message;
      return null;
    } catch (error) {
      errorMessage = error.toString();
      return null;
    } finally {
      endSubmit();
    }
  }

  Future<bool> cancelInvitation(String invitationId) async {
    beginSubmit(invitationId, InvitationSubmitAction.cancel);

    try {
      await cancelInvitationUseCase(invitationId);
      invitations = removeInvitation(invitationId);
      await refreshDrawerBadge();
      return true;
    } on ApiException catch (error) {
      errorCode = error.code;
      errorMessage = error.message;
      return false;
    } catch (error) {
      errorMessage = error.toString();
      return false;
    } finally {
      endSubmit();
    }
  }

  Future<bool> confirmInvitation(
    String invitationId, {
    ConfirmInvitationParams params = const ConfirmInvitationParams(),
  }) async {
    beginSubmit(invitationId, InvitationSubmitAction.confirm);

    try {
      final updated = await confirmInvitationUseCase(invitationId, params: params);
      invitations = replaceInvitation(updated);
      await refreshDrawerBadge();
      return true;
    } on ApiException catch (error) {
      errorCode = error.code;
      errorMessage = error.message;
      return false;
    } catch (error) {
      errorMessage = error.toString();
      return false;
    } finally {
      endSubmit();
    }
  }

  Future<bool> rejectInvitation(String invitationId) async {
    beginSubmit(invitationId, InvitationSubmitAction.reject);

    try {
      await rejectInvitationUseCase(invitationId);
      invitations = removeInvitation(invitationId);
      await refreshDrawerBadge();
      return true;
    } on ApiException catch (error) {
      errorCode = error.code;
      errorMessage = error.message;
      return false;
    } catch (error) {
      errorMessage = error.toString();
      return false;
    } finally {
      endSubmit();
    }
  }

  Future<InvitationTicketEntity?> loadTicket(String invitationId) async {
    beginSubmit(invitationId, InvitationSubmitAction.viewQr);

    try {
      return await fetchInvitationTicketUseCase(invitationId);
    } on ApiException catch (error) {
      errorCode = error.code;
      errorMessage = error.message;
      errorDetails = ApiErrorDetailsModel.fromMap(error.details);
      return null;
    } catch (error) {
      errorMessage = error.toString();
      return null;
    } finally {
      endSubmit();
    }
  }

  List<InvitationEntity> replaceInvitation(InvitationEntity updated) {
    return invitations
        .map((item) => item.id == updated.id ? updated : item)
        .toList();
  }

  List<InvitationEntity> removeInvitation(String invitationId) {
    return invitations.where((item) => item.id != invitationId).toList();
  }
}
