import 'package:youpass/features/invitations/domain/entities/payment_method_request_entity.dart';
import 'package:youpass/features/invitations/domain/repositories/invitations_repository.dart';

class SavePaymentMethodUseCase {
  SavePaymentMethodUseCase(this.repository);

  final InvitationsRepository repository;

  Future<void> call(PaymentMethodRequestEntity request) {
    return repository.savePaymentMethod(request);
  }
}
