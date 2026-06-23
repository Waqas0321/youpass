import 'package:flutter/foundation.dart';
import 'package:youpass/core/network/api_exception.dart';
import 'package:youpass/features/vip_venue/domain/entities/table_availability_snapshot_entity.dart';
import 'package:youpass/features/vip_venue/domain/entities/table_lock_result_entity.dart';
import 'package:youpass/features/vip_venue/domain/entities/table_lock_status_entity.dart';
import 'package:youpass/features/vip_venue/domain/entities/ticket_types_bundle_entity.dart';
import 'package:youpass/features/vip_venue/domain/entities/venue_floor_plan_entity.dart';
import 'package:youpass/features/vip_venue/domain/entities/zone_tables_bundle_entity.dart';
import 'package:youpass/features/vip_venue/domain/usecases/fetch_table_lock_status_usecase.dart';
import 'package:youpass/features/vip_venue/domain/usecases/fetch_table_availability_realtime_usecase.dart';
import 'package:youpass/features/vip_venue/domain/usecases/fetch_ticket_types_usecase.dart';
import 'package:youpass/features/vip_venue/domain/usecases/fetch_venue_layout_usecase.dart';
import 'package:youpass/features/vip_venue/domain/usecases/fetch_zone_tables_usecase.dart';
import 'package:youpass/features/vip_venue/domain/usecases/lock_venue_table_usecase.dart';
import 'package:youpass/features/vip_venue/domain/usecases/release_venue_table_lock_usecase.dart';

enum VipVenueLoadStatus { initial, loading, ready, error }

class VipVenueProvider extends ChangeNotifier {
  VipVenueProvider({
    required this.fetchTicketTypesUseCase,
    required this.fetchVenueLayoutUseCase,
    required this.fetchZoneTablesUseCase,
    required this.lockVenueTableUseCase,
    required this.releaseVenueTableLockUseCase,
    required this.fetchTableAvailabilityRealtimeUseCase,
    required this.fetchTableLockStatusUseCase,
  });

  final FetchTicketTypesUseCase fetchTicketTypesUseCase;
  final FetchVenueLayoutUseCase fetchVenueLayoutUseCase;
  final FetchZoneTablesUseCase fetchZoneTablesUseCase;
  final LockVenueTableUseCase lockVenueTableUseCase;
  final ReleaseVenueTableLockUseCase releaseVenueTableLockUseCase;
  final FetchTableAvailabilityRealtimeUseCase fetchTableAvailabilityRealtimeUseCase;
  final FetchTableLockStatusUseCase fetchTableLockStatusUseCase;

  VipVenueLoadStatus ticketTypesStatus = VipVenueLoadStatus.initial;
  VipVenueLoadStatus venueLayoutStatus = VipVenueLoadStatus.initial;
  VipVenueLoadStatus zoneTablesStatus = VipVenueLoadStatus.initial;
  bool isLockingTable = false;

  TicketTypesBundleEntity? ticketTypes;
  VenueFloorPlanEntity? venueLayout;
  ZoneTablesBundleEntity? zoneTables;

  String? _cachedVenueLayoutEventId;
  String? _cachedTicketTypesEventId;

  String? errorMessage;
  String? errorCode;

  Future<TicketTypesBundleEntity?> loadTicketTypes(String eventId) async {
    if (eventId.isEmpty) {
      ticketTypesStatus = VipVenueLoadStatus.error;
      errorCode = 'EVENT_NOT_FOUND';
      errorMessage = 'Event not found';
      notifyListeners();
      return null;
    }

    if (_cachedTicketTypesEventId == eventId &&
        ticketTypesStatus == VipVenueLoadStatus.ready) {
      return ticketTypes;
    }

    ticketTypesStatus = VipVenueLoadStatus.loading;
    errorMessage = null;
    errorCode = null;
    notifyListeners();

    try {
      ticketTypes = await fetchTicketTypesUseCase(eventId);
      ticketTypesStatus = VipVenueLoadStatus.ready;
      _cachedTicketTypesEventId = eventId;
      notifyListeners();
      return ticketTypes;
    } on ApiException catch (error) {
      ticketTypesStatus = VipVenueLoadStatus.error;
      errorCode = error.code;
      errorMessage = error.message;
      notifyListeners();
      return null;
    } catch (error) {
      ticketTypesStatus = VipVenueLoadStatus.error;
      errorMessage = error.toString();
      notifyListeners();
      return null;
    }
  }

