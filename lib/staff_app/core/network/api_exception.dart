class ApiException implements Exception {
  ApiException({
    required this.code,
    required this.message,
    this.statusCode,
    this.retryAfterSeconds,
    this.details,
  });

  final String code;
  final String message;
  final int? statusCode;
  final int? retryAfterSeconds;
  final Map<String, dynamic>? details;

  factory ApiException.fromResponse({
    required int statusCode,
    required Map<String, dynamic> body,
  }) {
    final error = body['error'];
    if (error is! Map<String, dynamic>) {
      return ApiException(
        code: 'REQUEST_FAILED',
        message: 'Request failed',
        statusCode: statusCode,
      );
    }

    final details = error['details'];
    int? retryAfterSeconds;

    if (details is Map<String, dynamic>) {
      final retryValue = details['retry_after_seconds'];
      if (retryValue is int) {
        retryAfterSeconds = retryValue;
      } else if (retryValue is num) {
        retryAfterSeconds = retryValue.toInt();
      }
    }

    return ApiException(
      code: error['code'] as String? ?? 'UNKNOWN_ERROR',
      message: error['message'] as String? ?? 'Request failed',
      statusCode: statusCode,
      retryAfterSeconds: retryAfterSeconds,
      details: details is Map<String, dynamic> ? details : null,
    );
  }

  @override
  String toString() => message;
}
