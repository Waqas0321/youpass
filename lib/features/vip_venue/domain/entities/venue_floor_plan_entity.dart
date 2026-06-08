import 'package:equatable/equatable.dart';
import 'package:youpass/features/vip_venue/domain/entities/venue_zone_entity.dart';

class VenueFloorPlanEntity extends Equatable {
  const VenueFloorPlanEntity({
    required this.venueName,
    required this.dimensionsLabel,
    required this.zones,
  });

  final String venueName;
  final String dimensionsLabel;
  final List<VenueZoneEntity> zones;

  @override
  List<Object?> get props => [venueName, dimensionsLabel, zones];
}
