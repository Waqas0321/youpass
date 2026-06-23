import 'package:youpass/features/ticket_assignment/data/models/ticket_assignment_slot_model.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/ticket_order_assignments_entity.dart';
import 'package:youpass/features/tickets/data/utils/ticket_model_json_reader.dart';
import 'package:youpass/features/tickets/domain/entities/ticket_tier.dart';

class TicketOrderAssignmentsModel extends TicketOrderAssignmentsEntity {
  const TicketOrderAssignmentsModel({
    required super.orderId,
    required super.eventTitle,
    required super.quantity,
    required super.availableCount,
    required super.pendingCount,
    required super.slots,
    super.claimedCount = 0,
    super.tier = TicketTier.general,
    super.canAssignInParts = true,
  });

  factory TicketOrderAssignmentsModel.fromJson(Map<String, dynamic> json) {
    final slotsRaw = json['slots'];
    final slots = slotsRaw is List
        ? slotsRaw
            .whereType<Map<String, dynamic>>()
            .map(TicketAssignmentSlotModel.fromJson)
            .toList()
        : const <TicketAssignmentSlotModel>[];

    return TicketOrderAssignmentsModel(
      orderId: json['order_id']?.toString() ?? json['orderId']?.toString() ?? '',
      eventTitle:
          json['event_title']?.toString() ?? json['eventTitle']?.toString() ?? '',
      tier: TicketModelJsonReader.parseTier(json['tier']),
      quantity: _readInt(json['quantity']),
      availableCount: _readInt(
        json['available_count'] ?? json['availableCount'],
      ),
      pendingCount: _readInt(json['pending_count'] ?? json['pendingCount']),
      claimedCount: _readInt(json['claimed_count'] ?? json['claimedCount']),
      canAssignInParts: _readBool(
        json['can_assign_in_parts'] ?? json['canAssignInParts'],
        fallback: true,
      ),
      slots: slots,
    );
  }

  static int _readInt(Object? value) {
    if (value is num) {
      return value.toInt();
    }
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  static bool _readBool(Object? value, {bool fallback = false}) {
    if (value is bool) {
      return value;
    }
    if (value is num) {
      return value != 0;
    }
    if (value == null) {
      return fallback;
    }
    final normalized = value.toString().toLowerCase();
    return normalized == 'true' || normalized == '1';
  }
}
