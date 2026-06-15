import 'package:equatable/equatable.dart';

class DeleteAccountResultEntity extends Equatable {
  const DeleteAccountResultEntity({
    required this.message,
    this.deletedAt,
    this.status = 'deleted',
    this.daysRemaining,
  });

  final String message;
  final DateTime? deletedAt;
  final String status;
  final int? daysRemaining;

  bool get isPendingDeletion => status == 'pending_deletion';

  @override
  List<Object?> get props => [message, deletedAt, status, daysRemaining];
}
