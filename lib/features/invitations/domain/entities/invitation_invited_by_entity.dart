import 'package:equatable/equatable.dart';

class InvitationInvitedByEntity extends Equatable {
  const InvitationInvitedByEntity({
    required this.name,
    required this.role,
  });

  final String name;
  final String role;

  bool get isGuest => role == 'guest';

  @override
  List<Object?> get props => [name, role];
}
