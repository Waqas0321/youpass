enum StaffSupervisorVipGuestStatus { entered, pending }

enum StaffSupervisorVipHistoryType { extraGuest, qrReleased, tableModified }

enum StaffSupervisorVipAction {
  authorizeExtraGuest,
  changeAccess,
  moveGuest,
  releaseInvitation,
}

extension StaffSupervisorVipActionApi on StaffSupervisorVipAction {
  String get apiValue {
    return switch (this) {
      StaffSupervisorVipAction.authorizeExtraGuest => 'authorize_extra_guest',
      StaffSupervisorVipAction.changeAccess => 'change_access',
      StaffSupervisorVipAction.moveGuest => 'move_guest',
      StaffSupervisorVipAction.releaseInvitation => 'release_invitation',
    };
  }
}

class StaffSupervisorVipGuest {
  const StaffSupervisorVipGuest({
    required this.slotId,
    required this.name,
    required this.status,
    required this.accessLabel,
    this.entryTime,
    this.isOwner = false,
    this.canMove = false,
    this.canRelease = false,
  });

  final String slotId;
  final String name;
  final StaffSupervisorVipGuestStatus status;
  final String accessLabel;
  final String? entryTime;
  final bool isOwner;
  final bool canMove;
  final bool canRelease;

  factory StaffSupervisorVipGuest.fromJson(Map<String, dynamic> json) {
    return StaffSupervisorVipGuest(
      slotId: json['slot_id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      status: json['status'] == 'entered'
          ? StaffSupervisorVipGuestStatus.entered
          : StaffSupervisorVipGuestStatus.pending,
      entryTime: json['entry_time_label'] as String?,
      accessLabel: json['access_label'] as String? ?? '',
      isOwner: json['is_owner'] as bool? ?? false,
      canMove: json['can_move'] as bool? ?? false,
      canRelease: json['can_release'] as bool? ?? false,
    );
  }
}

class StaffSupervisorVipAvailableSlot {
  const StaffSupervisorVipAvailableSlot({
    required this.slotId,
    required this.slotNumber,
    required this.label,
  });

  final String slotId;
  final int slotNumber;
  final String label;

  factory StaffSupervisorVipAvailableSlot.fromJson(Map<String, dynamic> json) {
    return StaffSupervisorVipAvailableSlot(
      slotId: json['slot_id'] as String? ?? '',
      slotNumber: json['slot_number'] as int? ?? 0,
      label: json['label'] as String? ?? '',
    );
  }
}

class StaffSupervisorVipAccessOption {
  const StaffSupervisorVipAccessOption({
    required this.label,
    required this.tier,
  });

  final String label;
  final String tier;

  factory StaffSupervisorVipAccessOption.fromJson(Map<String, dynamic> json) {
    return StaffSupervisorVipAccessOption(
      label: json['label'] as String? ?? '',
      tier: json['tier'] as String? ?? 'vip',
    );
  }
}

class StaffSupervisorVipHistoryEntry {
  const StaffSupervisorVipHistoryEntry({
    required this.type,
    required this.supervisorName,
    required this.time,
  });

  final StaffSupervisorVipHistoryType type;
  final String supervisorName;
  final String time;

  factory StaffSupervisorVipHistoryEntry.fromJson(Map<String, dynamic> json) {
    return StaffSupervisorVipHistoryEntry(
      type: _parseHistoryType(json['type'] as String?),
      supervisorName: json['supervisor_name'] as String? ?? 'Supervisor',
      time: json['time_label'] as String? ?? '--',
    );
  }

  static StaffSupervisorVipHistoryType _parseHistoryType(String? value) {
    switch (value) {
      case 'qr_released':
        return StaffSupervisorVipHistoryType.qrReleased;
      case 'table_modified':
        return StaffSupervisorVipHistoryType.tableModified;
      case 'extra_guest':
      default:
        return StaffSupervisorVipHistoryType.extraGuest;
    }
  }
}

class StaffSupervisorVipTableResult {
  const StaffSupervisorVipTableResult({
    required this.orderId,
    required this.tableName,
    required this.accessLabel,
    required this.eventName,
    required this.capacity,
    required this.enteredCount,
    required this.pendingCount,
    required this.purchaseResponsible,
    required this.purchaseId,
    required this.guests,
    required this.availableSlots,
    required this.accessOptions,
    required this.history,
    this.isActive = true,
  });

