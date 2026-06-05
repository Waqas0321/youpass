import 'package:equatable/equatable.dart';
import 'package:youpass/features/ticket_assignment/domain/entities/ticket_assignment_slot_entity.dart';

class AssignTicketGuestResultEntity extends Equatable {
  const AssignTicketGuestResultEntity({
    required this.slot,
    this.claimUrl,
    this.message,
  });

  final TicketAssignmentSlotEntity slot;
  final String? claimUrl;
  final String? message;

  @override
  List<Object?> get props => [slot, claimUrl, message];
}
