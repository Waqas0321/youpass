import 'package:equatable/equatable.dart';
import 'package:youpass/features/vip_venue/domain/entities/venue_table_entity.dart';

class ZoneTablesBundleEntity extends Equatable {
  const ZoneTablesBundleEntity({
    required this.zoneId,
    required this.zoneName,
    required this.tableCapacity,
    required this.tables,
  });

  final String zoneId;
  final String zoneName;
  final int tableCapacity;
  final List<VenueTableEntity> tables;

  @override
  List<Object?> get props => [zoneId, zoneName, tableCapacity, tables];
}
