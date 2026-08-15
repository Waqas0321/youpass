import 'package:flutter/material.dart';

import 'package:youpass/staff_app/core/network/api_client.dart';
import 'package:youpass/staff_app/core/network/api_exception.dart';
import 'package:youpass/staff_app/features/supervisor/data/staff_supervisor_api_service.dart';
import 'package:youpass/staff_app/features/supervisor/domain/models/staff_supervisor_action_history_result.dart';

class StaffSupervisorActionHistoryProvider extends ChangeNotifier {
  StaffSupervisorActionHistoryProvider({
    StaffSupervisorApiService? apiService,
    required String genericError,
  })  : _apiService = apiService ?? StaffSupervisorApiService(ApiClient()),
        _genericError = genericError;

  final StaffSupervisorApiService _apiService;
  final String _genericError;

  StaffSupervisorActionHistoryResult? history;
  bool isLoading = false;
  bool isRefreshing = false;
  String? loadError;

  Future<void> initialize() => loadHistory();

  Future<void> loadHistory({bool refresh = false}) async {
    if (refresh) {
      isRefreshing = true;
      loadError = null;
    } else {
      isLoading = history == null;
      loadError = null;
    }
    notifyListeners();

    try {
      history = await _apiService.getActionHistory(eventId: history?.eventId);
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
}
