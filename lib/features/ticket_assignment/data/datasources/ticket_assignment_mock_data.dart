import 'package:youpass/features/ticket_assignment/data/models/ticket_assignment_slot_model.dart';
import 'package:youpass/features/ticket_assignment/data/models/ticket_order_assignments_model.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/ticket_slot_status.dart';
import 'package:youpass/l10n/app_localizations.dart';

class TicketAssignmentMockData {
  static TicketOrderAssignmentsModel assignmentsFor(
    AppLocalizations l10n,
    String orderId,
  ) {
    return TicketOrderAssignmentsModel(
      orderId: orderId,
      eventTitle: 'Festival Verano 2026',
      quantity: 3,
      availableCount: 2,
      pendingCount: 0,
      canAssignInParts: true,
      slots: [
        const TicketAssignmentSlotModel(
          id: 'slot-owner',
          slotNumber: 1,
          label: 'Entrada 1',
          status: TicketSlotStatus.owner,
        ),
        TicketAssignmentSlotModel(
          id: 'slot-2',
          slotNumber: 2,
          label: 'Entrada 2',
          status: TicketSlotStatus.available,
          ticketId: orderId,
          canSend: true,
        ),
        const TicketAssignmentSlotModel(
          id: 'slot-3',
          slotNumber: 3,
          label: 'Entrada 3',
          status: TicketSlotStatus.available,
          canSend: true,
        ),
      ],
    );
  }
}
