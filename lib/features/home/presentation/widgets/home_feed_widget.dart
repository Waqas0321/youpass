import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/shimmer/home_events_section_shimmer.dart';
import 'package:youpass/features/home/domain/entities/home_feed_entity.dart';
import 'package:youpass/features/home/presentation/providers/home_provider.dart';
import 'package:youpass/features/home/presentation/widgets/featured_event_carousel_widget.dart';
import 'package:youpass/features/home/presentation/widgets/home_active_filter_chips_widget.dart';
import 'package:youpass/features/home/presentation/widgets/home_category_filters_widget.dart';
import 'package:youpass/features/events/presentation/utils/event_detail_screen_actions.dart';
import 'package:youpass/features/vip_venue/presentation/utils/vip_purchase_screen_actions.dart';
import 'package:youpass/features/home/presentation/widgets/home_events_section_widget.dart';
import 'package:youpass/features/home/presentation/widgets/home_country_picker_sheet.dart';
import 'package:youpass/features/home/presentation/widgets/home_greeting_widget.dart';
import 'package:youpass/features/home/presentation/widgets/home_location_sheet.dart';
import 'package:youpass/features/home/presentation/widgets/home_search_bar_widget.dart';
import 'package:youpass/features/home/presentation/widgets/home_search_filters_sheet.dart';
import 'package:youpass/features/home/presentation/widgets/home_search_results_panel_widget.dart';
import 'package:youpass/features/home/presentation/widgets/pending_invitation_highlight_widget.dart';
import 'package:provider/provider.dart';
import 'package:youpass/features/home/presentation/utils/banner_slide_actions.dart';
import 'package:youpass/features/events/domain/entities/event_entity.dart';
import 'package:youpass/features/invitations/presentation/providers/invitations_provider.dart';
import 'package:youpass/features/waitlist/domain/entities/waitlist_entry_entity.dart';
import 'package:youpass/features/waitlist/presentation/utils/waitlist_flow_actions.dart';
import 'package:youpass/features/waitlist/presentation/widgets/waitlist_offer_banner_widget.dart';

class HomeFeedWidget extends StatefulWidget {
  const HomeFeedWidget({
    super.key,
    required this.feed,
    this.greetingText,
    this.upcomingSectionTitle,
    this.highlightPendingInvitation = false,
    this.pendingInvitationCount = 0,
    this.pendingInvitationTitle,
    this.onPendingInvitationTap,
    this.scrollController,
    this.onRefresh,
  });

  final HomeFeedEntity feed;
  final String? greetingText;
  final String? upcomingSectionTitle;
  final bool highlightPendingInvitation;
  final int pendingInvitationCount;
  final String? pendingInvitationTitle;
  final VoidCallback? onPendingInvitationTap;
  final ScrollController? scrollController;
  final Future<void> Function()? onRefresh;

  @override
  State<HomeFeedWidget> createState() => _HomeFeedWidgetState();
}

class _HomeFeedWidgetState extends State<HomeFeedWidget> {
  late final TextEditingController _searchController;
  late final FocusNode _searchFocusNode;
  late final HomeProvider _homeProvider;

  @override
  void initState() {
    super.initState();
    _homeProvider = context.read<HomeProvider>();
    _searchController = TextEditingController(text: _homeProvider.searchQuery);
    _searchFocusNode = FocusNode();
    _homeProvider.addListener(_syncSearchControllerFromProvider);
  }

  void _syncSearchControllerFromProvider() {
    if (_searchController.text == _homeProvider.searchQuery) {
      return;
    }
    _searchController.value = TextEditingValue(
      text: _homeProvider.searchQuery,
      selection: TextSelection.collapsed(offset: _homeProvider.searchQuery.length),
    );
  }

