import 'package:equatable/equatable.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/ticket_assignment_slot_entity.dart';
import 'package:youpass/features/tickets/domain/entities/ticket_tier.dart';

class TicketOrderAssignmentsEntity extends Equatable {
  const TicketOrderAssignmentsEntity({
    required this.orderId,
    required this.eventTitle,
    required this.quantity,
    required this.availableCount,
    required this.pendingCount,
    required this.slots,
    this.claimedCount = 0,
    this.tier = TicketTier.general,
    this.canAssignInParts = true,
  });

  final String orderId;
  final String eventTitle;
  final int quantity;
  final int availableCount;
  final int pendingCount;
  final int claimedCount;
  final TicketTier tier;
  final bool canAssignInParts;
  final List<TicketAssignmentSlotEntity> slots;

  bool get isVip => tier == TicketTier.vip;

  @override
  List<Object?> get props => [
        orderId,
        eventTitle,
        quantity,
        availableCount,
        pendingCount,
        claimedCount,
        tier,
        canAssignInParts,
        slots,
      ];
}
