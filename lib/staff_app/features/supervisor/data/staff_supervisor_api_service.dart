import 'package:youpass/staff_app/core/network/base_api_service.dart';
import 'package:youpass/staff_app/core/network/staff_api_endpoints.dart';
import 'package:youpass/staff_app/features/supervisor/domain/models/staff_supervisor_duplicate_alert.dart';
import 'package:youpass/staff_app/features/supervisor/domain/models/staff_supervisor_entry_manual_validation_result.dart';
import 'package:youpass/staff_app/features/supervisor/domain/models/staff_supervisor_entry_override_result.dart';
import 'package:youpass/staff_app/features/supervisor/domain/models/staff_supervisor_entry_search_result.dart';
import 'package:youpass/staff_app/features/supervisor/domain/models/staff_supervisor_vip_table_result.dart';
import 'package:youpass/staff_app/features/supervisor/domain/models/staff_supervisor_system_status_result.dart';
import 'package:youpass/staff_app/features/supervisor/domain/models/staff_supervisor_action_history_result.dart';

class StaffSupervisorApiService extends BaseApiService {
  StaffSupervisorApiService(super.apiClient);

  Future<void> validatePin({required String pin}) {
    return postVoid(
      StaffApiEndpoints.supervisorValidatePin,
      body: {'pin': pin},
      authenticated: true,
    );
  }

  Future<StaffSupervisorEntrySearchResponse> searchEntries({
    String? query,
    StaffSupervisorEntryQuickFilter? filter,
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
      fromJson: StaffSupervisorEntrySearchResponse.fromJson,
    );
  }

  Future<StaffSupervisorEntrySearchResult> getEntryDetail(String ticketId) {
    return getModel(
      StaffApiEndpoints.supervisorEntryDetail(ticketId),
      authenticated: true,
      fromJson: StaffSupervisorEntrySearchResult.fromJson,
    );
  }

  Future<StaffSupervisorEntryHistoryResponse> getEntryHistory(String ticketId) {
    return getModel(
      StaffApiEndpoints.supervisorEntryHistory(ticketId),
      authenticated: true,
      fromJson: StaffSupervisorEntryHistoryResponse.fromJson,
    );
  }

  Future<StaffSupervisorDuplicateAlert> getDuplicateAlert(String ticketId) {
    return getModel(
      StaffApiEndpoints.supervisorEntryDuplicate(ticketId),
      authenticated: true,
      fromJson: StaffSupervisorDuplicateAlert.fromJson,
    );
  }

  Future<StaffSupervisorDuplicateAlert> getDuplicateAlertByEntryCode(
    String entryCode,
  ) {
    return getModel(
      StaffApiEndpoints.supervisorEntryDuplicateByEntryCode(entryCode),
      authenticated: true,
      fromJson: StaffSupervisorDuplicateAlert.fromJson,
    );
  }

  Future<void> resolveDuplicate({
    required String ticketId,
    required String pin,
    required StaffSupervisorDuplicateAction action,
    required StaffSupervisorDuplicateReason reason,
    required String notes,
  }) {
    return postVoid(
      StaffApiEndpoints.supervisorResolveDuplicate(ticketId),
      body: {
        'pin': pin,
        'action': action.apiValue,
        'reason': reason.apiValue,
        'notes': notes.trim(),
      },
      authenticated: true,
    );
  }

  Future<void> resolveDuplicateByEntryCode({
    required String entryCode,
    required String pin,
    required StaffSupervisorDuplicateAction action,
    required StaffSupervisorDuplicateReason reason,
    required String notes,
  }) {
    return postVoid(
      StaffApiEndpoints.supervisorResolveDuplicateByEntryCode(entryCode),
      body: {
        'pin': pin,
        'action': action.apiValue,
        'reason': reason.apiValue,
        'notes': notes.trim(),
      },
      authenticated: true,
    );
  }

