import 'package:equatable/equatable.dart';

class InvitationClaimEntity extends Equatable {
  const InvitationClaimEntity({
    required this.eventTitle,
    required this.invitedBy,
    required this.guestName,
    required this.steps,
  });

  final String eventTitle;
  final String invitedBy;
  final String guestName;
  final List<String> steps;

  @override
  List<Object?> get props => [eventTitle, invitedBy, guestName, steps];
}
