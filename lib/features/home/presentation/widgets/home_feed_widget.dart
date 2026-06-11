import 'package:flutter/material.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/shimmer/home_events_section_shimmer.dart';
import 'package:youpass/features/home/domain/entities/home_feed_entity.dart';
import 'package:youpass/features/home/presentation/providers/home_provider.dart';
import 'package:youpass/features/home/presentation/widgets/featured_event_carousel_widget.dart';
import 'package:youpass/features/home/presentation/widgets/home_category_filters_widget.dart';
import 'package:youpass/features/home/presentation/widgets/home_events_section_widget.dart';
import 'package:youpass/features/home/presentation/widgets/home_greeting_widget.dart';
import 'package:youpass/features/home/presentation/widgets/pending_invitation_highlight_widget.dart';
import 'package:provider/provider.dart';
import 'package:youpass/features/events/presentation/utils/event_detail_screen_actions.dart';
import 'package:youpass/features/events/presentation/routes/all_events_route_args.dart';
import 'package:youpass/features/vip_venue/presentation/utils/vip_purchase_screen_actions.dart';
import 'package:youpass/routes/app_routes.dart';

class HomeFeedWidget extends StatelessWidget {
  const HomeFeedWidget({
    super.key,
    required this.feed,
    this.feedSubtitle,
    this.upcomingSectionTitle,
    this.highlightPendingInvitation = false,
    this.pendingInvitationCount = 0,
    this.pendingInvitationTitle,
    this.onPendingInvitationTap,
  });

  final HomeFeedEntity feed;
  final String? feedSubtitle;
  final String? upcomingSectionTitle;
  final bool highlightPendingInvitation;
  final int pendingInvitationCount;
  final String? pendingInvitationTitle;
  final VoidCallback? onPendingInvitationTap;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final homeProvider = context.watch<HomeProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        HomeGreetingWidget(
          subtitle: feedSubtitle,
        ),
        if (highlightPendingInvitation && onPendingInvitationTap != null) ...[
          SizedBox(height: layout.spacing(14)),
          PendingInvitationHighlightWidget(
            pendingCount: pendingInvitationCount,
            eventTitle: pendingInvitationTitle,
            onTap: onPendingInvitationTap!,
          ),
        ],
        SizedBox(height: layout.spacing(18)),
        HomeCategoryFiltersWidget(
          categories: feed.categories,
          selectedCategoryId: homeProvider.selectedCategoryId,
          onCategorySelected: homeProvider.selectCategory,
        ),
        SizedBox(height: layout.spacing(20)),
        if (homeProvider.isFilteringEvents)
          const HomeEventsSectionShimmer()
        else ...[
          FeaturedEventCarouselWidget(
            events: feed.carouselEvents,
            onEventTap: (event) =>
                EventDetailScreenActions(context).openEventDetail(event: event),
          ),
          SizedBox(height: layout.spacing(24)),
          HomeEventsSectionWidget(
            events: feed.featuredEvents,
            sectionTitle: upcomingSectionTitle,
            onFavoriteTap: homeProvider.toggleFavorite,
            isFavoritePending: homeProvider.isFavoritePending,
            onEventTap: (event) =>
                EventDetailScreenActions(context).openEventDetail(event: event),
            onBuyTickets: (event) =>
                VipPurchaseScreenActions(context).openTicketSelection(event: event),
            onSeeAllTap: () => Navigator.of(context).pushNamed(
              AppRoutes.allEvents,
              arguments: AllEventsRouteArgs(
                initialCategoryId: homeProvider.selectedCategoryId,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
