import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class FeaturedEventEntity extends Equatable {
  const FeaturedEventEntity({
    required this.id,
    required this.title,
    required this.dateTimeLabel,
    required this.locationLabel,
    required this.backgroundColors,
  });

  final String id;
  final String title;
  final String dateTimeLabel;
  final String locationLabel;
  final List<Color> backgroundColors;

  @override
  List<Object?> get props => [
        id,
        title,
        dateTimeLabel,
        locationLabel,
        backgroundColors,
      ];
}
