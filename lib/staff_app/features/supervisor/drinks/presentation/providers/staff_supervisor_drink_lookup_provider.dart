import 'package:flutter/material.dart';

import 'package:youpass/staff_app/core/network/api_client.dart';
import 'package:youpass/staff_app/core/network/api_exception.dart';
import 'package:youpass/staff_app/features/supervisor/domain/models/staff_supervisor_action.dart';
import 'package:youpass/staff_app/features/supervisor/domain/models/staff_supervisor_consumption_result.dart';
import 'package:youpass/staff_app/features/supervisor/domain/models/staff_supervisor_manual_validation_result.dart';
import 'package:youpass/staff_app/features/supervisor/domain/models/staff_supervisor_qr_override_result.dart';
import 'package:youpass/staff_app/features/supervisor/drinks/data/staff_supervisor_drink_api_service.dart';
import 'package:youpass/staff_app/features/supervisor/drinks/domain/models/staff_supervisor_bar_action_history_result.dart';
import 'package:youpass/staff_app/features/supervisor/drinks/domain/models/staff_supervisor_drink_action_result.dart';
import 'package:youpass/staff_app/features/supervisor/drinks/domain/models/staff_supervisor_drink_search_result.dart';
import 'package:youpass/staff_app/features/supervisor/drinks/presentation/controllers/staff_supervisor_drink_search_controller.dart';

class StaffSupervisorDrinkLookupProvider extends ChangeNotifier {
  StaffSupervisorDrinkLookupProvider({
    StaffSupervisorDrinkApiService? apiService,
    required String genericSearchError,
    required String genericLoadError,
    StaffSupervisorDrinkQuickFilter? searchFilter,
  })  : _apiService = apiService ?? StaffSupervisorDrinkApiService(ApiClient()),
        _genericLoadError = genericLoadError {
    search = StaffSupervisorDrinkSearchController(
      apiService: _apiService,
      filter: searchFilter,
      genericSearchError: genericSearchError,
    );
  }

  final StaffSupervisorDrinkApiService _apiService;
  final String _genericLoadError;

  late final StaffSupervisorDrinkSearchController search;

  StaffSupervisorDrinkSearchDetail? detail;
  bool isLoadingDetail = false;
  String? detailError;
  bool isSubmitting = false;
  String? submitError;
  StaffSupervisorDrinkTemporaryQr? temporaryQr;

  Future<void> onSearchResultSelected(StaffSupervisorDrinkSearchResult result) async {
    await loadDetail(result.redemptionId);
  }

  Future<void> loadDetail(String redemptionId) async {
    isLoadingDetail = true;
    detailError = null;
    detail = null;
    temporaryQr = null;
    submitError = null;
    notifyListeners();

    try {
      detail = await _apiService.getDrinkDetail(redemptionId);
      isLoadingDetail = false;
      notifyListeners();
    } on ApiException catch (error) {
      isLoadingDetail = false;
      detailError = error.message;
      notifyListeners();
    } catch (_) {
      isLoadingDetail = false;
      detailError = _genericLoadError;
      notifyListeners();
    }
  }

