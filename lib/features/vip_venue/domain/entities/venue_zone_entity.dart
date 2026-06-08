import 'package:equatable/equatable.dart';
import 'package:youpass/features/vip_venue/domain/entities/venue_zone_kind.dart';
import 'package:youpass/features/vip_venue/domain/entities/venue_zone_status.dart';

class VenueZoneEntity extends Equatable {
  const VenueZoneEntity({
    required this.id,
    required this.kind,
    required this.name,
    required this.status,
    this.capacityPerTable,
    this.isSelectable = true,
  });

  final String id;
  final VenueZoneKind kind;
  final String name;
  final VenueZoneStatus status;
  final int? capacityPerTable;
  final bool isSelectable;

  VenueZoneEntity copyWith({VenueZoneStatus? status}) {
    return VenueZoneEntity(
      id: id,
      kind: kind,
      name: name,
      status: status ?? this.status,
      capacityPerTable: capacityPerTable,
      isSelectable: isSelectable,
    );
  }

  @override
  List<Object?> get props => [
        id,
        kind,
        name,
        status,
        capacityPerTable,
        isSelectable,
      ];
}
