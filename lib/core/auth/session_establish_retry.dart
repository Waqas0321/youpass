import 'package:youpass/core/auth/auth_token_store.dart';
import 'package:youpass/core/network/api_exception.dart';

/// Retries protected API calls shortly after login when the backend session
/// record may not be readable yet (serverless / DB replication lag).
Future<T> withSessionEstablishRetry<T>(Future<T> Function() action) async {
  const retryDelays = [
    Duration(milliseconds: 600),
    Duration(milliseconds: 1200),
  ];

  ApiException? lastError;

  for (var attempt = 0; attempt <= retryDelays.length; attempt++) {
    try {
      return await action();
    } on ApiException catch (error) {
      lastError = error;
      final canRetry = _isRetriableSessionError(error) &&
          AuthTokenStore.isWithinEstablishGracePeriod &&
          attempt < retryDelays.length;

      if (!canRetry) {
        rethrow;
      }

      await Future.delayed(retryDelays[attempt]);
    }
  }

  throw lastError!;
}

bool _isRetriableSessionError(ApiException error) {
  return error.code == 'SESSION_INVALID' || error.code == 'UNAUTHORIZED';
}
