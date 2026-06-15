import 'package:youpass/core/network/api_endpoints.dart';
import 'package:youpass/core/network/base_api_service.dart';
import 'package:youpass/features/vip_venue/data/models/physical_venue_model.dart';
import 'package:youpass/features/vip_venue/data/models/vip_venue_models.dart';

class VipVenueApiService extends BaseApiService {
  VipVenueApiService(super.apiClient);

  Future<TicketTypesBundleModel> fetchTicketTypes(String eventId) {
    return getModel(
      ApiEndpoints.eventTicketTypes(eventId),
      fromJson: TicketTypesBundleModel.fromJson,
      authenticated: false,
    );
  }

  Future<VenueFloorPlanModel> fetchVenueLayout(String eventId) {
    return getModel(
      ApiEndpoints.eventVenueLayout(eventId),
      fromJson: VenueFloorPlanModel.fromJson,
      authenticated: false,
    );
  }

  Future<List<PhysicalVenueModel>> fetchVenues() async {
    final raw = await getRawData(ApiEndpoints.venues, authenticated: false);
    if (raw is List) {
      return PhysicalVenueModel.listFromJson(raw);
    }
    if (raw is Map<String, dynamic>) {
      final items = raw['items'] ?? raw['venues'];
      return PhysicalVenueModel.listFromJson(items);
    }
    return const [];
  }

  Future<PhysicalVenueModel> fetchVenueById(String venueId) {
    return getModel(
      ApiEndpoints.venueById(venueId),
      fromJson: PhysicalVenueModel.fromJson,
      authenticated: false,
    );
  }

  Future<ZoneTablesBundleModel> fetchZoneTables({
    required String eventId,
    required String zoneId,
  }) {
    return getModel(
      ApiEndpoints.eventZoneTables(eventId, zoneId),
      fromJson: ZoneTablesBundleModel.fromJson,
      authenticated: false,
    );
  }

  Future<VenueTableModel> fetchTableById({
    required String eventId,
    required String tableId,
  }) {
    return getModel(
      ApiEndpoints.eventTableById(eventId, tableId),
      fromJson: VenueTableModel.fromJson,
      authenticated: false,
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
      authenticated: false,
    );
  }

  Future<TableLockStatusModel> fetchTableLockStatus({
    required String eventId,
    required String tableId,
  }) {
    return getModel(
      ApiEndpoints.eventTableLockStatus(eventId, tableId),
      fromJson: TableLockStatusModel.fromJson,
      authenticated: false,
    );
  }
}
