import 'package:youpass/features/ticket_assignment/data/models/ticket_assignment_slot_model.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/assign_ticket_guest_request_entity.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/assign_ticket_guest_result_entity.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/ticket_slot_status.dart';

class AssignTicketGuestRequestModel extends AssignTicketGuestRequestEntity {
  const AssignTicketGuestRequestModel({
    required super.guestName,
    required super.guestPhone,
    required super.countryCode,
  });

  Map<String, dynamic> toJson() {
    final payload = <String, dynamic>{
      'guest_name': guestName,
      'guest_phone': guestPhone,
    };

    if (countryCode.trim().isNotEmpty) {
      payload['country_code'] = countryCode.trim();
    }

    return payload;
  }
}

class AssignTicketGuestResultModel extends AssignTicketGuestResultEntity {
  const AssignTicketGuestResultModel({
    required super.slot,
    super.claimUrl,
    super.whatsappUrl,
    super.message,
  });

  factory AssignTicketGuestResultModel.fromJson(Map<String, dynamic> json) {
    final slotJson = json['slot'];
    return AssignTicketGuestResultModel(
      slot: slotJson is Map<String, dynamic>
          ? TicketAssignmentSlotModel.fromJson(slotJson)
          : const TicketAssignmentSlotModel(
              id: '',
              slotNumber: 0,
              label: '',
              status: TicketSlotStatus.available,
            ),
      claimUrl: json['claim_url']?.toString() ?? json['claimUrl']?.toString(),
      whatsappUrl:
          json['whatsapp_url']?.toString() ?? json['whatsappUrl']?.toString(),
      message: json['message']?.toString(),
    );
  }
}
