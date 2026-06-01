import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_colors.dart';
import 'package:youpass/core/constants/app_constants.dart';
import 'package:youpass/features/home/data/models/home_feed_labels.dart';
import 'package:youpass/features/home/data/models/home_feed_model.dart';
import 'package:youpass/features/home/domain/entities/event_category_entity.dart';
import 'package:youpass/features/home/domain/entities/event_item_entity.dart';
import 'package:youpass/features/home/domain/entities/featured_event_entity.dart';

class HomeMockData {
  HomeMockData._();

  static HomeFeedModel buildFeed({required HomeFeedLabels labels}) {
    return HomeFeedModel(
      categories: [
        EventCategoryEntity(
          id: AppConstants.categoryIdChile,
          label: labels.chileLabel,
          icon: Icons.location_on_outlined,
        ),
        EventCategoryEntity(
          id: AppConstants.categoryIdParties,
          label: labels.partiesLabel,
          icon: Icons.celebration_outlined,
        ),
        EventCategoryEntity(
          id: AppConstants.categoryIdConcerts,
          label: labels.concertsLabel,
          icon: Icons.music_note_outlined,
        ),
        EventCategoryEntity(
          id: AppConstants.categoryIdSports,
          label: labels.sportsLabel,
          icon: Icons.sports_soccer_outlined,
        ),
      ],
      featuredEvents: [
        FeaturedEventEntity(
          id: AppConstants.featuredEventIdPrimavera,
          title: labels.featuredTitle,
          dateTimeLabel: labels.featuredDate,
          locationLabel: labels.featuredLocation,
          backgroundColors: AppColors.homeFeaturedPrimaveraGradient,
        ),
        FeaturedEventEntity(
          id: AppConstants.featuredEventIdSummerBeats,
          title: labels.featuredSummerTitle,
          dateTimeLabel: labels.featuredDate,
          locationLabel: labels.featuredLocation,
          backgroundColors: AppColors.homeFeaturedSummerGradient,
        ),
        FeaturedEventEntity(
          id: AppConstants.featuredEventIdUrbanNight,
          title: labels.featuredUrbanTitle,
          dateTimeLabel: labels.featuredDate,
          locationLabel: labels.featuredLocation,
          backgroundColors: AppColors.homeFeaturedUrbanGradient,
        ),
      ],
      events: [
        EventItemEntity(
          id: AppConstants.eventIdCaribeNight,
          title: labels.eventCaribeTitle,
          dateLabel: labels.caribeDate,
          locationLabel: labels.caribeLocation,
          thumbnailColors: AppColors.homeEventCaribeGradient,
        ),
        EventItemEntity(
          id: AppConstants.eventIdRockAlParque,
          title: labels.eventRockTitle,
          dateLabel: labels.rockDate,
          locationLabel: labels.rockLocation,
          thumbnailColors: AppColors.homeEventRockGradient,
        ),
      ],
    );
  }
}
