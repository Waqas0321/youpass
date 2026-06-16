import 'package:youpass/features/ticket_assignment/data/models/ticket_assignment_slot_model.dart';
import 'package:youpass/features/ticket_assignment/data/models/ticket_order_assignments_model.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/ticket_slot_status.dart';
import 'package:youpass/l10n/app_localizations.dart';

class TicketAssignmentMockData {
  static TicketOrderAssignmentsModel assignmentsFor(
    AppLocalizations l10n,
    String orderId,
  ) {
    const assignableCount = 10;
    final assignableSlots = List<TicketAssignmentSlotModel>.generate(
      assignableCount,
      (index) {
        final slotNumber = index + 2;
        return TicketAssignmentSlotModel(
          id: 'slot-$slotNumber',
          slotNumber: slotNumber,
          label: 'Entrada $slotNumber',
          status: index == 1
              ? TicketSlotStatus.pending
              : TicketSlotStatus.available,
          guestName: index == 1 ? 'Carla Pérez' : null,
          guestPhone: index == 1 ? '+56 9 8765 4321' : null,
          canSend: index != 1,
          canCancel: index == 1,
          canResend: index == 1,
        );
      },
    );

    return TicketOrderAssignmentsModel(
      orderId: orderId,
      eventTitle: 'Festival Verano 2026',
      quantity: assignableCount + 1,
      availableCount: assignableCount - 1,
      pendingCount: 1,
      canAssignInParts: true,
      slots: [
        const TicketAssignmentSlotModel(
          id: 'slot-owner',
          slotNumber: 1,
          label: 'Entrada 1',
          status: TicketSlotStatus.owner,
        ),
        ...assignableSlots,
      ],
    );
  }
}
