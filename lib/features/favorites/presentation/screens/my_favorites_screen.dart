import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/l10n/app_message_localizer.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/core/widgets/youpass_branded_app_bar_widget.dart';
import 'package:youpass/dependency_injection/injection_container.dart';
import 'package:youpass/features/events/presentation/utils/event_detail_screen_actions.dart';
import 'package:youpass/features/events/presentation/widgets/event_browse_card_widget.dart';
import 'package:youpass/features/favorites/presentation/favorites_design_spec.dart';
import 'package:youpass/features/favorites/presentation/providers/favorites_provider.dart';
import 'package:youpass/features/favorites/presentation/routes/producer_events_route_args.dart';
import 'package:youpass/features/favorites/presentation/widgets/favorite_producer_card_widget.dart';
import 'package:youpass/features/favorites/presentation/widgets/favorites_filter_pills_widget.dart';
import 'package:youpass/features/favorites/presentation/widgets/favorites_footer_counters_widget.dart';
import 'package:youpass/features/favorites/presentation/widgets/favorites_list_shimmer.dart';
import 'package:youpass/features/favorites/presentation/widgets/favorites_search_field_widget.dart';
import 'package:youpass/features/favorites/presentation/widgets/favorites_section_header_widget.dart';
import 'package:youpass/features/home/presentation/utils/app_drawer_navigation.dart';
import 'package:youpass/features/vip_venue/presentation/utils/vip_purchase_screen_actions.dart';
import 'package:youpass/routes/app_routes.dart';

class MyFavoritesScreen extends StatefulWidget {
  const MyFavoritesScreen({super.key});

  @override
  State<MyFavoritesScreen> createState() => _MyFavoritesScreenState();
}

class _MyFavoritesScreenState extends State<MyFavoritesScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late final FavoritesProvider favoritesProvider;

  @override
  void initState() {
    super.initState();
    favoritesProvider = sl<FavoritesProvider>();
    favoritesProvider.addListener(_onProviderChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        favoritesProvider.loadFavorites();
      }
    });
  }

  @override
  void dispose() {
    favoritesProvider.removeListener(_onProviderChanged);
    super.dispose();
  }

  void _onProviderChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  String _emptyMessage() {
    final strings = context.l10n;
    if (favoritesProvider.isEmpty) {
      return AppStrings.favoritesEventsEmpty(strings);
    }
    if (!favoritesProvider.hasVisibleResults) {
      return AppStrings.favoritesNoSearchResults(strings);
    }
    return AppStrings.favoritesEventsEmpty(strings);
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final horizontalPadding =
        FavoritesDesignSpec.px(context, FavoritesDesignSpec.horizontalPadding);

    return AppDrawerNavigation.wrap(
      scaffoldKey: scaffoldKey,
      context: context,
      appBar: YouPassBrandedAppBarWidget(
        onMenuTap: () => AppDrawerNavigation.openDrawer(context, scaffoldKey),
        primaryColor: FavoritesDesignSpec.primary,
      ),
      body: favoritesProvider.isLoading
          ? const FavoritesListShimmer()
          : favoritesProvider.errorMessage != null && favoritesProvider.isEmpty
              ? Center(
                  child: AppText(
                    AppMessageLocalizer.fromError(
                      strings,
                      favoritesProvider.errorMessage!,
                    ),
                    variant: AppTextVariant.error,
                  ),
                )
              : RefreshIndicator(
                  onRefresh: favoritesProvider.loadFavorites,
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.fromLTRB(
                      horizontalPadding,
                      FavoritesDesignSpec.px(context, 8),
                      horizontalPadding,
                      FavoritesDesignSpec.px(context, 24),
                    ),
                    children: [
                      FavoritesSectionHeaderWidget(
                        title: AppStrings.drawerMyFavorites(strings),
                        subtitle: AppStrings.favoritesEventsSubtitle(strings),
                        leadingIcon: Icons.favorite_outline,
                        leadingIconColor: FavoritesDesignSpec.favoriteActive,
                      ),
                      SizedBox(height: FavoritesDesignSpec.px(context, 14)),
                      FavoritesSearchFieldWidget(
                        hintText: AppStrings.favoritesEventsSearchHint(strings),
                        onChanged: favoritesProvider.setSearchQuery,
                      ),
                      SizedBox(height: FavoritesDesignSpec.px(context, 14)),
                      FavoritesFilterPillsWidget(
                        selectedFilter: favoritesProvider.selectedFilter,
                        onFilterSelected: favoritesProvider.setFilter,
                      ),
                      SizedBox(height: FavoritesDesignSpec.px(context, 18)),
                      if (favoritesProvider.visibleProducers.isNotEmpty) ...[
                        Text(
                          AppStrings.favoritesSectionFollowedPromoters(strings),
                          style: TextStyle(
                            fontSize: FavoritesDesignSpec.px(context, 12),
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.4,
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                        SizedBox(height: FavoritesDesignSpec.px(context, 10)),
                        ...favoritesProvider.visibleProducers.map(
                          (producer) => FavoriteProducerCardWidget(
                            producer: producer,
                            onViewEvents: () {
                              Navigator.of(context).pushNamed(
                                AppRoutes.producerEvents,
                                arguments: ProducerEventsRouteArgs(
                                  producer: producer,
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: FavoritesDesignSpec.px(context, 8)),
                      ],
                      if (favoritesProvider.visibleEvents.isNotEmpty) ...[
                        Text(
                          AppStrings.favoritesSectionSavedEvents(strings),
                          style: TextStyle(
                            fontSize: FavoritesDesignSpec.px(context, 12),
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.4,
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                        SizedBox(height: FavoritesDesignSpec.px(context, 10)),
                        ...favoritesProvider.visibleEvents.map(
                          (event) => EventBrowseCardWidget(
                            event: event,
                            showFavorite: true,
                            isFavoritePending: favoritesProvider.eventPendingIds
                                .contains(event.id),
                            onFavoriteTap: () =>
                                favoritesProvider.removeSavedEvent(event.id),
                            onBuyTicket: () => VipPurchaseScreenActions(context)
                                .openTicketSelection(event: event),
                            onEventTap: () =>
                                EventDetailScreenActions(context).openEventDetail(
                              event: event,
                            ),
                          ),
                        ),
                      ],
                      if (!favoritesProvider.hasVisibleResults)
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: FavoritesDesignSpec.px(context, 32),
                          ),
                          child: Column(
                            children: [
                              Text(
                                _emptyMessage(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant,
                                ),
                              ),
                              if (favoritesProvider.isEmpty) ...[
                                SizedBox(
                                    height: FavoritesDesignSpec.px(context, 16)),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).popUntil(
                                      (route) => route.settings.name == AppRoutes.home,
                                    );
                                  },
                                  child: Text(
                                    AppStrings.favoritesExploreCta(strings),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      SizedBox(height: FavoritesDesignSpec.px(context, 16)),
                      FavoritesFooterCountersWidget(
                        eventsCount: favoritesProvider.eventsCount,
                        producersCount: favoritesProvider.producersCount,
                      ),
                    ],
                  ),
                ),
    );
  }
}
