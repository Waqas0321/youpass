import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_constants.dart';
import 'package:youpass/features/events/domain/entities/event_type_entity.dart';
import 'package:youpass/features/home/domain/entities/event_category_entity.dart';
import 'package:youpass/l10n/app_localizations.dart';

class EventCategoryMapper {
  EventCategoryMapper._();

  static List<EventCategoryEntity> buildCategories({
    required List<EventTypeEntity> eventTypes,
    required AppLocalizations l10n,
  }) {
    return [
      EventCategoryEntity(
        id: AppConstants.categoryIdAll,
        label: l10n.categoryAll,
        icon: Icons.apps_outlined,
      ),
      ...eventTypes.map(
        (type) => EventCategoryEntity(
          id: type.slug,
          label: _localizedTypeLabel(l10n, type.slug, type.name),
          icon: _iconForSlug(type.slug),
          eventTypeSlug: type.slug,
        ),
      ),
    ];
  }

  static String _localizedTypeLabel(
    AppLocalizations l10n,
    String slug,
    String apiName,
  ) {
    switch (slug) {
      case AppConstants.categoryIdParties:
        return l10n.categoryParties;
      case AppConstants.categoryIdConcerts:
        return l10n.categoryConcerts;
      case AppConstants.categoryIdSports:
        return l10n.categorySports;
      default:
        return apiName.isEmpty ? slug : apiName;
    }
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
