import 'package:flutter/material.dart';

import 'package:youpass/staff_app/core/network/api_client.dart';
import 'package:youpass/staff_app/core/network/api_exception.dart';
import 'package:youpass/staff_app/features/supervisor/data/staff_supervisor_api_service.dart';
import 'package:youpass/staff_app/features/supervisor/domain/models/staff_supervisor_system_status_result.dart';

class StaffSupervisorSystemStatusProvider extends ChangeNotifier {
  StaffSupervisorSystemStatusProvider({
    StaffSupervisorApiService? apiService,
    required String genericError,
  })  : _apiService = apiService ?? StaffSupervisorApiService(ApiClient()),
        _genericError = genericError;

  final StaffSupervisorApiService _apiService;
  final String _genericError;

  StaffSupervisorSystemStatusResult? status;
  bool isLoading = false;
  bool isRefreshing = false;
  bool isSubmittingAction = false;
  String? loadError;
  String? actionError;

  Future<void> initialize() => loadStatus();

  Future<void> loadStatus({bool refresh = false}) async {
    if (refresh) {
      isRefreshing = true;
      loadError = null;
    } else {
      isLoading = status == null;
      loadError = null;
    }
    notifyListeners();

    try {
      status = await _apiService.getSystemStatus(eventId: status?.eventId);
      loadError = null;
    } on ApiException catch (error) {
      loadError = error.message.isNotEmpty ? error.message : _genericError;
    } catch (_) {
      loadError = _genericError;
    } finally {
      isLoading = false;
      isRefreshing = false;
      notifyListeners();
    }
  }

  Future<bool> applyQuickAction({
    required StaffSupervisorQuickActionKind action,
    required String pin,
    String? notes,
    String? scannerId,
  }) async {
    isSubmittingAction = true;
    actionError = null;
    notifyListeners();

    try {
      status = await _apiService.applySystemStatusAction(
        action: action,
        pin: pin,
        eventId: status?.eventId,
        notes: notes,
        scannerId: scannerId,
      );
      actionError = null;
      return true;
    } on ApiException catch (error) {
      actionError = error.message.isNotEmpty ? error.message : _genericError;
      return false;
    } catch (_) {
      actionError = _genericError;
      return false;
    } finally {
      isSubmittingAction = false;
      notifyListeners();
    }
  }

  Future<bool> restartScanner({required String pin}) async {
    final scanner = status?.slowestScanner;
    if (scanner == null) {
      actionError = _genericError;
      notifyListeners();
      return false;
    }

    isSubmittingAction = true;
    actionError = null;
    notifyListeners();

    try {
      status = await _apiService.applySystemStatusAction(
        backendAction: StaffSupervisorSystemBackendAction.restartScanner,
        pin: pin,
        eventId: status?.eventId,
        scannerId: scanner.id,
      );
      actionError = null;
      return true;
    } on ApiException catch (error) {
      actionError = error.message.isNotEmpty ? error.message : _genericError;
      return false;
    } catch (_) {
      actionError = _genericError;
      return false;
    } finally {
      isSubmittingAction = false;
      notifyListeners();
    }
  }
}
