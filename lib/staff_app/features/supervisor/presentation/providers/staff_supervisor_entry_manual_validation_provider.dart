import 'package:flutter/material.dart';

import 'package:youpass/staff_app/core/network/api_client.dart';
import 'package:youpass/staff_app/core/network/api_exception.dart';
import 'package:youpass/staff_app/features/supervisor/data/staff_supervisor_api_service.dart';
import 'package:youpass/staff_app/features/supervisor/domain/models/staff_supervisor_entry_manual_validation_result.dart';
import 'package:youpass/staff_app/features/supervisor/domain/models/staff_supervisor_entry_search_result.dart';
import 'package:youpass/staff_app/features/supervisor/presentation/controllers/staff_supervisor_entry_search_controller.dart';
import 'package:youpass/staff_app/features/supervisor/routes/staff_supervisor_entry_manual_validation_route_args.dart';

class StaffSupervisorEntryManualValidationProvider extends ChangeNotifier {
  StaffSupervisorEntryManualValidationProvider({
    StaffSupervisorEntryManualValidationRouteArgs? args,
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
    otherReasonController.addListener(notifyListeners);
  }

  final StaffSupervisorApiService _apiService;
  final StaffSupervisorEntryManualValidationRouteArgs? _args;
  late final String _genericLoadError;

  late final StaffSupervisorEntrySearchController search;

  final TextEditingController pinController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();
  final TextEditingController otherReasonController = TextEditingController();

  StaffSupervisorEntryManualValidationContext? contextData;
  String? loadedEntryCode;
  StaffSupervisorEntryManualReason? selectedReason;
  StaffSupervisorEntryManualValidationAction? selectedAction;
  bool isLoadingContext = false;
  bool isSubmitting = false;
  String? contextError;
  String? submitError;

  bool get canSubmit {
    if (contextData == null || !contextData!.isPending || isSubmitting) {
      return false;
    }

    final hasOtherDetails = selectedReason != StaffSupervisorEntryManualReason.other ||
        otherReasonController.text.trim().isNotEmpty;

    return selectedAction != null &&
        selectedReason != null &&
        hasOtherDetails &&
        pinController.text.length == 4 &&
        reasonController.text.trim().isNotEmpty;
  }

  void selectAction(StaffSupervisorEntryManualValidationAction action) {
    selectedAction = action;
    notifyListeners();
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

  void selectReason(StaffSupervisorEntryManualReason reason) {
    selectedReason = reason;
    notifyListeners();
  }

  void notifyFormChanged() {
    notifyListeners();
  }

  Future<void> loadContext({
    String? ticketId,
    String? entryCode,
  }) async {
    isLoadingContext = true;
    contextError = null;
    contextData = null;
    loadedEntryCode = entryCode;
    selectedReason = null;
    selectedAction = null;
    notifyListeners();

    try {
      final loaded = entryCode != null && entryCode.isNotEmpty
          ? await _apiService.getEntryManualValidationContextByEntryCode(entryCode)
          : await _apiService.getEntryManualValidationContext(ticketId!);

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

  String buildNotes() {
    final notes = reasonController.text.trim();
    if (selectedReason != StaffSupervisorEntryManualReason.other) {
      return notes;
    }

    final other = otherReasonController.text.trim();
    if (other.isEmpty) {
      return notes;
    }

    return '$notes — $other';
  }

  Future<StaffSupervisorEntryManualValidationApplyResult?> submit() async {
    final data = contextData;
    final reason = selectedReason;
    final action = selectedAction;

    if (data == null || reason == null || action == null || !canSubmit) {
      return null;
    }

    isSubmitting = true;
    submitError = null;
    notifyListeners();

    try {
      final notes = buildNotes();
      final StaffSupervisorEntryManualValidationApplyResult result;
      if (loadedEntryCode != null && loadedEntryCode!.isNotEmpty) {
        result = await _apiService.applyEntryManualValidationByEntryCode(
          entryCode: loadedEntryCode!,
          pin: pinController.text,
          action: action,
          reason: reason,
          notes: notes,
        );
      } else {
        result = await _apiService.applyEntryManualValidation(
          ticketId: data.ticketId,
          pin: pinController.text,
          action: action,
          reason: reason,
          notes: notes,
        );
      }

      contextData = result.context;
      isSubmitting = false;
      notifyListeners();
      return result;
    } on ApiException catch (error) {
      isSubmitting = false;
      submitError = error.message;
      notifyListeners();
      return null;
    } catch (_) {
      isSubmitting = false;
      submitError = _genericLoadError;
      notifyListeners();
      return null;
    }
  }

  @override
  void dispose() {
    search.dispose();
    pinController.dispose();
    reasonController.dispose();
    otherReasonController.dispose();
    super.dispose();
  }
}
