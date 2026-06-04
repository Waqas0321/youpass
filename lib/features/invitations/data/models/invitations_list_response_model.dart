import 'package:youpass/features/invitations/data/models/invitation_model.dart';
import 'package:youpass/features/invitations/data/models/invitations_summary_model.dart';

class InvitationsListResponseModel {
  const InvitationsListResponseModel({
    required this.invitations,
    this.summary,
  });

  final List<InvitationModel> invitations;
  final InvitationsSummaryModel? summary;

  factory InvitationsListResponseModel.fromJson(Map<String, dynamic> json) {
    final items = json['invitations'] ?? json['items'] ?? json;
    final meta = json['meta'];
    return InvitationsListResponseModel(
      invitations: InvitationModel.listFromPayload(items),
      summary: meta is Map<String, dynamic>
          ? InvitationsSummaryModel.fromJson(meta)
          : null,
    );
  }
}
