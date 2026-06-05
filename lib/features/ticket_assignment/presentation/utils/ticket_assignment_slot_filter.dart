import 'package:youpass/features/ticket_assignment/domain/entities/ticket_assignment_slot_entity.dart';

class TicketAssignmentSlotFilter {
  TicketAssignmentSlotFilter._();

  static List<TicketAssignmentSlotEntity> assignableOnly({
    required List<TicketAssignmentSlotEntity> slots,
  }) {
    return slots.where((slot) => slot.isAssignable).toList(growable: false);
  }
}
