import 'package:youpass/features/vip_venue/domain/entities/physical_venue_entity.dart';
import 'package:youpass/features/vip_venue/domain/repositories/vip_venue_repository.dart';

class FetchPhysicalVenuesUseCase {
  FetchPhysicalVenuesUseCase(this.repository);

  final VipVenueRepository repository;

  Future<List<PhysicalVenueEntity>> call() {
    return repository.fetchVenues();
  }
}
