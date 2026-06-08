import 'package:equatable/equatable.dart';
import 'package:youpass/features/vip_venue/domain/entities/venue_table_status.dart';

class TableAvailabilitySnapshotEntity extends Equatable {
  const TableAvailabilitySnapshotEntity({
    required this.eventId,
    required this.zones,
    this.updatedAt,
  });

  final String eventId;
  final DateTime? updatedAt;
  final List<ZoneAvailabilityEntity> zones;

  ZoneAvailabilityEntity? zoneById(String zoneId) {
    final normalized = zoneId.toLowerCase();
    for (final zone in zones) {
      if (zone.zoneId.toLowerCase() == normalized) {
        return zone;
      }
    }
    return null;
  }

  @override
  List<Object?> get props => [eventId, updatedAt, zones];
}

class ZoneAvailabilityEntity extends Equatable {
  const ZoneAvailabilityEntity({
    required this.zoneId,
    required this.availableTables,
    required this.lockedTables,
    required this.soldTables,
    required this.tables,
  });

  final String zoneId;
  final int availableTables;
  final int lockedTables;
  final int soldTables;
  final List<TableAvailabilityItemEntity> tables;

  @override
  List<Object?> get props => [
        zoneId,
        availableTables,
        lockedTables,
        soldTables,
        tables,
      ];
}

class TableAvailabilityItemEntity extends Equatable {
  const TableAvailabilityItemEntity({
    required this.id,
    required this.label,
    required this.status,
  });

  final String id;
  final String label;
  final VenueTableStatus status;

  @override
  List<Object?> get props => [id, label, status];
}