  Future<bool> submitCancellation({
    required String pin,
    required String notes,
    required StaffSupervisorCancellationAction action,
  }) async {
    final current = detail;
    if (current == null || isSubmitting) {
      return false;
    }

    isSubmitting = true;
    submitError = null;
    notifyListeners();

    try {
      final result = await _apiService.applyCancellation(
        redemptionId: current.redemptionId,
        pin: pin,
        action: action,
        notes: notes,
      );
      detail = result.detail ?? detail;
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

  Future<bool> submitOverride({
    required String pin,
    required String notes,
    required StaffSupervisorQrOverrideAction action,
  }) async {
    final current = detail;
    if (current == null || isSubmitting) {
      return false;
    }

    isSubmitting = true;
    submitError = null;
    notifyListeners();

    try {
      final result = await _apiService.applyOverride(
        redemptionId: current.redemptionId,
        pin: pin,
        action: action,
        notes: notes,
      );
      detail = result.detail ?? detail;
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

  Future<bool> submitManualValidation({
    required String pin,
    required String notes,
    required StaffSupervisorBarManualValidationAction action,
    required StaffSupervisorManualValidationReason reason,
  }) async {
    final current = detail;
    if (current == null || isSubmitting) {
      return false;
    }

    isSubmitting = true;
    submitError = null;
    notifyListeners();

    try {
      final result = await _apiService.applyManualValidation(
        redemptionId: current.redemptionId,
        pin: pin,
        action: action,
        reason: reason,
        notes: notes,
      );
      detail = result.detail ?? detail;
      temporaryQr = result.temporaryQr;
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

  void clearDetail() {
    detail = null;
    detailError = null;
    submitError = null;
    temporaryQr = null;
    notifyListeners();
  }

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }
}

class StaffSupervisorBarDashboardProvider extends ChangeNotifier {
  StaffSupervisorBarDashboardProvider({
    StaffSupervisorDrinkApiService? apiService,
    required String genericLoadError,
  })  : _apiService = apiService ?? StaffSupervisorDrinkApiService(ApiClient()),
        _genericLoadError = genericLoadError;

  final StaffSupervisorDrinkApiService _apiService;
  final String _genericLoadError;

  StaffSupervisorBarActionHistoryResult? history;
  bool isLoading = false;
  String? loadError;

  List<StaffSupervisorAction> get recentActions {
    final entries = history?.actions ?? const [];
    return entries
        .take(3)
        .map(
          (entry) => StaffSupervisorAction(
            type: entry.actionType,
            title: _titleForEntry(entry),
            timeLabel: entry.timeLabel,
          ),
        )
        .toList();
  }

  String _titleForEntry(StaffSupervisorBarActionHistoryEntry entry) {
    switch (entry.kind) {
      case 'cancel_consumption':
        return 'Consumption cancelled';
      case 'revert_validation':
        return 'Validation reverted';
      case 'release_blocked_qr':
      case 'release_qr':
        return 'QR code released';
      case 'authorize_consumption':
        return 'Manual validation';
      case 'generate_temporary_qr':
        return 'Temporary QR generated';
      case 'reject_consumption':
        return 'Consumption rejected';
      case 'revalidate_qr':
        return 'QR revalidated';
      case 'authorize_reconsumption':
        return 'Reconsumption authorized';
      case 'temporary_unlock':
        return 'Temporary unlock';
      default:
        return entry.kind.replaceAll('_', ' ');
    }
  }

  Future<void> loadRecentActions() async {
    isLoading = true;
    loadError = null;
    notifyListeners();

    try {
      history = await _apiService.getActionHistory(limit: 3);
      isLoading = false;
      notifyListeners();
    } on ApiException catch (error) {
      isLoading = false;
      loadError = error.message;
      notifyListeners();
    } catch (_) {
      isLoading = false;
      loadError = _genericLoadError;
      notifyListeners();
    }
  }
}

class StaffSupervisorBarActionHistoryProvider extends ChangeNotifier {
  StaffSupervisorBarActionHistoryProvider({
    StaffSupervisorDrinkApiService? apiService,
    required String genericLoadError,
  })  : _apiService = apiService ?? StaffSupervisorDrinkApiService(ApiClient()),
        _genericLoadError = genericLoadError;

  final StaffSupervisorDrinkApiService _apiService;
  final String _genericLoadError;

  StaffSupervisorBarActionHistoryResult? history;
  bool isLoading = false;
  String? loadError;

  Future<void> loadHistory() async {
    isLoading = true;
    loadError = null;
    notifyListeners();

    try {
      history = await _apiService.getActionHistory(limit: 50);
      isLoading = false;
      notifyListeners();
    } on ApiException catch (error) {
      isLoading = false;
      loadError = error.message;
      notifyListeners();
    } catch (_) {
      isLoading = false;
      loadError = _genericLoadError;
      notifyListeners();
    }
  }
}
