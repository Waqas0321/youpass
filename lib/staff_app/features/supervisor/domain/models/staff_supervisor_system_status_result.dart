enum StaffSupervisorSystemHealthStatus {
  online,
  slow,
  operational,
  disabled,
  disconnected,
}

enum StaffSupervisorGeneralHealthKind {
  system,
  sync,
  database,
  offlineMode,
}

enum StaffSupervisorEventFlowKind {
  general,
  vip,
  backstage,
  rejected,
  duplicates,
}

enum StaffSupervisorSystemAlertKind {
  duplicateQr,
  vipQueueSaturated,
  scannerSlow,
}

enum StaffSupervisorQuickActionKind {
  offlineMode,
  pauseValidations,
  manualAccess,
  blockVip,
  staffAlert,
}

enum StaffSupervisorOperationalRiskLevel { moderate }

enum StaffSupervisorSystemLogKind {
  offlineActivated,
  offlineDeactivated,
  validationsPaused,
  validationsResumed,
  vipBlocked,
  overrideAuthorized,
  scannerRestarted,
  duplicateDetected,
  staffAlert,
}

class StaffSupervisorGeneralHealthItem {
  const StaffSupervisorGeneralHealthItem({
    required this.kind,
    required this.status,
  });

  final StaffSupervisorGeneralHealthKind kind;
  final StaffSupervisorSystemHealthStatus status;

  factory StaffSupervisorGeneralHealthItem.fromJson(Map<String, dynamic> json) {
    return StaffSupervisorGeneralHealthItem(
      kind: _parseGeneralHealthKind(json['kind'] as String?),
      status: _parseHealthStatus(json['status'] as String?),
    );
  }
}

class StaffSupervisorScannerItem {
  const StaffSupervisorScannerItem({
    required this.id,
    required this.status,
  });

  final String id;
  final StaffSupervisorSystemHealthStatus status;

  factory StaffSupervisorScannerItem.fromJson(Map<String, dynamic> json) {
    return StaffSupervisorScannerItem(
      id: json['id'] as String? ?? '',
      status: _parseHealthStatus(json['status'] as String?),
    );
  }
}

class StaffSupervisorEventFlowItem {
  const StaffSupervisorEventFlowItem({
    required this.kind,
    required this.count,
  });

  final StaffSupervisorEventFlowKind kind;
  final int count;

  factory StaffSupervisorEventFlowItem.fromJson(Map<String, dynamic> json) {
    return StaffSupervisorEventFlowItem(
      kind: _parseEventFlowKind(json['kind'] as String?),
      count: json['count'] as int? ?? 0,
    );
  }
}

class StaffSupervisorSystemLogEntry {
  const StaffSupervisorSystemLogEntry({
    required this.time,
    required this.kind,
  });

  final String time;
  final StaffSupervisorSystemLogKind kind;

  factory StaffSupervisorSystemLogEntry.fromJson(Map<String, dynamic> json) {
    return StaffSupervisorSystemLogEntry(
      time: json['time'] as String? ?? '',
      kind: _parseLogKind(json['kind'] as String?),
    );
  }
}

class StaffSupervisorSystemStatusResult {
  const StaffSupervisorSystemStatusResult({
    required this.eventId,
    required this.eventTitle,
    required this.generalHealth,
    required this.scanners,
    required this.alerts,
    required this.eventFlow,
    required this.logs,
    this.riskLevel,
    this.riskReasonKey,
    this.offlineModeEnabled = false,
    this.validationsPaused = false,
    this.vipAccessBlocked = false,
  });

  final String eventId;
  final String eventTitle;
  final List<StaffSupervisorGeneralHealthItem> generalHealth;
  final List<StaffSupervisorScannerItem> scanners;
  final List<StaffSupervisorSystemAlertKind> alerts;
  final List<StaffSupervisorEventFlowItem> eventFlow;
  final List<StaffSupervisorSystemLogEntry> logs;
  final StaffSupervisorOperationalRiskLevel? riskLevel;
  final String? riskReasonKey;
  final bool offlineModeEnabled;
  final bool validationsPaused;
  final bool vipAccessBlocked;

  StaffSupervisorScannerItem? get slowestScanner {
    for (final scanner in scanners) {
      if (scanner.status == StaffSupervisorSystemHealthStatus.slow ||
          scanner.status == StaffSupervisorSystemHealthStatus.disconnected) {
        return scanner;
      }
    }
    return scanners.isNotEmpty ? scanners.first : null;
  }

