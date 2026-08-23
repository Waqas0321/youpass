import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/l10n/app_message_localizer.dart';
import 'package:youpass/core/widgets/app_text.dart';
import 'package:youpass/core/widgets/app_text_variant.dart';
import 'package:youpass/core/widgets/youpass_branded_app_bar_widget.dart';
import 'package:youpass/dependency_injection/injection_container.dart';
import 'package:youpass/features/favorites/presentation/favorites_design_spec.dart';
import 'package:youpass/features/favorites/presentation/providers/favorites_provider.dart';
import 'package:youpass/features/favorites/presentation/routes/producer_events_route_args.dart';
import 'package:youpass/features/favorites/presentation/widgets/favorite_producer_card_widget.dart';
import 'package:youpass/features/favorites/presentation/widgets/favorites_footer_counters_widget.dart';
import 'package:youpass/features/favorites/presentation/widgets/favorites_list_shimmer.dart';
import 'package:youpass/features/favorites/presentation/widgets/favorites_search_field_widget.dart';
import 'package:youpass/features/favorites/presentation/widgets/favorites_section_header_widget.dart';
import 'package:youpass/features/home/presentation/utils/app_drawer_navigation.dart';
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
    if (favoritesProvider.producersCount == 0) {
      return AppStrings.favoritesEventsEmpty(strings);
    }
    if (favoritesProvider.visibleProducers.isEmpty) {
      return AppStrings.favoritesNoSearchResults(strings);
    }
    return AppStrings.favoritesEventsEmpty(strings);
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final horizontalPadding =
        FavoritesDesignSpec.px(context, FavoritesDesignSpec.horizontalPadding);
    final hasProducers = favoritesProvider.visibleProducers.isNotEmpty;

    return AppDrawerNavigation.wrap(
      scaffoldKey: scaffoldKey,
      context: context,
      appBar: YouPassBrandedAppBarWidget(
        onBack: () => AppDrawerNavigation.goBackToHome(context),
        primaryColor: FavoritesDesignSpec.primary,
      ),
      body: favoritesProvider.isLoading
          ? const FavoritesListShimmer()
          : favoritesProvider.errorMessage != null &&
                  favoritesProvider.producersCount == 0
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
                      SizedBox(height: FavoritesDesignSpec.px(context, 18)),
                      if (hasProducers)
                        ...favoritesProvider.visibleProducers.map(
                          (producer) => FavoriteProducerCardWidget(
                            producer: producer,
                            isUnfollowPending: favoritesProvider.producerPendingIds
                                .contains(producer.id),
                            onUnfollow: () =>
                                favoritesProvider.unfollowProducer(producer.id),
                            onViewEvents: () {
                              Navigator.of(context).pushNamed(
                                AppRoutes.producerEvents,
                                arguments: ProducerEventsRouteArgs(
                                  producer: producer,
                                ),
                              );
                            },
                          ),
                        )
                      else
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
                              if (favoritesProvider.producersCount == 0) ...[
                                SizedBox(
                                  height: FavoritesDesignSpec.px(context, 16),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      AppDrawerNavigation.navigateToAllEvents(
                                    context,
                                  ),
                                  child: Text(
                                    AppStrings.favoritesExploreCta(strings),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      if (hasProducers) ...[
                        SizedBox(height: FavoritesDesignSpec.px(context, 16)),
                        FavoritesFooterCountersWidget(
                          producersCount: favoritesProvider.producersCount,
                        ),
                      ],
                    ],
                  ),
                ),
    );
  }
}
