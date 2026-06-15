import 'package:youpass/features/vip_venue/domain/entities/physical_venue_entity.dart';
import 'package:youpass/features/vip_venue/domain/entities/table_availability_snapshot_entity.dart';
import 'package:youpass/features/vip_venue/domain/entities/venue_table_entity.dart';
import 'package:youpass/features/vip_venue/domain/entities/table_lock_result_entity.dart';
import 'package:youpass/features/vip_venue/domain/entities/table_lock_status_entity.dart';
import 'package:youpass/features/vip_venue/domain/entities/ticket_types_bundle_entity.dart';
import 'package:youpass/features/vip_venue/domain/entities/venue_floor_plan_entity.dart';
import 'package:youpass/features/vip_venue/domain/entities/zone_tables_bundle_entity.dart';

abstract class VipVenueRepository {
  Future<TicketTypesBundleEntity> fetchTicketTypes(String eventId);

  Future<VenueFloorPlanEntity> fetchVenueLayout(String eventId);

  Future<List<PhysicalVenueEntity>> fetchVenues();

  Future<PhysicalVenueEntity> fetchVenueById(String venueId);

  Future<ZoneTablesBundleEntity> fetchZoneTables({
    required String eventId,
    required String zoneId,
  });

  Future<VenueTableEntity> fetchTableById({
    required String eventId,
    required String tableId,
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

  Future<TableLockStatusEntity> fetchTableLockStatus({
    required String eventId,
    required String tableId,
  });
}
