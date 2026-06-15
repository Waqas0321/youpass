import 'package:youpass/features/invitations/data/models/invitation_model.dart';
import 'package:youpass/features/invitations/data/models/invitations_summary_model.dart';
import 'package:youpass/features/waitlist/data/models/waitlist_entry_model.dart';

class InvitationsListResponseModel {
  const InvitationsListResponseModel({
    required this.invitations,
    this.waitlistEntries = const [],
    this.summary,
  });

  final List<InvitationModel> invitations;
  final List<WaitlistEntryModel> waitlistEntries;
  final InvitationsSummaryModel? summary;

  factory InvitationsListResponseModel.fromJson(Map<String, dynamic> json) {
    final items = json['invitations'] ?? json['items'] ?? json;
    final meta = json['meta'];
    return InvitationsListResponseModel(
      invitations: InvitationModel.listFromPayload(items),
      waitlistEntries: WaitlistEntryModel.listFromPayload(json['waitlist_entries']),
      summary: meta is Map<String, dynamic>
          ? InvitationsSummaryModel.fromJson(meta)
          : null,
    );
  }
}
