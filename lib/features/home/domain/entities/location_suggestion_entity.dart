import 'package:equatable/equatable.dart';

class LocationSuggestionEntity extends Equatable {
  const LocationSuggestionEntity({
    required this.id,
    required this.label,
    required this.city,
    required this.latitude,
    required this.longitude,
    this.subtitle,
    this.country,
    this.countryCode,
  });

  final String id;
  final String label;
  final String city;
  final double latitude;
  final double longitude;
  final String? subtitle;
  final String? country;
  final String? countryCode;

  String get displaySubtitle {
    final value = subtitle?.trim();
    if (value != null && value.isNotEmpty) {
      return value;
    }
    final parts = [
      if (country != null && country!.trim().isNotEmpty) country!.trim(),
    ];
    return parts.join(', ');
  }

  @override
  List<Object?> get props => [
        id,
        label,
        city,
        latitude,
        longitude,
        subtitle,
        country,
        countryCode,
      ];
}
