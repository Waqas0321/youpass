import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/ticket_assignment_slot_entity.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/ticket_order_assignments_entity.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/ticket_slot_status.dart';
import 'package:youpass/features/ticket_assignment/presentation/utils/ticket_assignment_slot_filter.dart';

void main() {
  const owner = TicketAssignmentSlotEntity(
    id: 'owner',
    slotNumber: 1,
    label: 'Entrada 1',
    status: TicketSlotStatus.owner,
  );

  const claimed = TicketAssignmentSlotEntity(
    id: 'claimed',
    slotNumber: 5,
    label: 'Entrada 5',
    status: TicketSlotStatus.claimed,
  );

  const available = TicketAssignmentSlotEntity(
    id: 'slot-a',
    slotNumber: 2,
    label: 'Entrada 2',
    status: TicketSlotStatus.available,
    canSend: true,
  );

  const pending = TicketAssignmentSlotEntity(
    id: 'slot-p',
    slotNumber: 4,
    label: 'Entrada 4',
    status: TicketSlotStatus.pending,
    canSend: false,
    canCancel: true,
    canResend: true,
    guestName: 'usama',
    guestPhone: '+923064875225',
  );

  const mislabeledAvailable = TicketAssignmentSlotEntity(
    id: 'slot-bad',
    slotNumber: 3,
    label: 'Entrada 3',
    status: TicketSlotStatus.available,
    canSend: false,
    canCancel: true,
    canResend: true,
    guestName: 'usama',
    guestPhone: '+923064875225',
  );

  test('availableOnly returns only open slots', () {
    final result = TicketAssignmentSlotFilter.availableOnly(
      slots: const [owner, claimed, available, pending, mislabeledAvailable],
    );

    expect(result, hasLength(1));
    expect(result.first.id, 'slot-a');
  });

  test('sentGuests returns pending and claimed slots', () {
    final result = TicketAssignmentSlotFilter.sentGuests(
      slots: const [owner, claimed, available, pending, mislabeledAvailable],
    );

    expect(
      result.map((slot) => slot.id),
      ['claimed', 'slot-p', 'slot-bad'],
    );
  });

  test('hasManageableSlots is true when available or pending remain', () {
    const assignments = TicketOrderAssignmentsEntity(
      orderId: 'order-1',
      eventTitle: 'Event',
      quantity: 3,
      availableCount: 0,
      pendingCount: 2,
      slots: [owner, pending, pending],
    );

    expect(TicketAssignmentSlotFilter.hasManageableSlots(assignments), isTrue);
  });
}