  factory StaffSupervisorSystemStatusResult.fromJson(Map<String, dynamic> json) {
    final flags = json['operational_flags'] as Map<String, dynamic>? ?? const {};
    return StaffSupervisorSystemStatusResult(
      eventId: json['event_id'] as String? ?? '',
      eventTitle: json['event_title'] as String? ?? '',
      generalHealth: (json['general_health'] as List<dynamic>? ?? const [])
          .map((item) => StaffSupervisorGeneralHealthItem.fromJson(
                item as Map<String, dynamic>,
              ))
          .toList(),
      scanners: (json['scanners'] as List<dynamic>? ?? const [])
          .map((item) =>
              StaffSupervisorScannerItem.fromJson(item as Map<String, dynamic>))
          .toList(),
      alerts: (json['alerts'] as List<dynamic>? ?? const [])
          .map((item) => _parseAlertKind(item as String?))
          .toList(),
      eventFlow: (json['event_flow'] as List<dynamic>? ?? const [])
          .map((item) =>
              StaffSupervisorEventFlowItem.fromJson(item as Map<String, dynamic>))
          .toList(),
      logs: (json['logs'] as List<dynamic>? ?? const [])
          .map((item) =>
              StaffSupervisorSystemLogEntry.fromJson(item as Map<String, dynamic>))
          .toList(),
      riskLevel: json['risk_level'] == null
          ? null
          : StaffSupervisorOperationalRiskLevel.moderate,
      riskReasonKey: json['risk_reason_key'] as String?,
      offlineModeEnabled: flags['offline_mode_enabled'] as bool? ?? false,
      validationsPaused: flags['validations_paused'] as bool? ?? false,
      vipAccessBlocked: flags['vip_access_blocked'] as bool? ?? false,
    );
  }

  static const demo = StaffSupervisorSystemStatusResult(
    eventId: 'demo',
    eventTitle: 'Demo event',
    generalHealth: [
      StaffSupervisorGeneralHealthItem(
        kind: StaffSupervisorGeneralHealthKind.system,
        status: StaffSupervisorSystemHealthStatus.online,
      ),
      StaffSupervisorGeneralHealthItem(
        kind: StaffSupervisorGeneralHealthKind.sync,
        status: StaffSupervisorSystemHealthStatus.slow,
      ),
      StaffSupervisorGeneralHealthItem(
        kind: StaffSupervisorGeneralHealthKind.database,
        status: StaffSupervisorSystemHealthStatus.operational,
      ),
      StaffSupervisorGeneralHealthItem(
        kind: StaffSupervisorGeneralHealthKind.offlineMode,
        status: StaffSupervisorSystemHealthStatus.disabled,
      ),
    ],
    scanners: [
      StaffSupervisorScannerItem(
        id: 'ACCESO-01',
        status: StaffSupervisorSystemHealthStatus.online,
      ),
      StaffSupervisorScannerItem(
        id: 'ACCESO-02',
        status: StaffSupervisorSystemHealthStatus.online,
      ),
      StaffSupervisorScannerItem(
        id: 'VIP-01',
        status: StaffSupervisorSystemHealthStatus.slow,
      ),
      StaffSupervisorScannerItem(
        id: 'BAR-03',
        status: StaffSupervisorSystemHealthStatus.disconnected,
      ),
    ],
    alerts: [
      StaffSupervisorSystemAlertKind.duplicateQr,
      StaffSupervisorSystemAlertKind.vipQueueSaturated,
      StaffSupervisorSystemAlertKind.scannerSlow,
    ],
    eventFlow: [
      StaffSupervisorEventFlowItem(
        kind: StaffSupervisorEventFlowKind.general,
        count: 342,
      ),
      StaffSupervisorEventFlowItem(
        kind: StaffSupervisorEventFlowKind.vip,
        count: 89,
      ),
      StaffSupervisorEventFlowItem(
        kind: StaffSupervisorEventFlowKind.backstage,
        count: 14,
      ),
      StaffSupervisorEventFlowItem(
        kind: StaffSupervisorEventFlowKind.rejected,
        count: 12,
      ),
      StaffSupervisorEventFlowItem(
        kind: StaffSupervisorEventFlowKind.duplicates,
        count: 7,
      ),
    ],
    logs: [
      StaffSupervisorSystemLogEntry(
        time: '00:41',
        kind: StaffSupervisorSystemLogKind.offlineActivated,
      ),
      StaffSupervisorSystemLogEntry(
        time: '00:43',
        kind: StaffSupervisorSystemLogKind.overrideAuthorized,
      ),
      StaffSupervisorSystemLogEntry(
        time: '00:47',
        kind: StaffSupervisorSystemLogKind.scannerRestarted,
      ),
      StaffSupervisorSystemLogEntry(
        time: '00:51',
        kind: StaffSupervisorSystemLogKind.duplicateDetected,
      ),
    ],
    riskLevel: StaffSupervisorOperationalRiskLevel.moderate,
    riskReasonKey: 'vip_flow',
  );
}

