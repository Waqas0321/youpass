import 'package:flutter/material.dart';
import 'package:youpass/core/network/models/config_category_model.dart';
import 'package:youpass/features/home/domain/entities/event_category_entity.dart';

class ConfigCategoryMapper {
  ConfigCategoryMapper._();

  static List<EventCategoryEntity> toEntities(List<ConfigCategoryModel> categories) {
    return categories
        .map(
          (category) => EventCategoryEntity(
            id: category.id,
            label: category.label,
            icon: _iconForCategory(category),
            countryCode: category.countryCode,
            eventTypeSlug: category.eventTypeSlug,
          ),
        )
        .toList();
  }

  static IconData _iconForCategory(ConfigCategoryModel category) {
    if (category.countryCode != null && category.countryCode!.isNotEmpty) {
      return Icons.location_on_outlined;
    }

    return _iconForSlug(category.eventTypeSlug ?? category.id);
  }

  static IconData _iconForSlug(String slug) {
    switch (slug) {
      case 'parties':
        return Icons.celebration_outlined;
      case 'concerts':
        return Icons.music_note_outlined;
      case 'sports':
        return Icons.sports_soccer_outlined;
      case 'humour':
        return Icons.sentiment_very_satisfied_outlined;
      case 'theatre':
        return Icons.theater_comedy_outlined;
      case 'cinema':
        return Icons.movie_outlined;
      case 'food':
        return Icons.restaurant_outlined;
      case 'culture-art':
        return Icons.palette_outlined;
      case 'family':
        return Icons.family_restroom_outlined;
      case 'conferences':
        return Icons.record_voice_over_outlined;
      case 'bar':
        return Icons.local_bar_outlined;
      default:
        return Icons.event_outlined;
    }
  }
}
