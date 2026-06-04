import 'package:flutter/foundation.dart';
import 'package:youpass/core/network/api_exception.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_entity.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_ticket_entity.dart';
import 'package:youpass/features/invitations/domain/entities/payment_method_request_entity.dart';
import 'package:youpass/features/invitations/domain/usecases/check_saved_payment_methods_usecase.dart';
import 'package:youpass/features/invitations/domain/usecases/confirm_invitation_usecase.dart';
import 'package:youpass/features/invitations/domain/usecases/fetch_invitation_ticket_usecase.dart';
import 'package:youpass/features/invitations/domain/usecases/fetch_invitations_summary_usecase.dart';
import 'package:youpass/features/invitations/domain/usecases/fetch_invitations_usecase.dart';
import 'package:youpass/features/invitations/domain/usecases/reject_invitation_usecase.dart';
import 'package:youpass/features/invitations/domain/usecases/save_payment_method_usecase.dart';

enum InvitationsStatus { initial, loading, ready, error }

class InvitationsProvider extends ChangeNotifier {
  InvitationsProvider({
    required this.fetchInvitationsUseCase,
    required this.fetchInvitationsSummaryUseCase,
    required this.checkSavedPaymentMethodsUseCase,
    required this.confirmInvitationUseCase,
    required this.rejectInvitationUseCase,
    required this.fetchInvitationTicketUseCase,
    required this.savePaymentMethodUseCase,
  });

  final FetchInvitationsUseCase fetchInvitationsUseCase;
  final FetchInvitationsSummaryUseCase fetchInvitationsSummaryUseCase;
  final CheckSavedPaymentMethodsUseCase checkSavedPaymentMethodsUseCase;
  final ConfirmInvitationUseCase confirmInvitationUseCase;
  final RejectInvitationUseCase rejectInvitationUseCase;
  final FetchInvitationTicketUseCase fetchInvitationTicketUseCase;
  final SavePaymentMethodUseCase savePaymentMethodUseCase;

  InvitationsStatus status = InvitationsStatus.initial;
  List<InvitationEntity> invitations = const [];
  bool isSubmitting = false;
  String? errorMessage;
  String? errorCode;
  Map<String, dynamic>? errorDetails;
  bool hasPaymentMethod = false;
  int invitationsBadgeCount = 0;

  void reset() {
    status = InvitationsStatus.initial;
    invitations = const [];
    isSubmitting = false;
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
      await loadInvitations();
    }
  }

  Future<void> refreshDrawerBadge() async {
    try {
      final summary = await fetchInvitationsSummaryUseCase();
      invitationsBadgeCount = summary.newCount > 0
          ? summary.newCount
          : summary.pendingCount;
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
      final invitationsFuture = fetchInvitationsUseCase();
      final summaryFuture = fetchInvitationsSummaryUseCase();
      final paymentMethodsFuture = checkSavedPaymentMethodsUseCase();

      final loadedInvitations = await invitationsFuture;
      final summary = await summaryFuture;
      final savedPaymentMethods = await _loadHasPaymentMethodSafely(
        paymentMethodsFuture,
      );

      invitations = loadedInvitations;
      hasPaymentMethod = savedPaymentMethods;
      invitationsBadgeCount =
          summary.newCount > 0 ? summary.newCount : summary.pendingCount;
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

  Future<bool> _loadHasPaymentMethodSafely(Future<bool> future) async {
    try {
      return await future;
    } catch (_) {
      return false;
    }
  }

  Future<bool> savePaymentMethod(PaymentMethodRequestEntity request) async {
    isSubmitting = true;
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
      isSubmitting = false;
      notifyListeners();
    }
  }

  Future<bool> confirmInvitation(String invitationId) async {
    isSubmitting = true;
    notifyListeners();

    try {
      final updated = await confirmInvitationUseCase(invitationId);
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
      isSubmitting = false;
      notifyListeners();
    }
  }

  Future<bool> rejectInvitation(String invitationId) async {
    isSubmitting = true;
    notifyListeners();

    try {
      final updated = await rejectInvitationUseCase(invitationId);
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
      isSubmitting = false;
      notifyListeners();
    }
  }

  Future<InvitationTicketEntity?> loadTicket(String invitationId) async {
    isSubmitting = true;
    notifyListeners();

    try {
      return await fetchInvitationTicketUseCase(invitationId);
    } on ApiException catch (error) {
      errorCode = error.code;
      errorMessage = error.message;
      errorDetails = error.details;
      return null;
    } catch (error) {
      errorMessage = error.toString();
      return null;
    } finally {
      isSubmitting = false;
      notifyListeners();
    }
  }

  List<InvitationEntity> replaceInvitation(InvitationEntity updated) {
    return invitations
        .map((item) => item.id == updated.id ? updated : item)
        .toList();
  }
}
