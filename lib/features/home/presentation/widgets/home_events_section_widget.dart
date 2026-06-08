import 'package:flutter/material.dart';
import 'package:youpass/core/constants/app_strings.dart';
import 'package:youpass/core/l10n/app_localizations_extension.dart';
import 'package:youpass/core/utils/responsive_layout.dart';
import 'package:youpass/core/widgets/section_header_widget.dart';
import 'package:youpass/features/events/domain/entities/event_entity.dart';
import 'package:youpass/features/home/presentation/widgets/event_list_card_widget.dart';

class HomeEventsSectionWidget extends StatelessWidget {
  const HomeEventsSectionWidget({
    super.key,
    required this.events,
    this.onFavoriteTap,
    this.isFavoritePending,
    this.onSeeAllTap,
    this.onBuyTickets,
    this.onEventTap,
  });

  final List<EventEntity> events;
  final ValueChanged<String>? onFavoriteTap;
  final bool Function(String eventId)? isFavoritePending;
  final VoidCallback? onSeeAllTap;
  final ValueChanged<EventEntity>? onBuyTickets;
  final ValueChanged<EventEntity>? onEventTap;

  @override
  Widget build(BuildContext context) {
    final layout = ResponsiveLayout(context);
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeaderWidget(
          title: AppStrings.eventsSectionTitle(l10n),
          actionLabel: AppStrings.seeAll(l10n),
          onActionTap: onSeeAllTap,
        ),
        SizedBox(height: layout.spacing(14)),
        if (events.isEmpty)
          Padding(
            padding: EdgeInsets.symmetric(vertical: layout.spacing(24)),
            child: Center(
              child: Text(
                AppStrings.homeNoEventsFound(l10n),
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: layout.fontSize(14),
                ),
              ),
            ),
          )
        else
          ...events.map(
            (event) => Padding(
              padding: EdgeInsets.only(bottom: layout.spacing(12)),
              child: EventListCardWidget(
                event: event,
                onEventTap:
                    onEventTap == null ? null : () => onEventTap!(event),
                onBuyTickets: onBuyTickets == null
                    ? null
                    : () => onBuyTickets!(event),
                onFavoriteTap: onFavoriteTap == null
                    ? null
                    : () => onFavoriteTap!(event.id),
                isFavoritePending: isFavoritePending?.call(event.id) ?? false,
              ),
            ),
          ),
      ],
    );
  }
}
