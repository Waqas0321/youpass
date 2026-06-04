import 'package:equatable/equatable.dart';

class ApiErrorDetailsModel extends Equatable {
  const ApiErrorDetailsModel({
    this.unlockAt,
    this.retryAfterSeconds,
  });

  final DateTime? unlockAt;
  final int? retryAfterSeconds;

  factory ApiErrorDetailsModel.fromMap(Map<String, dynamic>? map) {
    if (map == null || map.isEmpty) {
      return const ApiErrorDetailsModel();
    }

    DateTime? unlockAt;
    final unlockValue = map['unlock_at'] ?? map['unlockAt'];
    if (unlockValue != null) {
      unlockAt = DateTime.tryParse(unlockValue.toString());
    }

    int? retryAfterSeconds;
    final retryValue = map['retry_after_seconds'] ?? map['retryAfterSeconds'];
    if (retryValue is num) {
      retryAfterSeconds = retryValue.toInt();
    }

    return ApiErrorDetailsModel(
      unlockAt: unlockAt,
      retryAfterSeconds: retryAfterSeconds,
    );
  }

  @override
  List<Object?> get props => [unlockAt, retryAfterSeconds];
}
