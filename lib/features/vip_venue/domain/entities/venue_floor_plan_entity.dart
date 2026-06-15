import 'package:equatable/equatable.dart';
import 'package:youpass/features/vip_venue/domain/entities/physical_venue_entity.dart';
import 'package:youpass/features/vip_venue/domain/entities/venue_zone_entity.dart';

class VenueFloorPlanEntity extends Equatable {
  const VenueFloorPlanEntity({
    required this.venueName,
    required this.dimensionsLabel,
    required this.zones,
    this.venueId,
    this.layoutVenueId,
    this.eventId,
    this.physicalVenue,
    this.tableLockMinutes = 10,
  });

  final String venueName;
  final String dimensionsLabel;
  final List<VenueZoneEntity> zones;
  final String? venueId;
  final String? layoutVenueId;
  final String? eventId;
  final PhysicalVenueEntity? physicalVenue;
  final int tableLockMinutes;

  @override
  List<Object?> get props => [
        venueName,
        dimensionsLabel,
        zones,
        venueId,
        layoutVenueId,
        eventId,
        physicalVenue,
        tableLockMinutes,
      ];
}
