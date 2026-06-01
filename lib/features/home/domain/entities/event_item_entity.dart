import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class EventItemEntity extends Equatable {
  const EventItemEntity({
    required this.id,
    required this.title,
    required this.dateLabel,
    required this.locationLabel,
    required this.thumbnailColors,
  });

  final String id;
  final String title;
  final String dateLabel;
  final String locationLabel;
  final List<Color> thumbnailColors;

  @override
  List<Object?> get props => [
        id,
        title,
        dateLabel,
        locationLabel,
        thumbnailColors,
      ];
}
