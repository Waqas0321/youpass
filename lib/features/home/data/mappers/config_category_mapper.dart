import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_constants.dart';
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
    if (category.id == AppConstants.categoryIdAll) {
      return Icons.apps_outlined;
    }

    if (category.countryCode != null && category.countryCode!.isNotEmpty) {
      return Icons.location_on_outlined;
    }

    return _iconForSlug(category.eventTypeSlug ?? category.id);
  }

  static IconData _iconForSlug(String slug) {
    switch (slug) {
      case AppConstants.categoryIdParties:
        return Icons.celebration_outlined;
      case AppConstants.categoryIdConcerts:
        return Icons.music_note_outlined;
      case AppConstants.categoryIdSports:
        return Icons.sports_soccer_outlined;
      case 'bar':
        return Icons.local_bar_outlined;
      default:
        return Icons.event_outlined;
    }
  }
}
