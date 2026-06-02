import 'package:equatable/equatable.dart';

class DeleteAccountResultEntity extends Equatable {
  const DeleteAccountResultEntity({
    required this.message,
    this.deletedAt,
  });

  final String message;
  final DateTime? deletedAt;

  @override
  List<Object?> get props => [message, deletedAt];
}
