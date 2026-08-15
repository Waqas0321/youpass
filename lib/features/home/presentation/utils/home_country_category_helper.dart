import 'package:flutter/material.dart';
import 'package:youpass/core/constants/country_code_list.dart';
import 'package:youpass/features/home/domain/entities/event_category_entity.dart';
import 'package:youpass/features/home/domain/entities/home_feed_entity.dart';

class HomeCountryCategoryHelper {
  HomeCountryCategoryHelper._();

  static EventCategoryEntity fromCountryCode(String countryCode) {
    final normalized = countryCode.toUpperCase();
    final country = CountryCodeList.findByIsoCode(normalized);

    return EventCategoryEntity(
      id: 'country:$normalized',
      label: normalized,
      icon: Icons.location_on_outlined,
      leadingEmoji: country.flagEmoji,
      showLeadingIcon: true,
      countryCode: normalized,
    );
  }

  static HomeFeedEntity applySessionCountry(
    HomeFeedEntity feed,
    String countryCode,
  ) {
    final countryCategory = fromCountryCode(countryCode);
    final updatedCategories = <EventCategoryEntity>[countryCategory];

    for (final category in feed.categories) {
      if (category.id.startsWith('country:')) {
        continue;
      }
      updatedCategories.add(category);
    }

    return feed.copyWith(categories: updatedCategories);
  }
}
