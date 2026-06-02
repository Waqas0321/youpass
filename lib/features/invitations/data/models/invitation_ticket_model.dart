import 'package:youpass/features/invitations/domain/entities/invitation_ticket_entity.dart';

class InvitationTicketModel extends InvitationTicketEntity {
  const InvitationTicketModel({
    required super.invitationId,
    required super.eventTitle,
    required super.dateTimeLabel,
    required super.locationLabel,
    required super.entryCode,
    required super.qrPayload,
  });

  factory InvitationTicketModel.fromJson(
    Map<String, dynamic> json, {
    required String invitationId,
  }) {
    final entryCode = json['entry_code']?.toString() ??
        json['entryCode']?.toString() ??
        json['manual_entry_id']?.toString() ??
        '';

    return InvitationTicketModel(
      invitationId: invitationId,
      eventTitle: json['event_title']?.toString() ??
          json['eventTitle']?.toString() ??
          json['title']?.toString() ??
          '',
      dateTimeLabel: json['date_time_label']?.toString() ??
          json['dateTimeLabel']?.toString() ??
          '',
      locationLabel: json['location']?.toString() ??
          json['location_label']?.toString() ??
          '',
      entryCode: entryCode,
      qrPayload: json['qr_payload']?.toString() ??
          json['qrPayload']?.toString() ??
          json['qr_data']?.toString() ??
          entryCode,
    );
  }
}
