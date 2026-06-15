import 'package:equatable/equatable.dart';

class PhysicalVenueEntity extends Equatable {
  const PhysicalVenueEntity({
    required this.id,
    required this.name,
    this.address,
    this.city,
    this.country,
    this.widthMeters,
    this.heightMeters,
  });

  final String id;
  final String name;
  final String? address;
  final String? city;
  final String? country;
  final double? widthMeters;
  final double? heightMeters;

  String? get dimensionsLabel {
    if (widthMeters == null || heightMeters == null) {
      return null;
    }
    return '${widthMeters!.toStringAsFixed(0)}m × ${heightMeters!.toStringAsFixed(0)}m';
  }

  @override
  List<Object?> get props => [
        id,
        name,
        address,
        city,
        country,
        widthMeters,
        heightMeters,
      ];
}
