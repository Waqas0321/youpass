import 'package:youpass/features/vip_venue/domain/entities/physical_venue_entity.dart';
import 'package:youpass/features/vip_venue/domain/repositories/vip_venue_repository.dart';

class FetchPhysicalVenueByIdUseCase {
  FetchPhysicalVenueByIdUseCase(this.repository);

  final VipVenueRepository repository;

  Future<PhysicalVenueEntity> call(String venueId) {
    return repository.fetchVenueById(venueId);
  }
}