StaffSupervisorSystemHealthStatus _parseHealthStatus(String? value) {
  return switch (value) {
    'slow' => StaffSupervisorSystemHealthStatus.slow,
    'operational' => StaffSupervisorSystemHealthStatus.operational,
    'disabled' => StaffSupervisorSystemHealthStatus.disabled,
    'disconnected' => StaffSupervisorSystemHealthStatus.disconnected,
    _ => StaffSupervisorSystemHealthStatus.online,
  };
}

StaffSupervisorGeneralHealthKind _parseGeneralHealthKind(String? value) {
  return switch (value) {
    'sync' => StaffSupervisorGeneralHealthKind.sync,
    'database' => StaffSupervisorGeneralHealthKind.database,
    'offline_mode' => StaffSupervisorGeneralHealthKind.offlineMode,
    _ => StaffSupervisorGeneralHealthKind.system,
  };
}

StaffSupervisorEventFlowKind _parseEventFlowKind(String? value) {
  return switch (value) {
    'vip' => StaffSupervisorEventFlowKind.vip,
    'backstage' => StaffSupervisorEventFlowKind.backstage,
    'rejected' => StaffSupervisorEventFlowKind.rejected,
    'duplicates' => StaffSupervisorEventFlowKind.duplicates,
    _ => StaffSupervisorEventFlowKind.general,
  };
}

StaffSupervisorSystemAlertKind _parseAlertKind(String? value) {
  return switch (value) {
    'vip_queue_saturated' => StaffSupervisorSystemAlertKind.vipQueueSaturated,
    'scanner_slow' => StaffSupervisorSystemAlertKind.scannerSlow,
    _ => StaffSupervisorSystemAlertKind.duplicateQr,
  };
}

StaffSupervisorSystemLogKind _parseLogKind(String? value) {
  return switch (value) {
    'offline_deactivated' => StaffSupervisorSystemLogKind.offlineDeactivated,
    'validations_paused' => StaffSupervisorSystemLogKind.validationsPaused,
    'validations_resumed' => StaffSupervisorSystemLogKind.validationsResumed,
    'vip_blocked' => StaffSupervisorSystemLogKind.vipBlocked,
    'override_authorized' => StaffSupervisorSystemLogKind.overrideAuthorized,
    'scanner_restarted' => StaffSupervisorSystemLogKind.scannerRestarted,
    'duplicate_detected' => StaffSupervisorSystemLogKind.duplicateDetected,
    'staff_alert' => StaffSupervisorSystemLogKind.staffAlert,
    _ => StaffSupervisorSystemLogKind.offlineActivated,
  };
}

extension StaffSupervisorQuickActionKindApi on StaffSupervisorQuickActionKind {
  String get apiValue {
    return switch (this) {
      StaffSupervisorQuickActionKind.offlineMode => 'offline_mode',
      StaffSupervisorQuickActionKind.pauseValidations => 'pause_validations',
      StaffSupervisorQuickActionKind.blockVip => 'block_vip',
      StaffSupervisorQuickActionKind.staffAlert => 'staff_alert',
      StaffSupervisorQuickActionKind.manualAccess => 'manual_access',
    };
  }
}

enum StaffSupervisorSystemBackendAction {
  restartScanner,
}

extension StaffSupervisorSystemBackendActionApi on StaffSupervisorSystemBackendAction {
  String get apiValue {
    return switch (this) {
      StaffSupervisorSystemBackendAction.restartScanner => 'restart_scanner',
    };
  }
}
