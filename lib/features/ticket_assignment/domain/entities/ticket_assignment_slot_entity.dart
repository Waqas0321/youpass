import 'package:equatable/equatable.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/ticket_slot_status.dart';

class TicketAssignmentSlotEntity extends Equatable {
  const TicketAssignmentSlotEntity({
    required this.id,
    required this.slotNumber,
    required this.label,
    required this.status,
    this.ticketId,
    this.guestName,
    this.guestPhone,
    this.canSend = false,
    this.canCancel = false,
    this.canResend = false,
  });

  final String id;
  final int slotNumber;
  final String label;
  final TicketSlotStatus status;
  final String? ticketId;
  final String? guestName;
  final String? guestPhone;
  final bool canSend;
  final bool canCancel;
  final bool canResend;

  bool get isAssignable {
    switch (status) {
      case TicketSlotStatus.owner:
      case TicketSlotStatus.claimed:
        return false;
      case TicketSlotStatus.available:
      case TicketSlotStatus.pending:
        return true;
    }
  }

  @override
  List<Object?> get props => [
        id,
        slotNumber,
        label,
        status,
        ticketId,
        guestName,
        guestPhone,
        canSend,
        canCancel,
        canResend,
      ];
}
