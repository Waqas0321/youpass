import 'package:equatable/equatable.dart';

class InvitationTicketEntity extends Equatable {
  const InvitationTicketEntity({
    required this.invitationId,
    required this.eventTitle,
    required this.dateTimeLabel,
    required this.locationLabel,
    required this.entryCode,
    required this.qrPayload,
    this.seatLabel,
  });

  final String invitationId;
  final String eventTitle;
  final String dateTimeLabel;
  final String locationLabel;
  final String entryCode;
  final String qrPayload;
  final String? seatLabel;

  @override
  List<Object?> get props => [
        invitationId,
        eventTitle,
        dateTimeLabel,
        locationLabel,
        entryCode,
        qrPayload,
        seatLabel,
      ];
}
