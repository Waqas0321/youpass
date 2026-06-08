import 'package:youpass/core/network/api_endpoints.dart';
import 'package:youpass/core/network/base_api_service.dart';
import 'package:youpass/features/vip_venue/data/models/vip_venue_models.dart';

class VipVenueApiService extends BaseApiService {
  VipVenueApiService(super.apiClient);

  Future<TicketTypesBundleModel> fetchTicketTypes(String eventId) {
    return getModel(
      ApiEndpoints.eventTicketTypes(eventId),
      fromJson: TicketTypesBundleModel.fromJson,
      authenticated: true,
    );
  }

  Future<VenueFloorPlanModel> fetchVenueLayout(String eventId) {
    return getModel(
      ApiEndpoints.eventVenueLayout(eventId),
      fromJson: VenueFloorPlanModel.fromJson,
      authenticated: true,
    );
  }

  Future<ZoneTablesBundleModel> fetchZoneTables({
    required String eventId,
    required String zoneId,
  }) {
    return getModel(
      ApiEndpoints.eventZoneTables(eventId, zoneId),
      fromJson: ZoneTablesBundleModel.fromJson,
      authenticated: true,
    );
  }

  Future<TableLockResultModel> lockTable({
    required String eventId,
    required String tableId,
  }) {
    return postModel(
      ApiEndpoints.eventTableLock(eventId, tableId),
      fromJson: TableLockResultModel.fromJson,
      authenticated: true,
    );
  }

  Future<void> releaseTableLock({
    required String eventId,
    required String tableId,
  }) {
    return deleteVoid(
      ApiEndpoints.eventTableLock(eventId, tableId),
      authenticated: true,
    );
  }

  Future<TableAvailabilitySnapshotModel> fetchTableAvailabilityRealtime(
    String eventId,
  ) {
    return getModel(
      ApiEndpoints.eventTablesAvailabilityRealtime(eventId),
      fromJson: TableAvailabilitySnapshotModel.fromJson,
      authenticated: true,
    );
  }
}
