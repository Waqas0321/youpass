import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class EventCategoryEntity extends Equatable {
  const EventCategoryEntity({
    required this.id,
    required this.label,
    required this.icon,
    this.leadingEmoji,
    this.countryCode,
    this.eventTypeSlug,
  });

  final String id;
  final String label;
  final IconData icon;
  final String? leadingEmoji;
  final String? countryCode;
  final String? eventTypeSlug;

  @override
  List<Object?> get props => [id, label, icon, leadingEmoji, countryCode, eventTypeSlug];
}
