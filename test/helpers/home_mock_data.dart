import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_constants.dart';
import 'package:youpass/features/events/domain/entities/event_entity.dart';
import 'package:youpass/features/home/data/models/home_feed_labels.dart';
import 'package:youpass/features/home/data/models/home_feed_model.dart';
import 'package:youpass/features/home/domain/entities/event_category_entity.dart';

class HomeMockData {
  HomeMockData._();

  static HomeFeedModel buildFeed({required HomeFeedLabels labels}) {
    final carouselEvents = [
      EventEntity(
        id: AppConstants.featuredEventIdPrimavera,
        title: labels.featuredTitle,
        dateTimeLabel: labels.featuredDate,
        dateLabel: labels.featuredDate,
        locationLabel: labels.featuredLocation,
      ),
      EventEntity(
        id: AppConstants.featuredEventIdSummerBeats,
        title: labels.featuredSummerTitle,
        dateTimeLabel: labels.featuredDate,
        dateLabel: labels.featuredDate,
        locationLabel: labels.featuredLocation,
      ),
    ];

    final featuredEvents = [
      EventEntity(
        id: AppConstants.eventIdCaribeNight,
        title: labels.eventCaribeTitle,
        dateTimeLabel: labels.caribeDate,
        dateLabel: labels.caribeDate,
        locationLabel: labels.caribeLocation,
      ),
      EventEntity(
        id: AppConstants.eventIdRockAlParque,
        title: labels.eventRockTitle,
        dateTimeLabel: labels.rockDate,
        dateLabel: labels.rockDate,
        locationLabel: labels.rockLocation,
      ),
    ];

    return HomeFeedModel(
      categories: [
        EventCategoryEntity(
          id: AppConstants.categoryIdAll,
          label: labels.allLabel,
          icon: Icons.apps_outlined,
          leadingEmoji: AppConstants.categoryAllEmoji,
        ),
        EventCategoryEntity(
          id: 'country:CL',
          label: labels.chileLabel,
          icon: Icons.location_on_outlined,
          countryCode: 'CL',
        ),
        EventCategoryEntity(
          id: AppConstants.categoryIdParties,
          label: labels.partiesLabel,
          icon: Icons.celebration_outlined,
          eventTypeSlug: AppConstants.categoryIdParties,
        ),
        EventCategoryEntity(
          id: AppConstants.categoryIdConcerts,
          label: labels.concertsLabel,
          icon: Icons.music_note_outlined,
          eventTypeSlug: AppConstants.categoryIdConcerts,
        ),
        EventCategoryEntity(
          id: AppConstants.categoryIdSports,
          label: labels.sportsLabel,
          icon: Icons.sports_soccer_outlined,
          eventTypeSlug: AppConstants.categoryIdSports,
        ),
      ],
      carouselEvents: carouselEvents,
      featuredEvents: featuredEvents,
    );
  }
}
