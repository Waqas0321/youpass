import 'package:youpass/core/utils/json_readers.dart';
import 'package:youpass/features/vip_venue/domain/entities/physical_venue_entity.dart';

class PhysicalVenueModel extends PhysicalVenueEntity {
  const PhysicalVenueModel({
    required super.id,
    required super.name,
    super.address,
    super.city,
    super.country,
    super.widthMeters,
    super.heightMeters,
  });

  factory PhysicalVenueModel.fromJson(Map<String, dynamic> json) {
    final dimensions = json['dimensions'];
    double? widthMeters;
    double? heightMeters;
    if (dimensions is Map) {
      final width = dimensions['width_meters'] ?? dimensions['widthMeters'];
      final height = dimensions['height_meters'] ?? dimensions['heightMeters'];
      if (width is num) {
        widthMeters = width.toDouble();
      }
      if (height is num) {
        heightMeters = height.toDouble();
      }
    }

    return PhysicalVenueModel(
      id: JsonReaders.string(json, 'id'),
      name: JsonReaders.string(json, 'name'),
      address: JsonReaders.nullableString(json, 'address'),
      city: JsonReaders.nullableString(json, 'city'),
      country: JsonReaders.nullableString(json, 'country'),
      widthMeters: widthMeters,
      heightMeters: heightMeters,
    );
  }

  static PhysicalVenueModel? maybeFromJson(Object? value) {
    if (value is! Map<String, dynamic>) {
      return null;
    }
    return PhysicalVenueModel.fromJson(value);
  }

  static List<PhysicalVenueModel> listFromJson(Object? value) {
    if (value is! List) {
      return const [];
    }

    final venues = <PhysicalVenueModel>[];
    for (final item in value) {
      if (item is Map<String, dynamic>) {
        venues.add(PhysicalVenueModel.fromJson(item));
      }
    }
    return venues;
  }
}
