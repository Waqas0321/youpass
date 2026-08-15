import 'package:flutter/material.dart';

import 'package:youpass/staff_app/core/network/api_client.dart';
import 'package:youpass/staff_app/core/network/api_exception.dart';
import 'package:youpass/staff_app/features/supervisor/data/staff_supervisor_api_service.dart';
import 'package:youpass/staff_app/features/supervisor/domain/models/staff_supervisor_duplicate_alert.dart';
import 'package:youpass/staff_app/features/supervisor/domain/models/staff_supervisor_entry_search_result.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/controllers/staff_supervisor_entry_search_controller.dart';
import 'package:youpass/staff_app/features/supervisor/routes/staff_supervisor_resolve_duplicate_route_args.dart';

class StaffSupervisorResolveDuplicateProvider extends ChangeNotifier {
  StaffSupervisorResolveDuplicateProvider({
    StaffSupervisorResolveDuplicateRouteArgs? args,
    StaffSupervisorApiService? apiService,
    required String genericSearchError,
    required String genericLoadError,
    required String duplicateNotFoundError,
  })  : _apiService = apiService ?? StaffSupervisorApiService(ApiClient()),
        _args = args {
    search = StaffSupervisorEntrySearchController(
      apiService: _apiService,
      filter: StaffSupervisorEntryQuickFilter.duplicate,
      genericSearchError: genericSearchError,
    );
    _genericLoadError = genericLoadError;
    _duplicateNotFoundError = duplicateNotFoundError;

    pinController.addListener(notifyListeners);
    reasonController.addListener(notifyListeners);
  }

  final StaffSupervisorApiService _apiService;
  final StaffSupervisorResolveDuplicateRouteArgs? _args;
  late final String _genericLoadError;
  late final String _duplicateNotFoundError;

  late final StaffSupervisorEntrySearchController search;

  final TextEditingController pinController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();

  StaffSupervisorDuplicateAlert? alert;
  String? loadedEntryCode;
  StaffSupervisorDuplicateReason? selectedReason;
  StaffSupervisorDuplicateAction? selectedAction;
  bool isLoadingAlert = false;
  bool isSubmitting = false;
  String? alertError;
  String? submitError;

  bool get canSubmit {
    if (alert == null || !alert!.isPending || isSubmitting) {
      return false;
    }

    return selectedAction != null &&
        selectedReason != null &&
        pinController.text.length == 4 &&
        reasonController.text.trim().isNotEmpty;
  }

  void initialize() {
    final ticketId = _args?.ticketId;
    final entryCode = _args?.entryCode;
    if (ticketId != null && ticketId.isNotEmpty) {
      loadAlert(ticketId: ticketId);
    } else if (entryCode != null && entryCode.isNotEmpty) {
      loadAlert(entryCode: entryCode);
    }
  }

  void onSearchResultSelected(StaffSupervisorEntrySearchResult result) {
    loadAlert(ticketId: result.ticketId);
  }

  void selectReason(StaffSupervisorDuplicateReason reason) {
    selectedReason = reason;
    notifyListeners();
  }

  void selectAction(StaffSupervisorDuplicateAction action) {
    selectedAction = action;
    notifyListeners();
  }

  void notifyFormChanged() {
    notifyListeners();
  }

  Future<void> loadAlert({
    String? ticketId,
    String? entryCode,
  }) async {
    isLoadingAlert = true;
    alertError = null;
    alert = null;
    loadedEntryCode = entryCode;
    selectedAction = null;
    selectedReason = null;
    notifyListeners();

    try {
      final loaded = entryCode != null && entryCode.isNotEmpty
          ? await _apiService.getDuplicateAlertByEntryCode(entryCode)
          : await _apiService.getDuplicateAlert(ticketId!);

      alert = loaded;
      isLoadingAlert = false;
      notifyListeners();
    } on ApiException catch (error) {
      isLoadingAlert = false;
      alertError = error.code == 'DUPLICATE_NOT_FOUND'
          ? _duplicateNotFoundError
          : error.message;
      notifyListeners();
    } catch (_) {
      isLoadingAlert = false;
      alertError = _genericLoadError;
      notifyListeners();
    }
  }

  Future<bool> submit() async {
    final currentAlert = alert;
    final action = selectedAction;
    final reason = selectedReason;

    if (currentAlert == null || action == null || reason == null || !canSubmit) {
      return false;
    }

    isSubmitting = true;
    submitError = null;
    notifyListeners();

    try {
      final notes = reasonController.text.trim();
      if (loadedEntryCode != null && loadedEntryCode!.isNotEmpty) {
        await _apiService.resolveDuplicateByEntryCode(
          entryCode: loadedEntryCode!,
          pin: pinController.text,
          action: action,
          reason: reason,
          notes: notes,
        );
      } else {
        await _apiService.resolveDuplicate(
          ticketId: currentAlert.ticketId,
          pin: pinController.text,
          action: action,
          reason: reason,
          notes: notes,
        );
      }

      isSubmitting = false;
      notifyListeners();
      return true;
    } on ApiException catch (error) {
      isSubmitting = false;
      submitError = error.message;
      notifyListeners();
      return false;
    } catch (_) {
      isSubmitting = false;
      submitError = _genericLoadError;
      notifyListeners();
      return false;
    }
  }

  @override
  void dispose() {
    search.dispose();
    pinController.dispose();
    reasonController.dispose();
    super.dispose();
  }
}
