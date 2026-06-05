import 'package:youpass/features/ticket_assignment/domain/entities/ticket_slot_status.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/ticket_assignment_slot_entity.dart';

class TicketAssignmentSlotModel extends TicketAssignmentSlotEntity {
  const TicketAssignmentSlotModel({
    required super.id,
    required super.slotNumber,
    required super.label,
    required super.status,
    super.ticketId,
    super.guestName,
    super.guestPhone,
    super.canSend = false,
    super.canCancel = false,
    super.canResend = false,
  });

  factory TicketAssignmentSlotModel.fromJson(Map<String, dynamic> json) {
    final status = parseTicketSlotStatus(json['status']?.toString());
    final explicitCanSend = json['can_send'] ?? json['canSend'];

    return TicketAssignmentSlotModel(
      id: json['id']?.toString() ?? '',
      slotNumber: _readInt(json['slot_number'] ?? json['slotNumber']),
      label: json['label']?.toString() ?? '',
      status: status,
      ticketId: json['ticket_id']?.toString() ?? json['ticketId']?.toString(),
      guestName: json['guest_name']?.toString() ?? json['guestName']?.toString(),
      guestPhone:
          json['guest_phone']?.toString() ?? json['guestPhone']?.toString(),
      canSend: explicitCanSend == null
          ? status == TicketSlotStatus.available
          : _readBool(explicitCanSend),
      canCancel: _readBool(json['can_cancel'] ?? json['canCancel']),
      canResend: _readBool(json['can_resend'] ?? json['canResend']),
    );
  }

  static TicketSlotStatus parseTicketSlotStatus(String? value) {
    switch (value?.toLowerCase()) {
      case 'owner':
        return TicketSlotStatus.owner;
      case 'pending':
        return TicketSlotStatus.pending;
      case 'claimed':
        return TicketSlotStatus.claimed;
      case 'available':
      default:
        return TicketSlotStatus.available;
    }
  }

  static int _readInt(Object? value) {
    if (value is num) {
      return value.toInt();
    }
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  static bool _readBool(Object? value) {
    if (value is bool) {
      return value;
    }
    if (value is num) {
      return value != 0;
    }
    final normalized = value?.toString().toLowerCase();
    return normalized == 'true' || normalized == '1';
  }
}
