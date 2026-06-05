import 'package:equatable/equatable.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/ticket_assignment_slot_entity.dart';

class TicketOrderAssignmentsEntity extends Equatable {
  const TicketOrderAssignmentsEntity({
    required this.orderId,
    required this.eventTitle,
    required this.quantity,
    required this.availableCount,
    required this.pendingCount,
    required this.slots,
    this.canAssignInParts = true,
  });

  final String orderId;
  final String eventTitle;
  final int quantity;
  final int availableCount;
  final int pendingCount;
  final bool canAssignInParts;
  final List<TicketAssignmentSlotEntity> slots;

  @override
  List<Object?> get props => [
        orderId,
        eventTitle,
        quantity,
        availableCount,
        pendingCount,
        canAssignInParts,
        slots,
      ];
}
