import 'package:youpass/staff_app/core/network/base_api_service.dart';
import 'package:youpass/staff_app/core/network/staff_api_endpoints.dart';
import 'package:youpass/staff_app/features/supervisor/drinks/domain/models/staff_supervisor_bar_action_history_result.dart';
import 'package:youpass/staff_app/features/supervisor/drinks/domain/models/staff_supervisor_drink_action_result.dart';
import 'package:youpass/staff_app/features/supervisor/drinks/domain/models/staff_supervisor_drink_search_result.dart';
import 'package:youpass/staff_app/features/supervisor/domain/models/staff_supervisor_consumption_result.dart';
import 'package:youpass/staff_app/features/supervisor/domain/models/staff_supervisor_manual_validation_result.dart';
import 'package:youpass/staff_app/features/supervisor/domain/models/staff_supervisor_qr_override_result.dart';

class StaffSupervisorDrinkApiService extends BaseApiService {
  StaffSupervisorDrinkApiService(super.apiClient);

  Future<StaffSupervisorDrinkSearchResponse> searchDrinks({
    String? query,
    StaffSupervisorDrinkQuickFilter? filter,
    String? eventId,
  }) {
    final params = <String, String>{};
    final trimmedQuery = query?.trim();
    if (trimmedQuery != null && trimmedQuery.isNotEmpty) {
      params['q'] = trimmedQuery;
    }
    if (filter != null) {
      params['filter'] = filter.apiValue;
    }
    if (eventId != null && eventId.isNotEmpty) {
      params['event_id'] = eventId;
    }

    final endpoint = _buildSearchEndpoint(params);

    return getModel(
      endpoint,
      authenticated: true,
      fromJson: StaffSupervisorDrinkSearchResponse.fromJson,
    );
  }

  Future<StaffSupervisorDrinkSearchDetail> getDrinkDetail(String redemptionId) {
    return getModel(
      StaffApiEndpoints.supervisorDrinkDetail(redemptionId),
      authenticated: true,
      fromJson: StaffSupervisorDrinkSearchDetail.fromJson,
    );
  }

  Future<StaffSupervisorBarActionHistoryResult> getActionHistory({
    String? eventId,
    int? limit,
  }) {
    final params = <String, String>{};
    if (eventId != null && eventId.isNotEmpty) {
      params['event_id'] = eventId;
    }
    if (limit != null) {
      params['limit'] = '$limit';
    }

    final endpoint = params.isEmpty
        ? StaffApiEndpoints.supervisorDrinkActionHistory
        : '${StaffApiEndpoints.supervisorDrinkActionHistory}?${params.entries.map((entry) => '${Uri.encodeQueryComponent(entry.key)}=${Uri.encodeQueryComponent(entry.value)}').join('&')}';

    return getModel(
      endpoint,
      authenticated: true,
      fromJson: StaffSupervisorBarActionHistoryResult.fromJson,
    );
  }

  Future<StaffSupervisorDrinkActionApplyResult> applyCancellation({
    required String redemptionId,
    required String pin,
    required StaffSupervisorCancellationAction action,
    required String notes,
  }) {
    return postModel(
      StaffApiEndpoints.supervisorDrinkCancellation(redemptionId),
      body: {
        'pin': pin,
        'action': action.apiValue,
        'notes': notes.trim(),
      },
      authenticated: true,
      fromJson: StaffSupervisorDrinkActionApplyResult.fromJson,
    );
  }

  Future<StaffSupervisorDrinkActionApplyResult> applyManualValidation({
    required String redemptionId,
    required String pin,
    required StaffSupervisorBarManualValidationAction action,
    required StaffSupervisorManualValidationReason reason,
    required String notes,
  }) {
    return postModel(
      StaffApiEndpoints.supervisorDrinkManualValidation(redemptionId),
      body: {
        'pin': pin,
        'action': action.apiValue,
        'reason': reason.apiValue,
        'notes': notes.trim(),
      },
      authenticated: true,
      fromJson: StaffSupervisorDrinkActionApplyResult.fromJson,
    );
  }

  Future<StaffSupervisorDrinkActionApplyResult> applyOverride({
    required String redemptionId,
    required String pin,
    required StaffSupervisorQrOverrideAction action,
    required String notes,
  }) {
    return postModel(
      StaffApiEndpoints.supervisorDrinkOverride(redemptionId),
      body: {
        'pin': pin,
        'action': action.apiValue,
        'notes': notes.trim(),
      },
      authenticated: true,
      fromJson: StaffSupervisorDrinkActionApplyResult.fromJson,
    );
  }

  String _buildSearchEndpoint(Map<String, String> params) {
    if (params.isEmpty) {
      return StaffApiEndpoints.supervisorSearchDrinks;
    }

    final query = params.entries
        .map(
          (entry) =>
              '${Uri.encodeQueryComponent(entry.key)}=${Uri.encodeQueryComponent(entry.value)}',
        )
        .join('&');

    return '${StaffApiEndpoints.supervisorSearchDrinks}?$query';
  }
}
