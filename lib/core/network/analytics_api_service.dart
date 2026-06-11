import 'package:youpass/core/network/api_endpoints.dart';
import 'package:youpass/core/network/base_api_service.dart';

class AnalyticsApiService extends BaseApiService {
  AnalyticsApiService(super.apiClient);

  Future<void> trackRegistrationCompleted({
    required String source,
    required int timeToHomeMs,
    String? invitationId,
    String? sharedEventId,
  }) {
    return postVoid(
      ApiEndpoints.analyticsRegistrationCompleted,
      body: {
        'source': source,
        'time_to_home_ms': timeToHomeMs,
        'client_timestamp': DateTime.now().toUtc().toIso8601String(),
        if (invitationId != null && invitationId.isNotEmpty)
          'invitation_id': invitationId,
        if (sharedEventId != null && sharedEventId.isNotEmpty)
          'shared_event_id': sharedEventId,
      },
      authenticated: true,
    );
  }
}
