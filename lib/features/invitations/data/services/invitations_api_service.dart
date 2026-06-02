import 'package:youpass/core/network/api_endpoints.dart';
import 'package:youpass/core/network/base_api_service.dart';
import 'package:youpass/features/invitations/data/models/invitation_model.dart';
import 'package:youpass/features/invitations/data/models/invitation_ticket_model.dart';
import 'package:youpass/features/invitations/domain/entities/payment_method_request_entity.dart';

class InvitationsApiService extends BaseApiService {
  InvitationsApiService(super.apiClient);

  Future<List<InvitationModel>> fetchInvitations() async {
    final data = await getData(
      ApiEndpoints.invitations,
      authenticated: true,
    );

    final items = data['invitations'] ?? data['items'] ?? data;
    return InvitationModel.listFromPayload(items);
  }

  Future<InvitationModel> confirmInvitation(String invitationId) async {
    final data = await postData(
      ApiEndpoints.invitationConfirm(invitationId),
      authenticated: true,
    );

    return InvitationModel.fromJson(data);
  }

  Future<InvitationModel> rejectInvitation(String invitationId) async {
    final data = await postData(
      ApiEndpoints.invitationReject(invitationId),
      authenticated: true,
    );

    return InvitationModel.fromJson(data);
  }

  Future<InvitationTicketModel> fetchTicket(String invitationId) async {
    final data = await getData(
      ApiEndpoints.invitationTicket(invitationId),
      authenticated: true,
    );

    return InvitationTicketModel.fromJson(data, invitationId: invitationId);
  }

  Future<void> savePaymentMethod(PaymentMethodRequestEntity request) async {
    await postData(
      ApiEndpoints.paymentMethods,
      authenticated: true,
      body: {
        'card_number': request.cardNumber.replaceAll(' ', ''),
        'expiry': request.expiry,
        'cvv': request.cvv,
        'cardholder_name': request.cardholderName,
      },
    );
  }
}
