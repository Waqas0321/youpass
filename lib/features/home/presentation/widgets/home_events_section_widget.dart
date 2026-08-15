import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/section_header_widget.dart';
import 'package:youpass/core/widgets/shimmer/event_list_card_shimmer.dart';
import 'package:youpass/core/widgets/shimmer/youpass_shimmer.dart';
import 'package:youpass/features/events/domain/entities/event_entity.dart';
import 'package:youpass/features/home/presentation/widgets/event_list_card_widget.dart';

class HomeEventsSectionWidget extends StatelessWidget {
  const HomeEventsSectionWidget({
    super.key,
    required this.events,
    this.sectionTitle,
    this.headerActionLabel,
    this.headerActionSemanticLabel,
    this.onHeaderActionTap,
    this.headerActionIcon,
    this.headerActionIconSize,
    this.headerActionSelected = false,
    this.headerActionLoading = false,
    this.onEventTap,
    this.onBuyTicket,
    this.onFavoriteTap,
    this.isFavoritePendingFor,
    this.onJoinWaitlist,
    this.onLeaveWaitlist,
    this.isLoading = false,
    this.belowTitle,
  });

  final List<EventEntity> events;
  final String? sectionTitle;
  final String? headerActionLabel;
  final String? headerActionSemanticLabel;
  final VoidCallback? onHeaderActionTap;
  final IconData? headerActionIcon;
  final double? headerActionIconSize;
  final bool headerActionSelected;
  final bool headerActionLoading;
  final ValueChanged<EventEntity>? onEventTap;
  final ValueChanged<EventEntity>? onBuyTicket;
  final ValueChanged<EventEntity>? onFavoriteTap;
  final bool Function(String eventId)? isFavoritePendingFor;
  final ValueChanged<EventEntity>? onJoinWaitlist;
  final ValueChanged<EventEntity>? onLeaveWaitlist;
  final bool isLoading;
  final Widget? belowTitle;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeaderWidget(
          title: sectionTitle ?? AppStrings.eventsSectionTitle(l10n),
          actionLabel: headerActionLabel,
          actionSemanticLabel: headerActionSemanticLabel,
          onActionTap: onHeaderActionTap,
          actionIcon: headerActionIcon,
          actionIconSize: headerActionIconSize,
          actionSelected: headerActionSelected,
          actionLoading: headerActionLoading,
        ),
        if (belowTitle != null) ...[
          SizedBox(height: layout.spacing(14)),
          belowTitle!,
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
                isFavoritePending: isFavoritePendingFor?.call(event.id) ?? false,
                onEventTap:
                    onEventTap == null ? null : () => onEventTap!(event),
                onBuyTicket: onBuyTicket == null
                    ? null
                    : () => onBuyTicket!(event),
                onFavoriteTap: onFavoriteTap == null
                    ? null
                    : () => onFavoriteTap!(event),
                onJoinWaitlist: onJoinWaitlist == null
                    ? null
                    : () => onJoinWaitlist!(event),
                onLeaveWaitlist: onLeaveWaitlist == null
                    ? null
                    : () => onLeaveWaitlist!(event),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
