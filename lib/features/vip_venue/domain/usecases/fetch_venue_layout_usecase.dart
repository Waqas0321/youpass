import 'package:youpass/features/vip_venue/domain/entities/venue_floor_plan_entity.dart';
import 'package:youpass/features/vip_venue/domain/repositories/vip_venue_repository.dart';

class FetchVenueLayoutUseCase {
  FetchVenueLayoutUseCase(this.repository);

  final VipVenueRepository repository;

  Future<VenueFloorPlanEntity> call(String eventId) {
    return repository.fetchVenueLayout(eventId);
  }
}
