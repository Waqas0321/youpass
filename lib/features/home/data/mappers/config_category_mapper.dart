import 'package:flutter/material.dart';
import 'package:youpass/core/constants/country_code_list.dart';
import 'package:youpass/core/network/models/config_category_model.dart';
import 'package:youpass/features/home/domain/entities/event_category_entity.dart';

class ConfigCategoryMapper {
  ConfigCategoryMapper._();

  static List<EventCategoryEntity> toEntities(List<ConfigCategoryModel> categories) {
    return categories
        .map(
          (category) {
            final isCountry =
                category.countryCode != null && category.countryCode!.isNotEmpty;

            return EventCategoryEntity(
              id: category.id,
              label: isCountry
                  ? (category.countryCode?.trim().toUpperCase() ??
                      _stripCountryLabelPrefix(category.label))
                  : category.label,
              icon: _iconForCategory(category),
              leadingEmoji:
                  isCountry ? _flagEmojiForCountry(category) : null,
              showLeadingIcon: true,
              countryCode: category.countryCode,
              eventTypeSlug: category.eventTypeSlug,
            );
          },
        )
        .toList();
  }

  static String _stripCountryLabelPrefix(String label) {
    final parts = label.trim().split(RegExp(r'\s+'));
    if (parts.length >= 2 && parts.first.runes.length <= 2) {
      return parts.sublist(1).join(' ');
    }
    return label;
  }

  static String? _flagEmojiForCountry(ConfigCategoryModel category) {
    final fromApi = category.flagEmoji?.trim();
    if (fromApi != null && fromApi.isNotEmpty) {
      return fromApi;
    }

    final code = category.countryCode?.trim();
    if (code == null || code.isEmpty) {
      return null;
    }

    return CountryCodeList.findByIsoCode(code).flagEmoji;
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