  Future<StaffSupervisorEntryOverrideContext> getEntryOverrideContext(
    String ticketId,
  ) {
    return getModel(
      StaffApiEndpoints.supervisorEntryOverride(ticketId),
      authenticated: true,
      fromJson: StaffSupervisorEntryOverrideContext.fromJson,
    );
  }

  Future<StaffSupervisorEntryOverrideContext> getEntryOverrideContextByEntryCode(
    String entryCode,
  ) {
    return getModel(
      StaffApiEndpoints.supervisorEntryOverrideByEntryCode(entryCode),
      authenticated: true,
      fromJson: StaffSupervisorEntryOverrideContext.fromJson,
    );
  }

  Future<StaffSupervisorEntryOverrideContext> applyEntryOverride({
    required String ticketId,
    required String pin,
    required StaffSupervisorEntryOverrideAction action,
    required String notes,
  }) {
    return postModel(
      StaffApiEndpoints.supervisorEntryOverride(ticketId),
      body: {
        'pin': pin,
        'action': action.apiValue,
        'notes': notes.trim(),
      },
      authenticated: true,
      fromJson: StaffSupervisorEntryOverrideContext.fromJson,
    );
  }

  Future<StaffSupervisorEntryOverrideContext> applyEntryOverrideByEntryCode({
    required String entryCode,
    required String pin,
    required StaffSupervisorEntryOverrideAction action,
    required String notes,
  }) {
    return postModel(
      StaffApiEndpoints.supervisorEntryOverrideByEntryCode(entryCode),
      body: {
        'pin': pin,
        'action': action.apiValue,
        'notes': notes.trim(),
      },
      authenticated: true,
      fromJson: StaffSupervisorEntryOverrideContext.fromJson,
    );
  }

  Future<StaffSupervisorEntryManualValidationContext> getEntryManualValidationContext(
    String ticketId,
  ) {
    return getModel(
      StaffApiEndpoints.supervisorEntryManualValidation(ticketId),
      authenticated: true,
      fromJson: StaffSupervisorEntryManualValidationContext.fromJson,
    );
  }

  Future<StaffSupervisorEntryManualValidationContext>
      getEntryManualValidationContextByEntryCode(String entryCode) {
    return getModel(
      StaffApiEndpoints.supervisorEntryManualValidationByEntryCode(entryCode),
      authenticated: true,
      fromJson: StaffSupervisorEntryManualValidationContext.fromJson,
    );
  }

  Future<StaffSupervisorEntryManualValidationApplyResult> applyEntryManualValidation({
    required String ticketId,
    required String pin,
    required StaffSupervisorEntryManualValidationAction action,
    required StaffSupervisorEntryManualReason reason,
    required String notes,
  }) {
    return postModel(
      StaffApiEndpoints.supervisorEntryManualValidation(ticketId),
      body: {
        'pin': pin,
        'action': action.apiValue,
        'reason': reason.apiValue,
        'notes': notes.trim(),
      },
      authenticated: true,
      fromJson: StaffSupervisorEntryManualValidationApplyResult.fromJson,
    );
  }

  Future<StaffSupervisorEntryManualValidationApplyResult>
      applyEntryManualValidationByEntryCode({
    required String entryCode,
    required String pin,
    required StaffSupervisorEntryManualValidationAction action,
    required StaffSupervisorEntryManualReason reason,
    required String notes,
  }) {
    return postModel(
      StaffApiEndpoints.supervisorEntryManualValidationByEntryCode(entryCode),
      body: {
        'pin': pin,
        'action': action.apiValue,
        'reason': reason.apiValue,
        'notes': notes.trim(),
      },
      authenticated: true,
      fromJson: StaffSupervisorEntryManualValidationApplyResult.fromJson,
    );
  }

  String _buildSearchEndpoint(Map<String, String> params) {
    if (params.isEmpty) {
      return StaffApiEndpoints.supervisorSearchEntries;
    }

    final query = params.entries
        .map(
          (entry) =>
              '${Uri.encodeQueryComponent(entry.key)}=${Uri.encodeQueryComponent(entry.value)}',
        )
        .join('&');

    return '${StaffApiEndpoints.supervisorSearchEntries}?$query';
  }