  final String orderId;
  final String tableName;
  final String accessLabel;
  final String eventName;
  final int capacity;
  final int enteredCount;
  final int pendingCount;
  final String purchaseResponsible;
  final String purchaseId;
  final List<StaffSupervisorVipGuest> guests;
  final List<StaffSupervisorVipAvailableSlot> availableSlots;
  final List<StaffSupervisorVipAccessOption> accessOptions;
  final List<StaffSupervisorVipHistoryEntry> history;
  final bool isActive;

  StaffSupervisorVipGuest? guestBySlotId(String? slotId) {
    if (slotId == null || slotId.isEmpty) {
      return null;
    }

    for (final guest in guests) {
      if (guest.slotId == slotId) {
        return guest;
      }
    }
    return null;
  }

  factory StaffSupervisorVipTableResult.fromJson(Map<String, dynamic> json) {
    final guestsJson = json['guests'] as List<dynamic>? ?? const [];
    final historyJson = json['history'] as List<dynamic>? ?? const [];
    final availableSlotsJson = json['available_slots'] as List<dynamic>? ?? const [];
    final accessOptionsJson = json['access_options'] as List<dynamic>? ?? const [];

    return StaffSupervisorVipTableResult(
      orderId: json['order_id'] as String? ?? '',
      tableName: json['table_name'] as String? ?? '',
      accessLabel: json['access_label'] as String? ?? '',
      eventName: json['event_name'] as String? ?? '',
      capacity: json['capacity'] as int? ?? 0,
      enteredCount: json['entered_count'] as int? ?? 0,
      pendingCount: json['pending_count'] as int? ?? 0,
      purchaseResponsible: json['purchase_responsible'] as String? ?? '',
      purchaseId: json['purchase_id'] as String? ?? '',
      isActive: json['is_active'] as bool? ?? true,
      guests: guestsJson
          .whereType<Map<String, dynamic>>()
          .map(StaffSupervisorVipGuest.fromJson)
          .toList(),
      availableSlots: availableSlotsJson
          .whereType<Map<String, dynamic>>()
          .map(StaffSupervisorVipAvailableSlot.fromJson)
          .toList(),
      accessOptions: accessOptionsJson
          .whereType<Map<String, dynamic>>()
          .map(StaffSupervisorVipAccessOption.fromJson)
          .toList(),
      history: historyJson
          .whereType<Map<String, dynamic>>()
          .map(StaffSupervisorVipHistoryEntry.fromJson)
          .toList(),
    );
  }
}

class StaffSupervisorVipSearchResponse {
  const StaffSupervisorVipSearchResponse({required this.results});

  final List<StaffSupervisorVipTableResult> results;

  factory StaffSupervisorVipSearchResponse.fromJson(Map<String, dynamic> json) {
    final resultsJson = json['results'] as List<dynamic>? ?? const [];
    return StaffSupervisorVipSearchResponse(
      results: resultsJson
          .whereType<Map<String, dynamic>>()
          .map(StaffSupervisorVipTableResult.fromJson)
          .toList(),
    );
  }
}

class StaffSupervisorVipApplyResult {
  const StaffSupervisorVipApplyResult({
    required this.applied,
    required this.action,
    required this.context,
  });

  final bool applied;
  final StaffSupervisorVipAction action;
  final StaffSupervisorVipTableResult context;

  factory StaffSupervisorVipApplyResult.fromJson(Map<String, dynamic> json) {
    return StaffSupervisorVipApplyResult(
      applied: json['applied'] as bool? ?? false,
      action: _parseAction(json['action'] as String?),
      context: StaffSupervisorVipTableResult.fromJson(
        json['context'] as Map<String, dynamic>? ?? json,
      ),
    );
  }

  static StaffSupervisorVipAction _parseAction(String? value) {
    switch (value) {
      case 'change_access':
        return StaffSupervisorVipAction.changeAccess;
      case 'move_guest':
        return StaffSupervisorVipAction.moveGuest;
      case 'release_invitation':
        return StaffSupervisorVipAction.releaseInvitation;
      case 'authorize_extra_guest':
      default:
        return StaffSupervisorVipAction.authorizeExtraGuest;
    }
  }
}
