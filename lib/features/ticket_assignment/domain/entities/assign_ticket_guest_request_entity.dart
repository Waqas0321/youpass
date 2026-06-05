import 'package:equatable/equatable.dart';

class AssignTicketGuestRequestEntity extends Equatable {
  const AssignTicketGuestRequestEntity({
    required this.guestName,
    required this.guestPhone,
    this.countryCode = '',
  });

  final String guestName;
  final String guestPhone;
  final String countryCode;

  @override
  List<Object?> get props => [guestName, guestPhone, countryCode];
}
