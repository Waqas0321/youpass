import 'package:youpass/features/vip_venue/domain/entities/table_availability_snapshot_entity.dart';
import 'package:youpass/features/vip_venue/domain/repositories/vip_venue_repository.dart';

class FetchTableAvailabilityRealtimeUseCase {
  FetchTableAvailabilityRealtimeUseCase(this.repository);

  final VipVenueRepository repository;

  Future<TableAvailabilitySnapshotEntity> call(String eventId) {
    return repository.fetchTableAvailabilityRealtime(eventId);
  }
}