  Future<StaffSupervisorVipSearchResponse> searchVipTables(String query) {
    final trimmed = query.trim();
    return getModel(
      '${StaffApiEndpoints.supervisorVipTablesSearch}?q=${Uri.encodeQueryComponent(trimmed)}',
      authenticated: true,
      fromJson: StaffSupervisorVipSearchResponse.fromJson,
    );
  }

  Future<StaffSupervisorVipTableResult> getVipTableContext(String orderId) {
    return getModel(
      StaffApiEndpoints.supervisorVipTable(orderId),
      authenticated: true,
      fromJson: StaffSupervisorVipTableResult.fromJson,
    );
  }

  Future<StaffSupervisorVipApplyResult> applyVipTableAction({
    required String orderId,
    required String pin,
    required StaffSupervisorVipAction action,
    required String notes,
    String? guestName,
    String? guestPhone,
    String? slotId,
    String? targetSlotId,
    String? accessLabel,
  }) {
    return postModel(
      StaffApiEndpoints.supervisorVipTableActions(orderId),
      body: {
        'pin': pin,
        'action': action.apiValue,
        'notes': notes.trim(),
        if (guestName != null && guestName.trim().isNotEmpty)
          'guest_name': guestName.trim(),
        if (guestPhone != null && guestPhone.trim().isNotEmpty)
          'guest_phone': guestPhone.trim(),
        if (slotId != null && slotId.trim().isNotEmpty) 'slot_id': slotId.trim(),
        if (targetSlotId != null && targetSlotId.trim().isNotEmpty)
          'target_slot_id': targetSlotId.trim(),
        if (accessLabel != null && accessLabel.trim().isNotEmpty)
          'access_label': accessLabel.trim(),
      },
      authenticated: true,
      fromJson: StaffSupervisorVipApplyResult.fromJson,
    );
  }

  Future<StaffSupervisorSystemStatusResult> getSystemStatus({String? eventId}) {
    final endpoint = eventId == null || eventId.isEmpty
        ? StaffApiEndpoints.supervisorSystemStatus
        : '${StaffApiEndpoints.supervisorSystemStatus}?event_id=${Uri.encodeQueryComponent(eventId)}';

    return getModel(
      endpoint,
      authenticated: true,
      fromJson: StaffSupervisorSystemStatusResult.fromJson,
    );
  }

  Future<StaffSupervisorSystemStatusResult> applySystemStatusAction({
    StaffSupervisorQuickActionKind? action,
    StaffSupervisorSystemBackendAction? backendAction,
    required String pin,
    String? eventId,
    String? notes,
    String? scannerId,
  }) {
    final actionValue = backendAction?.apiValue ?? action!.apiValue;

    return postModel(
      StaffApiEndpoints.supervisorSystemStatusActions,
      body: {
        'pin': pin,
        'action': actionValue,
        if (eventId != null && eventId.isNotEmpty) 'event_id': eventId,
        if (notes != null && notes.trim().isNotEmpty) 'notes': notes.trim(),
        if (scannerId != null && scannerId.trim().isNotEmpty)
          'scanner_id': scannerId.trim(),
      },
      authenticated: true,
      fromJson: StaffSupervisorSystemStatusResult.fromJson,
    );
  }

  Future<StaffSupervisorActionHistoryResult> getActionHistory({
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
        ? StaffApiEndpoints.supervisorActionHistory
        : '${StaffApiEndpoints.supervisorActionHistory}?${params.entries.map((entry) => '${Uri.encodeQueryComponent(entry.key)}=${Uri.encodeQueryComponent(entry.value)}').join('&')}';

    return getModel(
      endpoint,
      authenticated: true,
      fromJson: StaffSupervisorActionHistoryResult.fromJson,
    );
  }
}
