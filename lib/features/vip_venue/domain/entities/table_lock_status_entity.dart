import 'package:equatable/equatable.dart';

class TableLockStatusEntity extends Equatable {
  const TableLockStatusEntity({
    this.lockId,
    required this.status,
    this.lockedAt,
    this.expiresAt,
    required this.remainingSeconds,
    required this.isLockedByMe,
  });

  final String? lockId;
  final String status;
  final DateTime? lockedAt;
  final DateTime? expiresAt;
  final int remainingSeconds;
  final bool isLockedByMe;

  bool get isActive =>
      status == 'ACTIVE' && remainingSeconds > 0 && expiresAt != null;

  @override
  List<Object?> get props => [
        lockId,
        status,
        lockedAt,
        expiresAt,
        remainingSeconds,
        isLockedByMe,
      ];
}
