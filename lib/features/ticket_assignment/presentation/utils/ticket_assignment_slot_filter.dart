import 'package:youpass/features/ticket_assignment/domain/entities/ticket_assignment_slot_entity.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/ticket_order_assignments_entity.dart';

class TicketAssignmentSlotFilter {
  TicketAssignmentSlotFilter._();

  static List<TicketAssignmentSlotEntity> assignableOnly({
    required List<TicketAssignmentSlotEntity> slots,
  }) {
    return slots.where((slot) => slot.isAssignable).toList(growable: false);
  }

  static int assignableCount(TicketOrderAssignmentsEntity assignments) {
    final fromSlots = assignableOnly(slots: assignments.slots).length;
    if (fromSlots > 0) {
      return fromSlots;
    }
    return assignments.availableCount + assignments.pendingCount;
  }
}
