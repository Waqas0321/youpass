import 'package:flutter/material.dart';

import 'package:youpass/staff_app/core/network/api_client.dart';
import 'package:youpass/staff_app/core/network/api_exception.dart';
import 'package:youpass/staff_app/features/supervisor/data/staff_supervisor_api_service.dart';
import 'package:youpass/staff_app/features/supervisor/domain/models/staff_supervisor_entry_override_result.dart';
import 'package:youpass/staff_app/features/supervisor/domain/models/staff_supervisor_entry_search_result.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/controllers/staff_supervisor_entry_search_controller.dart';
import 'package:youpass/staff_app/features/supervisor/routes/staff_supervisor_entry_qr_override_route_args.dart';

class StaffSupervisorEntryQrOverrideProvider extends ChangeNotifier {
  StaffSupervisorEntryQrOverrideProvider({
    StaffSupervisorEntryQrOverrideRouteArgs? args,
    StaffSupervisorApiService? apiService,
    required String genericSearchError,
    required String genericLoadError,
  })  : _apiService = apiService ?? StaffSupervisorApiService(ApiClient()),
        _args = args {
    search = StaffSupervisorEntrySearchController(
      apiService: _apiService,
      genericSearchError: genericSearchError,
    );
    _genericLoadError = genericLoadError;

    pinController.addListener(notifyListeners);
    reasonController.addListener(notifyListeners);

    selectedAction = _parseInitialAction(_args?.initialAction);
  }

  final StaffSupervisorApiService _apiService;
  final StaffSupervisorEntryQrOverrideRouteArgs? _args;
  late final String _genericLoadError;

  late final StaffSupervisorEntrySearchController search;

  final TextEditingController pinController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();

  StaffSupervisorEntryOverrideContext? contextData;
  String? loadedEntryCode;
  StaffSupervisorEntryOverrideAction? selectedAction;
  bool isLoadingContext = false;
  bool isSubmitting = false;
  String? contextError;
  String? submitError;

  bool get canSubmit {
    if (contextData == null || isSubmitting) {
      return false;
    }

    return selectedAction != null &&
        pinController.text.length == 4 &&
        reasonController.text.trim().isNotEmpty;
  }

  void initialize() {
    final ticketId = _args?.ticketId;
    final entryCode = _args?.entryCode;
    if (ticketId != null && ticketId.isNotEmpty) {
      loadContext(ticketId: ticketId);
    } else if (entryCode != null && entryCode.isNotEmpty) {
      loadContext(entryCode: entryCode);
    }
  }

  void onSearchResultSelected(StaffSupervisorEntrySearchResult result) {
    loadedEntryCode = null;
    loadContext(ticketId: result.ticketId);
  }

  void selectAction(StaffSupervisorEntryOverrideAction action) {
    selectedAction = action;
    notifyListeners();
  }

  void notifyFormChanged() {
    notifyListeners();
  }

  StaffSupervisorEntryOverrideAction? _parseInitialAction(String? value) {
    switch (value) {
      case 'release_qr':
        return StaffSupervisorEntryOverrideAction.releaseQr;
      case 'revalidate_qr':
        return StaffSupervisorEntryOverrideAction.revalidateQr;
      case 'revert_validation':
        return StaffSupervisorEntryOverrideAction.revertValidation;
      case 'authorize_reentry':
        return StaffSupervisorEntryOverrideAction.authorizeReentry;
      case 'temporary_unlock':
        return StaffSupervisorEntryOverrideAction.temporaryUnlock;
      default:
        return null;
    }
  }

  Future<void> loadContext({
    String? ticketId,
    String? entryCode,
  }) async {
    isLoadingContext = true;
    contextError = null;
    contextData = null;
    loadedEntryCode = entryCode;
    notifyListeners();

    try {
      final loaded = entryCode != null && entryCode.isNotEmpty
          ? await _apiService.getEntryOverrideContextByEntryCode(entryCode)
          : await _apiService.getEntryOverrideContext(ticketId!);

      contextData = loaded;
      isLoadingContext = false;
      notifyListeners();
    } on ApiException catch (error) {
      isLoadingContext = false;
      contextError = error.message;
      notifyListeners();
    } catch (_) {
      isLoadingContext = false;
      contextError = _genericLoadError;
      notifyListeners();
    }
  }

  Future<bool> submit() async {
    final data = contextData;
    final action = selectedAction;

    if (data == null || action == null || !canSubmit) {
      return false;
    }

    isSubmitting = true;
    submitError = null;
    notifyListeners();

    try {
      final notes = reasonController.text.trim();
      if (loadedEntryCode != null && loadedEntryCode!.isNotEmpty) {
        await _apiService.applyEntryOverrideByEntryCode(
          entryCode: loadedEntryCode!,
          pin: pinController.text,
          action: action,
          notes: notes,
        );
      } else {
        await _apiService.applyEntryOverride(
          ticketId: data.ticketId,
          pin: pinController.text,
          action: action,
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
