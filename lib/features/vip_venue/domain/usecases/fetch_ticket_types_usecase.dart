import 'package:youpass/features/vip_venue/domain/entities/ticket_types_bundle_entity.dart';
import 'package:youpass/features/vip_venue/domain/repositories/vip_venue_repository.dart';

class FetchTicketTypesUseCase {
  FetchTicketTypesUseCase(this.repository);

  final VipVenueRepository repository;

  Future<TicketTypesBundleEntity> call(String eventId) {
    return repository.fetchTicketTypes(eventId);
  }
}