  @override
  void dispose() {
    _homeProvider.removeListener(_syncSearchControllerFromProvider);
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final l10n = context.l10n;
    final homeProvider = context.watch<HomeProvider>();
    final invitationsProvider = context.watch<InvitationsProvider>();
    final waitlistActions = WaitlistFlowActions(context);
    final activeOffer = _findActiveWaitlistOffer(invitationsProvider.waitlistEntries);

    void handleJoinWaitlist(EventEntity event) {
      waitlistActions.openJoinScreen(
        eventId: event.id,
        eventTitle: event.title,
      );
    }

    void handleLeaveWaitlist(EventEntity event) {
      waitlistActions.leaveWaitlistForEvent(eventId: event.id);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        HomeGreetingWidget(
          greetingText: widget.greetingText,
        ),
        if (widget.highlightPendingInvitation && widget.onPendingInvitationTap != null) ...[
          SizedBox(height: layout.spacing(14)),
          PendingInvitationHighlightWidget(
            pendingCount: widget.pendingInvitationCount,
            eventTitle: widget.pendingInvitationTitle,
            onTap: widget.onPendingInvitationTap!,
          ),
        ],
        if (activeOffer != null) ...[
          SizedBox(height: layout.spacing(14)),
          WaitlistOfferBannerWidget(
            expiresInLabel: activeOffer.expiresInLabel ?? activeOffer.expiresAtLabel ?? '',
            onTap: () => waitlistActions.claimSlot(activeOffer),
          ),
        ],
        SizedBox(height: layout.spacing(16)),
        HomeCategoryFiltersWidget(
          categories: widget.feed.categories,
          selectedCategoryId: homeProvider.resolveSelectedCategoryId(),
          onCategorySelected: (categoryId) => _handleCategoryTap(
            context,
            homeProvider: homeProvider,
            feed: widget.feed,
            categoryId: categoryId,
          ),
        ),
        SizedBox(height: layout.spacing(20)),
        Expanded(
          child: homeProvider.isFilteringEvents
              ? const HomeEventsSectionShimmer()
              : RefreshIndicator(
                  onRefresh: widget.onRefresh ?? () async {},
                  child: SingleChildScrollView(
                    controller: widget.scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (widget.feed.carouselEvents.isNotEmpty) ...[
                          FeaturedEventCarouselWidget(
                            events: widget.feed.carouselEvents,
                            carouselConfig: widget.feed.carouselConfig,
                            onEventTap: (event) =>
                                BannerSlideActions(context).handleTap(event),
                          ),
                          SizedBox(height: layout.spacing(24)),
                        ],
                        HomeEventsSectionWidget(
                          events: homeProvider.isSearchMode
                              ? homeProvider.searchResults
                              : homeProvider.upcomingEvents,
                          sectionTitle: widget.upcomingSectionTitle,
                          headerActionSemanticLabel:
                              AppStrings.homeLocationSheetTitle(l10n),
                          headerActionIcon: homeProvider.hasActiveLocationContext
                              ? Icons.location_on
                              : Icons.location_on_outlined,
                          headerActionIconSize: layout.fontSize(17 * 1.35),
                          headerActionSelected:
                              homeProvider.hasActiveLocationContext,
                          headerActionLoading: homeProvider.isNearMeLoading,
                          onHeaderActionTap: () =>
                              HomeLocationSheet.show(context),
                          isLoading: homeProvider.isSearchMode
                              ? homeProvider.isSearchLoading
                              : homeProvider.isLoadingUpcoming ||
                                  homeProvider.isFilteringEvents,
                          belowTitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              HomeSearchBarWidget(
                                hintText: widget.feed.searchPlaceholder ??
                                    AppStrings.homeSearchPlaceholder(l10n),
                                controller: _searchController,
                                focusNode: _searchFocusNode,
                                onChanged: homeProvider.onSearchQueryChanged,
                                onSubmitted: homeProvider.submitSearch,
                                onFocusChanged: homeProvider.setSearchFocused,
                                onFilterTap: () => HomeSearchFiltersSheet.show(context),
                                filtersEnabled: widget.feed.searchConfig.filtersEnabled,
                              ),
                              SizedBox(height: layout.spacing(10)),
                              HomeActiveFilterChipsWidget(
                                chips: homeProvider.activeFilterChips(
                                  freeOnlyLabel: AppStrings.homeFiltersFreeOnly(l10n),
                                  customRangeLabel: AppStrings.homeFiltersCustomRange(l10n),
                                  nearMeLabel: AppStrings.homeLocationActiveNearby(l10n),
                                ),
                                onRemove: homeProvider.removeFilterChip,
                              ),
                              if (homeProvider.showSearchHistory) ...[
                                SizedBox(height: layout.spacing(10)),
                                HomeSearchResultsPanelWidget(
                                  isFocused: true,
                                  searchQuery: '',
                                  isLoading: false,
                                  results: const [],
                                  history: homeProvider.searchHistory,
                                  suggestions: const [],
                                  emptyMessage: AppStrings.homeSearchEmpty(l10n),
                                  onHistoryTap: homeProvider.selectHistoryTerm,
                                  onSuggestionTap: homeProvider.submitSearch,
                                  onClearHistory: homeProvider.clearSearchHistory,
                                ),
                              ],
                            ],
                          ),
                          onEventTap: (event) =>
                              EventDetailScreenActions(context).openEventDetail(event: event),
                          onBuyTicket: (event) =>
                              VipPurchaseScreenActions(context).openTicketSelection(event: event),
                          onFavoriteTap: (event) => homeProvider.toggleFavorite(event.id),
                          isFavoritePendingFor: homeProvider.isFavoritePending,
                          onJoinWaitlist: handleJoinWaitlist,
                          onLeaveWaitlist: handleLeaveWaitlist,
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ],
    );
  }

  Future<void> _handleCategoryTap(
    BuildContext context, {
    required HomeProvider homeProvider,
    required HomeFeedEntity feed,
    required String categoryId,
  }) async {
    if (homeProvider.isCountryCategory(categoryId)) {
      final currentCode = homeProvider.resolveSessionCountryCode() ?? 'CL';
      final selected = await HomeCountryPickerSheet.show(
        context,
        selectedCountryCode: currentCode,
      );
      if (selected == null || !context.mounted) {
        return;
      }
      await homeProvider.changeSessionCountry(selected);
      return;
    }

    await homeProvider.selectCategory(categoryId);
  }

  WaitlistEntryEntity? _findActiveWaitlistOffer(
    List<WaitlistEntryEntity> entries,
  ) {
    for (final entry in entries) {
      if (entry.canClaim) {
        return entry;
      }
    }
    return null;
  }
}
