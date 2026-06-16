import 'package:youpass/features/ticket_assignment/domain/entities/assign_guest_lookup_entity.dart';
import 'package:youpass/features/ticket_assignment/domain/repositories/ticket_assignment_repository.dart';

class LookupAssignGuestsUseCase {
  LookupAssignGuestsUseCase(this.repository);

  final TicketAssignmentRepository repository;

  Future<List<AssignGuestLookupEntity>> call(String query) {
    return repository.lookupAssignGuests(query);
  }
}
