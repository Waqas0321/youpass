enum StaffSupervisorEntryStatus {
  validated,
  pending,
  used,
  blocked,
  error,
}

enum StaffSupervisorEntryQuickFilter {
  vip,
  used,
  error,
  duplicate,
}

enum StaffSupervisorEntryEventKind {
  validated,
  reentry,
  supervisor,
  unknown,
}

class StaffSupervisorEntryEventLog {
  const StaffSupervisorEntryEventLog({
    required this.title,
    required this.timeLabel,
    required this.detail,
    required this.kind,
    this.isSuccess = false,
    this.isReentry = false,
    this.isSupervisor = false,
  });

  final String title;
  final String timeLabel;
  final String detail;
  final StaffSupervisorEntryEventKind kind;
  final bool isSuccess;
  final bool isReentry;
  final bool isSupervisor;

  factory StaffSupervisorEntryEventLog.fromJson(Map<String, dynamic> json) {
    final kind = _parseKind(json['kind'] as String?);
    return StaffSupervisorEntryEventLog(
      title: json['title'] as String? ?? '',
      timeLabel: json['time_label'] as String? ?? '',
      detail: json['detail'] as String? ?? '',
      kind: kind,
      isSuccess: kind == StaffSupervisorEntryEventKind.validated,
      isReentry: kind == StaffSupervisorEntryEventKind.reentry,
      isSupervisor: kind == StaffSupervisorEntryEventKind.supervisor,
    );
  }

  static StaffSupervisorEntryEventKind _parseKind(String? value) {
    switch (value) {
      case 'validated':
        return StaffSupervisorEntryEventKind.validated;
      case 'reentry':
        return StaffSupervisorEntryEventKind.reentry;
      case 'supervisor':
        return StaffSupervisorEntryEventKind.supervisor;
      default:
        return StaffSupervisorEntryEventKind.unknown;
    }
  }
}

class StaffSupervisorEntrySearchResult {
  const StaffSupervisorEntrySearchResult({
    required this.invitationId,
    required this.ticketId,
    required this.qrPayload,
    required this.guestName,
    required this.vipTags,
    required this.qrId,
    required this.purchaseId,
    required this.status,
    required this.entryTimeLabel,
    required this.validatorId,
    required this.vipTableLabel,
    required this.associatedEntriesLabel,
    required this.isVip,
    required this.eventTitle,
    required this.recentEvents,
    this.purchaseStatus,
    this.ticketTypeLabel,
    this.accessPoint,
  });

  final String invitationId;
  final String ticketId;
  final String qrPayload;
  final String guestName;
  final List<String> vipTags;
  final String qrId;
  final String purchaseId;
  final String? purchaseStatus;
  final String? ticketTypeLabel;
  final String? accessPoint;
  final StaffSupervisorEntryStatus status;
  final String entryTimeLabel;
  final String validatorId;
  final String vipTableLabel;
  final String associatedEntriesLabel;
  final bool isVip;
  final String eventTitle;
  final List<StaffSupervisorEntryEventLog> recentEvents;

  factory StaffSupervisorEntrySearchResult.fromJson(Map<String, dynamic> json) {
    return StaffSupervisorEntrySearchResult(
      invitationId: json['invitation_id'] as String? ?? '',
      ticketId: json['ticket_id'] as String? ?? '',
      qrPayload: json['qr_payload'] as String? ?? '',
      guestName: json['guest_name'] as String? ?? '',
      vipTags: (json['vip_tags'] as List<dynamic>? ?? const [])
          .map((item) => item.toString())
          .toList(),
      qrId: json['qr_id'] as String? ?? '',
      purchaseId: json['purchase_id'] as String? ?? '—',
      purchaseStatus: json['purchase_status'] as String?,
      ticketTypeLabel: json['ticket_type_label'] as String?,
      accessPoint: json['access_point'] as String?,
      status: _parseStatus(json['status'] as String?),
      entryTimeLabel: json['entry_time_label'] as String? ?? '—',
      validatorId: json['validator_label'] as String? ?? '—',
      vipTableLabel: json['vip_table_label'] as String? ?? '—',
      associatedEntriesLabel: json['associated_entries_label'] as String? ?? '—',
      isVip: json['is_vip'] as bool? ?? false,
      eventTitle: json['event_title'] as String? ?? '',
      recentEvents: (json['recent_events'] as List<dynamic>? ?? const [])
          .whereType<Map<String, dynamic>>()
          .map(StaffSupervisorEntryEventLog.fromJson)
          .toList(),
    );
  }

  static StaffSupervisorEntryStatus _parseStatus(String? value) {
    switch (value) {
      case 'validated':
        return StaffSupervisorEntryStatus.validated;
      case 'used':
        return StaffSupervisorEntryStatus.used;
      case 'pending':
        return StaffSupervisorEntryStatus.pending;
      case 'error':
        return StaffSupervisorEntryStatus.error;
      case 'blocked':
        return StaffSupervisorEntryStatus.blocked;
      default:
        return StaffSupervisorEntryStatus.pending;
    }
  }
}

class StaffSupervisorEntrySearchResponse {
  const StaffSupervisorEntrySearchResponse({
    required this.results,
    required this.total,
  });

  final List<StaffSupervisorEntrySearchResult> results;
  final int total;

  factory StaffSupervisorEntrySearchResponse.fromJson(Map<String, dynamic> json) {
    final rawResults = json['results'];
    final resultsList = rawResults is List<dynamic> ? rawResults : const [];

    return StaffSupervisorEntrySearchResponse(
      results: resultsList
          .whereType<Map<String, dynamic>>()
          .map(StaffSupervisorEntrySearchResult.fromJson)
          .toList(),
      total: _parseTotal(json['total'], resultsList.length),
    );
  }

  static int _parseTotal(Object? value, int fallback) {
    if (value is int) {
      return value;
    }
    if (value is num) {
      return value.toInt();
    }
    return fallback;
  }
}

class StaffSupervisorEntryHistoryResponse {
  const StaffSupervisorEntryHistoryResponse({
    required this.ticketId,
    required this.invitationId,
    required this.guestName,
    required this.eventTitle,
    required this.qrId,
    required this.events,
    required this.total,
  });

  final String ticketId;
  final String invitationId;
  final String guestName;
  final String eventTitle;
  final String qrId;
  final List<StaffSupervisorEntryEventLog> events;
  final int total;

  factory StaffSupervisorEntryHistoryResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    final rawEvents = json['events'];
    final eventsList = rawEvents is List<dynamic> ? rawEvents : const [];

    return StaffSupervisorEntryHistoryResponse(
      ticketId: json['ticket_id'] as String? ?? '',
      invitationId: json['invitation_id'] as String? ?? '',
      guestName: json['guest_name'] as String? ?? '',
      eventTitle: json['event_title'] as String? ?? '',
      qrId: json['qr_id'] as String? ?? '',
      events: eventsList
          .whereType<Map<String, dynamic>>()
          .map(StaffSupervisorEntryEventLog.fromJson)
          .toList(),
      total: StaffSupervisorEntrySearchResponse._parseTotal(
        json['total'],
        eventsList.length,
      ),
    );
  }
}

extension StaffSupervisorEntryQuickFilterApi on StaffSupervisorEntryQuickFilter {
  String get apiValue {
    switch (this) {
      case StaffSupervisorEntryQuickFilter.vip:
        return 'vip';
      case StaffSupervisorEntryQuickFilter.used:
        return 'used';
      case StaffSupervisorEntryQuickFilter.error:
        return 'error';
      case StaffSupervisorEntryQuickFilter.duplicate:
        return 'duplicate';
    }
  }
}
