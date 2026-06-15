import 'package:youpass/core/network/api_endpoints.dart';
import 'package:youpass/core/network/base_api_service.dart';
import 'package:youpass/features/invitations/data/models/invitation_model.dart';
import 'package:youpass/features/waitlist/data/models/waitlist_entry_model.dart';

class WaitlistApiService extends BaseApiService {
  WaitlistApiService(super.apiClient);

  Future<Map<String, dynamic>> fetchJoinPreview(String eventId) {
    return getData(
      ApiEndpoints.eventWaitlistPreview(eventId),
      authenticated: true,
    );
  }

  Future<Map<String, dynamic>> join(String eventId) {
    return postData(
      ApiEndpoints.eventWaitlistJoin(eventId),
      authenticated: true,
    );
  }

  Future<void> leave(String eventId) {
    return deleteVoid(
      ApiEndpoints.eventWaitlistLeave(eventId),
      authenticated: true,
    );
  }

  Future<InvitationModel> claimOffer(String offerId) async {
    final raw = await postData(
      ApiEndpoints.waitlistOfferClaim(offerId),
      authenticated: true,
    );

    final invitation = raw['invitation'];
    if (invitation is Map<String, dynamic>) {
      return InvitationModel.fromJson(invitation);
    }

    return InvitationModel.fromJson(raw);
  }

  static List<WaitlistEntryModel> parseEntries(dynamic payload) {
    return WaitlistEntryModel.listFromPayload(payload);
  }
}