  Future<VenueFloorPlanEntity?> loadVenueLayout(String eventId) async {
    if (eventId.isEmpty) {
      venueLayout = null;
      venueLayoutStatus = VipVenueLoadStatus.ready;
      _cachedVenueLayoutEventId = eventId;
      notifyListeners();
      return null;
    }

    if (_cachedVenueLayoutEventId == eventId &&
        venueLayoutStatus == VipVenueLoadStatus.ready) {
      return venueLayout;
    }

    venueLayoutStatus = VipVenueLoadStatus.loading;
    errorMessage = null;
    errorCode = null;
    notifyListeners();

    try {
      venueLayout = await fetchVenueLayoutUseCase(eventId);
      venueLayoutStatus = VipVenueLoadStatus.ready;
      _cachedVenueLayoutEventId = eventId;
      notifyListeners();
      return venueLayout;
    } on ApiException catch (error) {
      if (error.isVenueLayoutUnavailable) {
        venueLayout = null;
        venueLayoutStatus = VipVenueLoadStatus.ready;
        _cachedVenueLayoutEventId = eventId;
        errorMessage = null;
        errorCode = null;
        notifyListeners();
        return null;
      }

      venueLayoutStatus = VipVenueLoadStatus.error;
      errorCode = error.code;
      errorMessage = error.message;
      notifyListeners();
      return null;
    } catch (error) {
      venueLayoutStatus = VipVenueLoadStatus.error;
      errorMessage = error.toString();
      notifyListeners();
      return null;
    }
  }

  Future<ZoneTablesBundleEntity?> loadZoneTables({
    required String eventId,
    required String zoneId,
  }) async {
    zoneTablesStatus = VipVenueLoadStatus.loading;
    errorMessage = null;
    errorCode = null;
    notifyListeners();

    try {
      zoneTables = await fetchZoneTablesUseCase(eventId: eventId, zoneId: zoneId);
      zoneTablesStatus = VipVenueLoadStatus.ready;
      notifyListeners();
      return zoneTables;
    } on ApiException catch (error) {
      zoneTablesStatus = VipVenueLoadStatus.error;
      errorCode = error.code;
      errorMessage = error.message;
      notifyListeners();
      return null;
    } catch (error) {
      zoneTablesStatus = VipVenueLoadStatus.error;
      errorMessage = error.toString();
      notifyListeners();
      return null;
    }
  }

  Future<TableLockResultEntity?> lockTable({
    required String eventId,
    required String tableId,
  }) async {
    isLockingTable = true;
    errorMessage = null;
    errorCode = null;
    notifyListeners();

    try {
      final result =
          await lockVenueTableUseCase(eventId: eventId, tableId: tableId);
      isLockingTable = false;
      notifyListeners();
      return result;
    } on ApiException catch (error) {
      isLockingTable = false;
      errorCode = error.code;
      errorMessage = error.message;
      notifyListeners();
      return null;
    } catch (error) {
      isLockingTable = false;
      errorMessage = error.toString();
      notifyListeners();
      return null;
    }
  }

  Future<void> releaseTableLock({
    required String eventId,
    required String tableId,
  }) async {
    try {
      await releaseVenueTableLockUseCase(eventId: eventId, tableId: tableId);
    } on ApiException catch (error) {
      errorCode = error.code;
      errorMessage = error.message;
      notifyListeners();
    } catch (error) {
      errorMessage = error.toString();
      notifyListeners();
    }
  }

  Future<TableAvailabilitySnapshotEntity?> refreshTableAvailability(
    String eventId,
  ) async {
    try {
      return await fetchTableAvailabilityRealtimeUseCase(eventId);
    } catch (_) {
      return null;
    }
  }

  Future<TableLockStatusEntity?> fetchTableLockStatus({
    required String eventId,
    required String tableId,
  }) async {
    try {
      return await fetchTableLockStatusUseCase(eventId: eventId, tableId: tableId);
    } catch (_) {
      return null;
    }
  }
}
