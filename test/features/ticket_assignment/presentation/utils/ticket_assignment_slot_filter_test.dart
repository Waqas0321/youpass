import 'package:flutter_test/flutter_test.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/ticket_assignment_slot_entity.dart';
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
    canSend: false,
  );

  const pending = TicketAssignmentSlotEntity(
    id: 'slot-p',
    slotNumber: 4,
    label: 'Entrada 4',
    status: TicketSlotStatus.pending,
  );

  test('assignableOnly excludes owner and claimed slots', () {
    final result = TicketAssignmentSlotFilter.assignableOnly(
      slots: const [owner, claimed, available, pending],
    );

    expect(result, hasLength(2));
    expect(result.map((slot) => slot.id), ['slot-a', 'slot-p']);
  });

  test('assignableOnly keeps available slots even when canSend is false', () {
    final result = TicketAssignmentSlotFilter.assignableOnly(
      slots: const [available],
    );

    expect(result, hasLength(1));
  });
}
