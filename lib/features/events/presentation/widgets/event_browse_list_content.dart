import 'package:flutter/material.dart';
import 'package:youpass/features/events/domain/entities/event_entity.dart';
import 'package:youpass/features/events/presentation/widgets/event_browse_card_widget.dart';
import 'package:youpass/features/events/presentation/widgets/event_browse_category_filters_widget.dart';
import 'package:youpass/features/favorites/presentation/favorites_design_spec.dart';
import 'package:youpass/features/favorites/presentation/widgets/favorites_search_field_widget.dart';
import 'package:youpass/features/favorites/presentation/widgets/favorites_section_header_widget.dart';
import 'package:youpass/features/home/domain/entities/event_category_entity.dart';

class EventBrowseListContent extends StatelessWidget {
  const EventBrowseListContent({
    super.key,
    required this.headerTitle,
    required this.headerSubtitle,
    required this.headerIcon,
    required this.headerIconColor,
    required this.searchHint,
    required this.onSearchChanged,
    required this.categories,
    required this.selectedCategoryId,
    required this.onCategorySelected,
    required this.visibleEvents,
    required this.emptyMessage,
    required this.footerIcon,
    required this.footerIconColor,
    required this.footerText,
    required this.onFavoriteTap,
    required this.favoritePendingIds,
    this.markAllAsFavorite = false,
    this.scrollPhysics = const AlwaysScrollableScrollPhysics(),
  });

  final String headerTitle;
  final String headerSubtitle;
  final IconData headerIcon;
  final Color headerIconColor;
  final String searchHint;
  final ValueChanged<String> onSearchChanged;
  final List<EventCategoryEntity> categories;
  final String selectedCategoryId;
  final ValueChanged<String> onCategorySelected;
  final List<EventEntity> visibleEvents;
  final String emptyMessage;
  final IconData footerIcon;
  final Color footerIconColor;
  final String footerText;
  final ValueChanged<String> onFavoriteTap;
  final Set<String> favoritePendingIds;
  final bool markAllAsFavorite;
  final ScrollPhysics scrollPhysics;

  @override
  Widget build(BuildContext context) {
    final horizontalPadding =
        FavoritesDesignSpec.px(context, FavoritesDesignSpec.horizontalPadding);

    return ListView(
      physics: scrollPhysics,
      padding: EdgeInsets.fromLTRB(
        horizontalPadding,
        FavoritesDesignSpec.px(context, 8),
        horizontalPadding,
        FavoritesDesignSpec.px(context, 24),
      ),
      children: [
        FavoritesSectionHeaderWidget(
          title: headerTitle,
          subtitle: headerSubtitle,
          leadingIcon: headerIcon,
          leadingIconColor: headerIconColor,
        ),
        SizedBox(height: FavoritesDesignSpec.px(context, 14)),
        FavoritesSearchFieldWidget(
          hintText: searchHint,
          onChanged: onSearchChanged,
        ),
        if (categories.isNotEmpty) ...[
          SizedBox(height: FavoritesDesignSpec.px(context, 14)),
          EventBrowseCategoryFiltersWidget(
            categories: categories,
            selectedCategoryId: selectedCategoryId,
            onCategorySelected: onCategorySelected,
          ),
        ],
        SizedBox(height: FavoritesDesignSpec.px(context, 16)),
        if (visibleEvents.isEmpty)
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: FavoritesDesignSpec.px(context, 32),
            ),
            child: Center(
              child: Text(
                emptyMessage,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: FavoritesDesignSpec.bodyText,
                  fontSize: FavoritesDesignSpec.px(context, 14),
                ),
              ),
            ),
          )
        else
          ...visibleEvents.map(
            (event) {
              final cardEvent =
                  markAllAsFavorite ? event.copyWith(isFavorite: true) : event;

              return EventBrowseCardWidget(
                event: cardEvent,
                onFavoriteTap: () => onFavoriteTap(event.id),
                isFavoritePending: favoritePendingIds.contains(event.id),
              );
            },
          ),
        SizedBox(height: FavoritesDesignSpec.px(context, 8)),
        Row(
          children: [
            Icon(
              footerIcon,
              size: FavoritesDesignSpec.px(context, 16),
              color: footerIconColor,
            ),
            SizedBox(width: FavoritesDesignSpec.px(context, 8)),
            Text(
              footerText,
              style: TextStyle(
                fontSize: FavoritesDesignSpec.px(context, 12),
                color: FavoritesDesignSpec.bodyText,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
