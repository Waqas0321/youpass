import 'package:youpass/features/ticket_assignment/domain/entities/invitation_claim_entity.dart';

class InvitationClaimModel extends InvitationClaimEntity {
  const InvitationClaimModel({
    required super.eventTitle,
    required super.invitedBy,
    required super.guestName,
    required super.steps,
  });

  factory InvitationClaimModel.fromJson(Map<String, dynamic> json) {
    final stepsRaw = json['steps'];
    final steps = stepsRaw is List
        ? stepsRaw.map((step) => step.toString()).toList()
        : const <String>[];

    return InvitationClaimModel(
      eventTitle:
          json['event_title']?.toString() ?? json['eventTitle']?.toString() ?? '',
      invitedBy:
          json['invited_by']?.toString() ?? json['invitedBy']?.toString() ?? '',
      guestName:
          json['guest_name']?.toString() ?? json['guestName']?.toString() ?? '',
      steps: steps,
    );
  }
}
