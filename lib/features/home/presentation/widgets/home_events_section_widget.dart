import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/section_header_widget.dart';
import 'package:youpass/core/widgets/shimmer/event_list_card_shimmer.dart';
import 'package:youpass/core/widgets/shimmer/youpass_shimmer.dart';
import 'package:youpass/features/events/domain/entities/event_entity.dart';
import 'package:youpass/features/home/presentation/widgets/event_list_card_widget.dart';
import 'package:youpass/features/home/presentation/widgets/home_near_me_button_widget.dart';

class HomeEventsSectionWidget extends StatelessWidget {
  const HomeEventsSectionWidget({
    super.key,
    required this.events,
    this.sectionTitle,
    this.onSeeAllTap,
    this.onEventTap,
    this.onJoinWaitlist,
    this.onLeaveWaitlist,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.showProximity = false,
    this.nearMeEnabled = false,
    this.nearMeLoading = false,
    this.onNearMeTap,
  });

  final List<EventEntity> events;
  final String? sectionTitle;
  final VoidCallback? onSeeAllTap;
  final ValueChanged<EventEntity>? onEventTap;
  final ValueChanged<EventEntity>? onJoinWaitlist;
  final ValueChanged<EventEntity>? onLeaveWaitlist;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final bool showProximity;
  final bool nearMeEnabled;
  final bool nearMeLoading;
  final VoidCallback? onNearMeTap;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeaderWidget(
          title: sectionTitle ?? AppStrings.eventsSectionTitle(l10n),
          actionLabel: AppStrings.seeAll(l10n),
          onActionTap: onSeeAllTap,
        ),
        if (onNearMeTap != null) ...[
          SizedBox(height: layout.spacing(10)),
          HomeNearMeButtonWidget(
            isEnabled: nearMeEnabled,
            isLoading: nearMeLoading,
            onPressed: onNearMeTap,
          ),
        ],
        SizedBox(height: layout.spacing(14)),
        if (isLoading)
          const YouPassShimmer(
            child: Column(
              children: [
                EventListCardShimmer(),
                EventListCardShimmer(),
                EventListCardShimmer(),
              ],
            ),
          )
        else if (events.isEmpty)
          Padding(
            padding: EdgeInsets.symmetric(vertical: layout.spacing(24)),
            child: Center(
              child: Text(
                AppStrings.homeNoEventsFound(l10n),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: layout.fontSize(14),
                ),
              ),
            ),
          )
        else ...[
          ...events.map(
            (event) => Padding(
              padding: EdgeInsets.only(bottom: layout.spacing(14)),
              child: EventListCardWidget(
                event: event,
                showProximity: showProximity,
                onEventTap:
                    onEventTap == null ? null : () => onEventTap!(event),
                onJoinWaitlist: onJoinWaitlist == null
                    ? null
                    : () => onJoinWaitlist!(event),
                onLeaveWaitlist: onLeaveWaitlist == null
                    ? null
                    : () => onLeaveWaitlist!(event),
              ),
            ),
          ),
          if (isLoadingMore)
            Padding(
              padding: EdgeInsets.symmetric(vertical: layout.spacing(16)),
              child: const Center(
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            )
          else if (!hasMore)
            Padding(
              padding: EdgeInsets.symmetric(vertical: layout.spacing(20)),
              child: Center(
                child: Text(
                  AppStrings.homeEventsEndOfList(l10n),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: layout.fontSize(13),
                  ),
                ),
              ),
            ),
        ],
      ],
    );
  }
}
