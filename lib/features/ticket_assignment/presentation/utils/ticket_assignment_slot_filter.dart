import 'package:youpass/features/ticket_assignment/domain/entities/ticket_assignment_slot_entity.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/ticket_order_assignments_entity.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/ticket_slot_status.dart';

class TicketAssignmentSlotFilter {
  TicketAssignmentSlotFilter._();

  static bool hasManageableSlots(TicketOrderAssignmentsEntity assignments) {
    return assignments.availableCount > 0 || assignments.pendingCount > 0;
  }

  static bool isSentGuest(TicketAssignmentSlotEntity slot) {
    return slot.status == TicketSlotStatus.pending ||
        slot.status == TicketSlotStatus.claimed ||
        slot.canCancel ||
        slot.canResend;
  }

  static bool isOpenForNewGuest(TicketAssignmentSlotEntity slot) {
    return slot.status == TicketSlotStatus.available &&
        slot.canSend &&
        !isSentGuest(slot);
  }

  static List<TicketAssignmentSlotEntity> availableOnly({
    required List<TicketAssignmentSlotEntity> slots,
  }) {
    return slots
        .where(isOpenForNewGuest)
        .toList(growable: false);
  }

  static List<TicketAssignmentSlotEntity> pendingOnly({
    required List<TicketAssignmentSlotEntity> slots,
  }) {
    return slots
        .where((slot) => slot.status == TicketSlotStatus.pending)
        .toList(growable: false);
  }

  static List<TicketAssignmentSlotEntity> claimedOnly({
    required List<TicketAssignmentSlotEntity> slots,
  }) {
    return slots
        .where((slot) => slot.status == TicketSlotStatus.claimed)
        .toList(growable: false);
  }

  static List<TicketAssignmentSlotEntity> sentGuests({
    required List<TicketAssignmentSlotEntity> slots,
  }) {
    return slots.where(isSentGuest).toList(growable: false);
  }

  static int claimedCount(TicketOrderAssignmentsEntity assignments) {
    return claimedOnly(slots: assignments.slots).length;
  }
}
