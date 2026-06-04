import 'package:youpass/core/network/api_endpoints.dart';
import 'package:youpass/core/network/base_api_service.dart';
import 'package:youpass/features/invitations/data/models/invitation_model.dart';
import 'package:youpass/features/invitations/data/models/invitation_ticket_model.dart';
import 'package:youpass/features/invitations/data/models/invitations_list_response_model.dart';
import 'package:youpass/features/invitations/data/models/invitations_summary_model.dart';
import 'package:youpass/features/invitations/data/models/payment_method_request_model.dart';
import 'package:youpass/features/invitations/domain/entities/payment_method_request_entity.dart';

class InvitationsApiService extends BaseApiService {
  InvitationsApiService(super.apiClient);

  Future<InvitationsListResponseModel> fetchInvitationsResponse() async {
    return getModel(
      ApiEndpoints.invitations,
      fromJson: InvitationsListResponseModel.fromJson,
      authenticated: true,
    );
  }

  Future<List<InvitationModel>> fetchInvitations() async {
    final response = await fetchInvitationsResponse();
    return response.invitations;
  }

  Future<InvitationModel> fetchInvitationDetail(String invitationId) {
    return getModel(
      ApiEndpoints.invitationById(invitationId),
      fromJson: InvitationModel.fromJson,
      authenticated: true,
    );
  }

  Future<InvitationsSummaryModel> fetchSummary() {
    return getModel(
      ApiEndpoints.invitationsSummary,
      fromJson: InvitationsSummaryModel.fromJson,
      authenticated: true,
    );
  }

  Future<bool> hasSavedPaymentMethods() async {
    final raw = await getRawData(
      ApiEndpoints.paymentMethods,
      authenticated: true,
    );

    if (raw is List) {
      return raw.isNotEmpty;
    }

    if (raw is Map<String, dynamic>) {
      final methods = raw['payment_methods'] ??
          raw['paymentMethods'] ??
          raw['cards'] ??
          raw['items'];
      if (methods is List) {
        return methods.isNotEmpty;
      }
    }

    return false;
  }

  Future<InvitationModel> confirmInvitation(String invitationId) {
    return postModel(
      ApiEndpoints.invitationConfirm(invitationId),
      body: const <String, dynamic>{},
      fromJson: InvitationModel.fromJson,
      authenticated: true,
    );
  }

  Future<InvitationModel> rejectInvitation(String invitationId) {
    return postModel(
      ApiEndpoints.invitationReject(invitationId),
      body: const <String, dynamic>{},
      fromJson: InvitationModel.fromJson,
      authenticated: true,
    );
  }

  Future<InvitationTicketModel> fetchTicket(String invitationId) {
    return getModel(
      ApiEndpoints.invitationTicket(invitationId),
      fromJson: (json) => InvitationTicketModel.fromJson(
        json,
        invitationId: invitationId,
      ),
      authenticated: true,
    );
  }

  Future<void> savePaymentMethod(PaymentMethodRequestEntity request) {
    return postVoid(
      ApiEndpoints.paymentMethods,
      authenticated: true,
      body: PaymentMethodRequestModel.fromEntity(request).toJson(),
    );
  }
}
