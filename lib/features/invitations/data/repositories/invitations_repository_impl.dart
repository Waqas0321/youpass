import 'package:youpass/features/invitations/data/datasources/invitations_remote_datasource.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_entity.dart';
import 'package:youpass/features/invitations/domain/entities/invitation_ticket_entity.dart';
import 'package:youpass/features/invitations/domain/entities/payment_method_request_entity.dart';
import 'package:youpass/features/invitations/domain/repositories/invitations_repository.dart';

class InvitationsRepositoryImpl implements InvitationsRepository {
  InvitationsRepositoryImpl(this.remoteDataSource);

  final InvitationsRemoteDataSource remoteDataSource;

  @override
  Future<List<InvitationEntity>> fetchInvitations() {
    return remoteDataSource.fetchInvitations();
  }

  @override
  Future<InvitationEntity> confirmInvitation(String invitationId) {
    return remoteDataSource.confirmInvitation(invitationId);
  }

  @override
  Future<InvitationEntity> rejectInvitation(String invitationId) {
    return remoteDataSource.rejectInvitation(invitationId);
  }

  @override
  Future<InvitationTicketEntity> fetchTicket(String invitationId) {
    return remoteDataSource.fetchTicket(invitationId);
  }

  @override
  Future<void> savePaymentMethod(PaymentMethodRequestEntity request) {
    return remoteDataSource.savePaymentMethod(request);
  }
}
