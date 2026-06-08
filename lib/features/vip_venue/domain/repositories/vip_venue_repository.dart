import 'package:youpass/features/vip_venue/domain/entities/table_availability_snapshot_entity.dart';
import 'package:youpass/features/vip_venue/domain/entities/table_lock_result_entity.dart';
import 'package:youpass/features/vip_venue/domain/entities/ticket_types_bundle_entity.dart';
import 'package:youpass/features/vip_venue/domain/entities/venue_floor_plan_entity.dart';
import 'package:youpass/features/vip_venue/domain/entities/zone_tables_bundle_entity.dart';

abstract class VipVenueRepository {
  Future<TicketTypesBundleEntity> fetchTicketTypes(String eventId);

  Future<VenueFloorPlanEntity> fetchVenueLayout(String eventId);

  Future<ZoneTablesBundleEntity> fetchZoneTables({
    required String eventId,
    required String zoneId,
  });

  Future<TableLockResultEntity> lockTable({
    required String eventId,
    required String tableId,
  });

  Future<void> releaseTableLock({
    required String eventId,
    required String tableId,
  });

  Future<TableAvailabilitySnapshotEntity> fetchTableAvailabilityRealtime(
    String eventId,
  );
}
