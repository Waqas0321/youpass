import 'package:youpass/features/invitations/domain/repositories/invitations_repository.dart';

class CheckSavedPaymentMethodsUseCase {
  CheckSavedPaymentMethodsUseCase(this.repository);

  final InvitationsRepository repository;

  Future<bool> call() {
    return repository.hasSavedPaymentMethods();
  }
}
