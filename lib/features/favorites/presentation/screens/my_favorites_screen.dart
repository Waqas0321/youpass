import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/features/favorites/domain/entities/favorite_producer_entity.dart';
import 'package:youpass/features/favorites/domain/entities/favorite_producer_filter.dart';
import 'package:youpass/features/favorites/presentation/data/favorites_mock_data.dart';
import 'package:youpass/features/favorites/presentation/favorites_design_spec.dart';
import 'package:youpass/features/favorites/presentation/routes/producer_events_route_args.dart';
import 'package:youpass/features/favorites/presentation/utils/favorites_text_factory.dart';
import 'package:youpass/features/favorites/presentation/widgets/favorite_producer_card_widget.dart';
import 'package:youpass/features/favorites/presentation/widgets/favorites_branded_app_bar_widget.dart';
import 'package:youpass/features/favorites/presentation/widgets/favorites_filter_chip_widget.dart';
import 'package:youpass/features/favorites/presentation/widgets/favorites_search_field_widget.dart';
import 'package:youpass/features/favorites/presentation/widgets/favorites_section_header_widget.dart';
import 'package:youpass/routes/app_routes.dart';

class MyFavoritesScreen extends StatefulWidget {
  const MyFavoritesScreen({super.key});

  @override
  State<MyFavoritesScreen> createState() => _MyFavoritesScreenState();
}

class _MyFavoritesScreenState extends State<MyFavoritesScreen> {
  FavoriteProducerFilter selectedFilter = FavoriteProducerFilter.all;
  String searchQuery = '';
  late List<FavoriteProducerEntity> allProducers;
  late List<FavoriteProducerEntity> visibleProducers;

  @override
  void initState() {
    super.initState();
    allProducers = List<FavoriteProducerEntity>.from(FavoritesMockData.producers);
    applyFilters();
  }

  void applyFilters() {
    final query = searchQuery.trim().toLowerCase();
    visibleProducers = allProducers.where((producer) {
      final matchesFilter = selectedFilter == FavoriteProducerFilter.all ||
          producer.tags.contains(selectedFilter);
      final matchesSearch = query.isEmpty ||
          producer.name.toLowerCase().contains(query);
      return matchesFilter && matchesSearch;
    }).toList();
  }

  void updateSearch(String value) {
    setState(() {
      searchQuery = value;
      applyFilters();
    });
  }

  void updateFilter(FavoriteProducerFilter filter) {
    setState(() {
      selectedFilter = filter;
      applyFilters();
    });
  }

  void toggleFavorite(String producerId) {
    setState(() {
      allProducers = allProducers
          .map(
            (producer) => producer.id == producerId
                ? FavoriteProducerEntity(
                    id: producer.id,
                    name: producer.name,
                    imageAssetPath: producer.imageAssetPath,
                    coverageLabel: producer.coverageLabel,
                    isFavorite: !producer.isFavorite,
                    tags: producer.tags,
                  )
                : producer,
          )
          .toList();
      applyFilters();
    });
  }

  void openProducerEvents(FavoriteProducerEntity producer) {
    Navigator.of(context).pushNamed(
      AppRoutes.producerEvents,
      arguments: ProducerEventsRouteArgs(
        producerId: producer.id,
        producerName: producer.name,
        imageAssetPath: producer.imageAssetPath,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final horizontalPadding =
        FavoritesDesignSpec.px(context, FavoritesDesignSpec.horizontalPadding);

    return Scaffold(
      backgroundColor: FavoritesDesignSpec.screenBackground,
      appBar: FavoritesBrandedAppBarWidget(
        screenTitle: AppStrings.drawerMyFavorites(strings),
        onBack: () => Navigator.of(context).pop(),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(
          horizontalPadding,
          FavoritesDesignSpec.px(context, 8),
          horizontalPadding,
          FavoritesDesignSpec.px(context, 24),
        ),
        children: [
          FavoritesSectionHeaderWidget(
            title: AppStrings.drawerMyFavorites(strings),
            subtitle: AppStrings.favoritesSubtitle(strings),
          ),
          SizedBox(height: FavoritesDesignSpec.px(context, 16)),
          FavoritesSearchFieldWidget(
            hintText: AppStrings.favoritesSearchHint(strings),
            onChanged: updateSearch,
          ),
          SizedBox(height: FavoritesDesignSpec.px(context, 14)),
          Text(
            AppStrings.favoritesFiltersLabel(strings),
            style: TextStyle(
              fontSize: FavoritesDesignSpec.px(context, 11),
              fontWeight: FontWeight.w600,
              color: FavoritesDesignSpec.bodyText,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: FavoritesDesignSpec.px(context, 8)),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                FavoritesFilterChipWidget(
                  label: AppStrings.favoritesFilterAll(strings),
                  isSelected: selectedFilter == FavoriteProducerFilter.all,
                  onTap: () => updateFilter(FavoriteProducerFilter.all),
                ),
                SizedBox(width: FavoritesDesignSpec.px(context, 8)),
                FavoritesFilterChipWidget(
                  label: AppStrings.favoritesFilterUpcoming(strings),
                  isSelected: selectedFilter == FavoriteProducerFilter.upcoming,
                  onTap: () => updateFilter(FavoriteProducerFilter.upcoming),
                ),
                SizedBox(width: FavoritesDesignSpec.px(context, 8)),
                FavoritesFilterChipWidget(
                  label: AppStrings.favoritesFilterParties(strings),
                  isSelected: selectedFilter == FavoriteProducerFilter.parties,
                  onTap: () => updateFilter(FavoriteProducerFilter.parties),
                ),
                SizedBox(width: FavoritesDesignSpec.px(context, 8)),
                FavoritesFilterChipWidget(
                  label: AppStrings.favoritesFilterVip(strings),
                  isSelected: selectedFilter == FavoriteProducerFilter.vip,
                  onTap: () => updateFilter(FavoriteProducerFilter.vip),
                ),
              ],
            ),
          ),
          SizedBox(height: FavoritesDesignSpec.px(context, 16)),
          ...visibleProducers.map(
            (producer) => FavoriteProducerCardWidget(
              producer: producer,
              description: FavoritesTextFactory.producerDescription(
                strings,
                producer.id,
              ),
              onViewEvents: () => openProducerEvents(producer),
              onFavoriteToggle: () => toggleFavorite(producer.id),
            ),
          ),
          SizedBox(height: FavoritesDesignSpec.px(context, 8)),
          Row(
            children: [
              Icon(
                Icons.favorite,
                size: FavoritesDesignSpec.px(context, 16),
                color: FavoritesDesignSpec.favoriteActive,
              ),
              SizedBox(width: FavoritesDesignSpec.px(context, 8)),
              Text(
                AppStrings.favoritesSavedProducersCount(
                  strings,
                  allProducers.where((p) => p.isFavorite).length,
                ),
                style: TextStyle(
                  fontSize: FavoritesDesignSpec.px(context, 12),
                  color: FavoritesDesignSpec.bodyText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
