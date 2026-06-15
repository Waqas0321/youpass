import 'package:youpass/features/vip_venue/data/datasources/vip_venue_remote_datasource.dart';
import 'package:youpass/features/vip_venue/domain/entities/physical_venue_entity.dart';
import 'package:youpass/features/vip_venue/domain/entities/table_availability_snapshot_entity.dart';
import 'package:youpass/features/vip_venue/domain/entities/venue_table_entity.dart';
import 'package:youpass/features/vip_venue/domain/entities/table_lock_result_entity.dart';
import 'package:youpass/features/vip_venue/domain/entities/table_lock_status_entity.dart';
import 'package:youpass/features/vip_venue/domain/entities/ticket_types_bundle_entity.dart';
import 'package:youpass/features/vip_venue/domain/entities/venue_floor_plan_entity.dart';
import 'package:youpass/features/vip_venue/domain/entities/zone_tables_bundle_entity.dart';
import 'package:youpass/features/vip_venue/domain/repositories/vip_venue_repository.dart';

class VipVenueRepositoryImpl implements VipVenueRepository {
  VipVenueRepositoryImpl(this.remoteDataSource);

  final VipVenueRemoteDataSource remoteDataSource;

  @override
  Future<TicketTypesBundleEntity> fetchTicketTypes(String eventId) {
    return remoteDataSource.fetchTicketTypes(eventId);
  }

  @override
  Future<VenueFloorPlanEntity> fetchVenueLayout(String eventId) {
    return remoteDataSource.fetchVenueLayout(eventId);
  }

  @override
  Future<List<PhysicalVenueEntity>> fetchVenues() {
    return remoteDataSource.fetchVenues();
  }

  @override
  Future<PhysicalVenueEntity> fetchVenueById(String venueId) {
    return remoteDataSource.fetchVenueById(venueId);
  }

  @override
  Future<ZoneTablesBundleEntity> fetchZoneTables({
    required String eventId,
    required String zoneId,
  }) {
    return remoteDataSource.fetchZoneTables(eventId: eventId, zoneId: zoneId);
  }

  @override
  Future<VenueTableEntity> fetchTableById({
    required String eventId,
    required String tableId,
  }) {
    return remoteDataSource.fetchTableById(eventId: eventId, tableId: tableId);
  }

  @override
  Future<TableLockResultEntity> lockTable({
    required String eventId,
    required String tableId,
  }) {
    return remoteDataSource.lockTable(eventId: eventId, tableId: tableId);
  }

  @override
  Future<void> releaseTableLock({
    required String eventId,
    required String tableId,
  }) {
    return remoteDataSource.releaseTableLock(eventId: eventId, tableId: tableId);
  }

  @override
  Future<TableAvailabilitySnapshotEntity> fetchTableAvailabilityRealtime(
    String eventId,
  ) {
    return remoteDataSource.fetchTableAvailabilityRealtime(eventId);
  }

  @override
  Future<TableLockStatusEntity> fetchTableLockStatus({
    required String eventId,
    required String tableId,
  }) {
    return remoteDataSource.fetchTableLockStatus(eventId: eventId, tableId: tableId);
  }
}
