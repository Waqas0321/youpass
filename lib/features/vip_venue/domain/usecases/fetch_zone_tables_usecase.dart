import 'package:youpass/features/vip_venue/domain/entities/zone_tables_bundle_entity.dart';
import 'package:youpass/features/vip_venue/domain/repositories/vip_venue_repository.dart';

class FetchZoneTablesUseCase {
  FetchZoneTablesUseCase(this.repository);

  final VipVenueRepository repository;

  Future<ZoneTablesBundleEntity> call({
    required String eventId,
    required String zoneId,
  }) {
    return repository.fetchZoneTables(eventId: eventId, zoneId: zoneId);
  }
}
