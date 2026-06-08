import 'package:youpass/core/constants/app_constants.dart';
import 'package:youpass/core/locale/locale_provider.dart';
import 'package:youpass/features/vip_venue/data/datasources/vip_venue_remote_datasource.dart';
import 'package:youpass/features/vip_venue/data/services/vip_venue_api_service.dart';
import 'package:youpass/features/vip_venue/data/vip_venue_mock_data.dart';
import 'package:youpass/features/vip_venue/domain/entities/table_availability_snapshot_entity.dart';
import 'package:youpass/features/vip_venue/domain/entities/table_lock_result_entity.dart';
import 'package:youpass/features/vip_venue/domain/entities/ticket_types_bundle_entity.dart';
import 'package:youpass/features/vip_venue/domain/entities/venue_floor_plan_entity.dart';
import 'package:youpass/features/vip_venue/domain/entities/zone_tables_bundle_entity.dart';
import 'package:youpass/l10n/app_localizations.dart';

class VipVenueRemoteDataSourceImpl implements VipVenueRemoteDataSource {
  VipVenueRemoteDataSourceImpl({
    required this.apiService,
    required this.localeProvider,
  });

  final VipVenueApiService apiService;
  final LocaleProvider localeProvider;

  AppLocalizations get _l10n => lookupAppLocalizations(localeProvider.locale);

  @override
  Future<TicketTypesBundleEntity> fetchTicketTypes(String eventId) async {
    if (AppConstants.useVipVenueMockData) {
      return TicketTypesBundleEntity(
        eventId: eventId,
        serviceFeeRate: 0.05,
        offerings: VipVenueMockData.ticketOfferings(_l10n),
      );
    }

    return apiService.fetchTicketTypes(eventId);
  }

  @override
  Future<VenueFloorPlanEntity> fetchVenueLayout(String eventId) async {
    if (AppConstants.useVipVenueMockData) {
      return VipVenueMockData.floorPlan(_l10n);
    }

    return apiService.fetchVenueLayout(eventId);
  }

  @override
  Future<ZoneTablesBundleEntity> fetchZoneTables({
    required String eventId,
    required String zoneId,
  }) async {
    if (AppConstants.useVipVenueMockData) {
      final tables = VipVenueMockData.tablesForZone(zoneId);
      return ZoneTablesBundleEntity(
        zoneId: zoneId,
        zoneName: zoneId,
        tableCapacity: 10,
        tables: tables,
      );
    }

    return apiService.fetchZoneTables(eventId: eventId, zoneId: zoneId);
  }

  @override
  Future<TableLockResultEntity> lockTable({
    required String eventId,
    required String tableId,
  }) {
    if (AppConstants.useVipVenueMockData) {
      final tables = VipVenueMockData.tablesForZone(VipVenueMockData.vipZone1Id);
      final table = tables.firstWhere(
        (item) => item.id == tableId,
        orElse: () => tables.first,
      );
      return Future.value(
        TableLockResultEntity(
          lockId: 'mock-lock',
          tableId: tableId,
          expiresAt: DateTime.now().add(const Duration(minutes: 10)),
          expiresInSeconds: 600,
          table: table,
        ),
      );
    }

    return apiService.lockTable(eventId: eventId, tableId: tableId);
  }

  @override
  Future<void> releaseTableLock({
    required String eventId,
    required String tableId,
  }) {
    if (AppConstants.useVipVenueMockData) {
      return Future.value();
    }

    return apiService.releaseTableLock(eventId: eventId, tableId: tableId);
  }

  @override
  Future<TableAvailabilitySnapshotEntity> fetchTableAvailabilityRealtime(
    String eventId,
  ) {
    if (AppConstants.useVipVenueMockData) {
      return Future.value(
        TableAvailabilitySnapshotEntity(
          eventId: eventId,
          updatedAt: DateTime.now(),
          zones: const [],
        ),
      );
    }

    return apiService.fetchTableAvailabilityRealtime(eventId);
  }
}
