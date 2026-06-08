import 'package:youpass/features/vip_venue/domain/entities/table_availability_snapshot_entity.dart';
import 'package:youpass/features/vip_venue/domain/entities/venue_floor_plan_entity.dart';
import 'package:youpass/features/vip_venue/domain/entities/venue_table_entity.dart';
import 'package:youpass/features/vip_venue/domain/entities/venue_zone_status.dart';

class VipVenueAvailabilityMapper {
  VipVenueAvailabilityMapper._();

  static VenueFloorPlanEntity mergeFloorPlan(
    VenueFloorPlanEntity plan,
    TableAvailabilitySnapshotEntity snapshot,
  ) {
    final zones = plan.zones.map((zone) {
      final zoneSnapshot = snapshot.zoneById(zone.id);
      if (zoneSnapshot == null) {
        return zone;
      }

      if (zoneSnapshot.availableTables <= 0) {
        return zone.copyWith(status: VenueZoneStatus.sold);
      }

      if (zone.status == VenueZoneStatus.premium) {
        return zone;
      }

      return zone.copyWith(status: VenueZoneStatus.available);
    }).toList();

    return VenueFloorPlanEntity(
      venueName: plan.venueName,
      dimensionsLabel: plan.dimensionsLabel,
      zones: zones,
    );
  }

  static List<VenueTableEntity> mergeZoneTables(
    List<VenueTableEntity> tables,
    String zoneId,
    TableAvailabilitySnapshotEntity snapshot,
  ) {
    final zoneSnapshot = snapshot.zoneById(zoneId);
    if (zoneSnapshot == null) {
      return tables;
    }

    final statusById = {
      for (final table in zoneSnapshot.tables) table.id: table.status,
    };

    return tables
        .map(
          (table) => statusById.containsKey(table.id)
              ? table.copyWith(status: statusById[table.id])
              : table,
        )
        .toList();
  }
}
