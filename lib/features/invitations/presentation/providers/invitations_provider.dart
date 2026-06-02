import 'package:flutter/foundation.dart';
import 'package:youpass/core/network/api_exception.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_entity.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_ticket_entity.dart';
import 'package:youpass/features/invitations/domain/entities/payment_method_request_entity.dart';
import 'package:youpass/features/invitations/domain/usecases/confirm_invitation_usecase.dart';
import 'package:youpass/features/invitations/domain/usecases/fetch_invitation_ticket_usecase.dart';
import 'package:youpass/features/invitations/domain/usecases/fetch_invitations_usecase.dart';
import 'package:youpass/features/invitations/domain/usecases/reject_invitation_usecase.dart';
import 'package:youpass/features/invitations/domain/usecases/save_payment_method_usecase.dart';

enum InvitationsStatus { initial, loading, ready, error }

class InvitationsProvider extends ChangeNotifier {
  InvitationsProvider({
    required this.fetchInvitationsUseCase,
    required this.confirmInvitationUseCase,
    required this.rejectInvitationUseCase,
    required this.fetchInvitationTicketUseCase,
    required this.savePaymentMethodUseCase,
  });

  final FetchInvitationsUseCase fetchInvitationsUseCase;
  final ConfirmInvitationUseCase confirmInvitationUseCase;
  final RejectInvitationUseCase rejectInvitationUseCase;
  final FetchInvitationTicketUseCase fetchInvitationTicketUseCase;
  final SavePaymentMethodUseCase savePaymentMethodUseCase;

  InvitationsStatus status = InvitationsStatus.initial;
  List<InvitationEntity> invitations = const [];
  bool isSubmitting = false;
  String? errorMessage;
  String? errorCode;
  bool hasPaymentMethod = false;

  void reset() {
    status = InvitationsStatus.initial;
    invitations = const [];
    isSubmitting = false;
    errorMessage = null;
    errorCode = null;
    hasPaymentMethod = false;
    notifyListeners();
  }

  Future<void> ensureLoaded() async {
    if (status == InvitationsStatus.initial ||
        status == InvitationsStatus.error) {
      await loadInvitations();
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
    notifyListeners();

    try {
      invitations = await fetchInvitationsUseCase();
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

  Future<bool> savePaymentMethod(PaymentMethodRequestEntity request) async {
    isSubmitting = true;
    errorMessage = null;
    errorCode = null;
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
