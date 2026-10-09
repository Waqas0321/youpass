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
    this.floorPlanImageUrl,
  });

  final String venueName;
  final String dimensionsLabel;
  final List<VenueZoneEntity> zones;
  final String? venueId;
  final String? layoutVenueId;
  final String? eventId;
  final PhysicalVenueEntity? physicalVenue;
  final int tableLockMinutes;

  /// Venue map uploaded in admin (Event map); shown above the zone picker.
  final String? floorPlanImageUrl;

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
    floorPlanImageUrl,
  ];
}
