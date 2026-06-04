import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/widgets/app_asset_image.dart';
import 'package:youpass/features/favorites/domain/entities/producer_event_category.dart';
import 'package:youpass/features/favorites/domain/entities/producer_event_entity.dart';
import 'package:youpass/features/favorites/presentation/data/favorites_mock_data.dart';
import 'package:youpass/core/widgets/youpass_branded_app_bar_widget.dart';
import 'package:youpass/core/theme/youpass_themed_colors.dart';
import 'package:youpass/features/favorites/presentation/favorites_design_spec.dart';
import 'package:youpass/features/favorites/presentation/routes/producer_events_route_args.dart';
import 'package:youpass/features/favorites/presentation/widgets/favorites_search_field_widget.dart';
import 'package:youpass/features/favorites/presentation/widgets/favorites_section_header_widget.dart';
import 'package:youpass/features/favorites/presentation/widgets/producer_event_card_widget.dart';
import 'package:youpass/features/favorites/presentation/widgets/producer_event_category_chips_widget.dart';

class ProducerEventsScreen extends StatefulWidget {
  const ProducerEventsScreen({
    super.key,
    required this.args,
  });

  final ProducerEventsRouteArgs args;

  @override
  State<ProducerEventsScreen> createState() => _ProducerEventsScreenState();
}

class _ProducerEventsScreenState extends State<ProducerEventsScreen> {
  ProducerEventCategory? selectedCategory;
  String searchQuery = '';
  List<ProducerEventEntity> allEvents = const [];
  List<ProducerEventEntity> visibleEvents = const [];
  bool hasLoadedEvents = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (hasLoadedEvents) {
      return;
    }

    allEvents = List<ProducerEventEntity>.from(
      FavoritesMockData.eventsForProducer(
        widget.args.producerId,
        context.l10n,
      ),
    );
    hasLoadedEvents = true;
    applyFilters();
    setState(() {});
  }

  void applyFilters() {
    final query = searchQuery.trim().toLowerCase();
    visibleEvents = allEvents.where((event) {
      final matchesCategory =
          selectedCategory == null || event.category == selectedCategory;
      final matchesSearch =
          query.isEmpty || event.title.toLowerCase().contains(query);
      return matchesCategory && matchesSearch;
    }).toList();
  }

  void updateSearch(String value) {
    setState(() {
      searchQuery = value;
      applyFilters();
    });
  }

  void updateCategory(ProducerEventCategory? category) {
    setState(() {
      selectedCategory = category;
      applyFilters();
    });
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final horizontalPadding =
        FavoritesDesignSpec.px(context, FavoritesDesignSpec.horizontalPadding);
    final logoSize = FavoritesDesignSpec.px(context, 56);

    return Scaffold(
      appBar: YouPassBrandedAppBarWidget(
        onBack: () => Navigator.of(context).pop(),
        primaryColor: FavoritesDesignSpec.primary,
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(
          horizontalPadding,
          FavoritesDesignSpec.px(context, 8),
          horizontalPadding,
          FavoritesDesignSpec.px(context, 24),
        ),
        children: [
          Row(
            children: [
              ClipOval(
                child: AppAssetImage(
                  assetPath: widget.args.imageAssetPath,
                  width: logoSize,
                  height: logoSize,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: FavoritesDesignSpec.px(context, 12)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.args.producerName,
                      style: TextStyle(
                        fontSize: FavoritesDesignSpec.px(context, 18),
                        fontWeight: FontWeight.w700,
                        color: YouPassThemedColors.primaryText(context),
                      ),
                    ),
                    SizedBox(height: FavoritesDesignSpec.px(context, 4)),
                    Text(
                      AppStrings.favoritesProducerType(strings),
                      style: TextStyle(
                        fontSize: FavoritesDesignSpec.px(context, 13),
                        color: YouPassThemedColors.secondaryText(context),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: FavoritesDesignSpec.px(context, 20)),
          FavoritesSectionHeaderWidget(
            title: AppStrings.producerEventsUpcomingTitle(strings),
            subtitle: AppStrings.producerEventsUpcomingSubtitle(
              strings,
              widget.args.producerName,
            ),
            leadingIcon: Icons.event_available_outlined,
            leadingIconColor: FavoritesDesignSpec.primary,
          ),
          SizedBox(height: FavoritesDesignSpec.px(context, 14)),
          FavoritesSearchFieldWidget(
            hintText: AppStrings.producerEventsSearchHint(strings),
            onChanged: updateSearch,
          ),
          SizedBox(height: FavoritesDesignSpec.px(context, 12)),
          ProducerEventCategoryChipsWidget(
            selectedCategory: selectedCategory,
            onCategorySelected: updateCategory,
          ),
          SizedBox(height: FavoritesDesignSpec.px(context, 16)),
          ...visibleEvents.map(
            (event) => ProducerEventCardWidget(
              event: event,
              onBuyTicket: () {},
            ),
          ),
          SizedBox(height: FavoritesDesignSpec.px(context, 8)),
          Row(
            children: [
              Icon(
                Icons.event_note_outlined,
                size: FavoritesDesignSpec.px(context, 16),
                color: FavoritesDesignSpec.buyAccent,
              ),
              SizedBox(width: FavoritesDesignSpec.px(context, 8)),
              Text(
                AppStrings.producerEventsAvailableCount(
                  strings,
                  visibleEvents.length,
                ),
                style: TextStyle(
                  fontSize: FavoritesDesignSpec.px(context, 12),
                  color: YouPassThemedColors.secondaryText(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
